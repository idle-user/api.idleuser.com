<?php
declare(strict_types=1);

namespace App\Application\Middleware;

use App\Domain\Traffic\Service\AddTrafficService;
use App\Domain\Traffic\Service\UpdateTrafficService;
use Exception;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\MiddlewareInterface as Middleware;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use Psr\Log\LoggerInterface;

class TrafficMiddleware implements Middleware
{
    private $addTrafficService;
    private $updateTrafficService;

    public function __construct(
        LoggerInterface      $logger,
        AddTrafficService    $addTrafficService,
        UpdateTrafficService $updateTrafficService
    )
    {
        $this->logger = $logger;
        $this->addTrafficService = $addTrafficService;
        $this->updateTrafficService = $updateTrafficService;
    }

    /**
     * {@inheritdoc}
     */
    public function process(Request $request, RequestHandler $handler): Response
    {
        $traffic = $this->addTrafficService->run($request);

        $exception = false;
        try {
            $response = $handler->handle($request);
            $responseCode = $response->getStatusCode();
        } catch (Exception $e) {
            $exception = $e;
            $responseCode = 500;
        }

        $userId = $request->getAttribute('auth')->getUserId();
        $responseCode = $exception ? $exception->getCode() : $responseCode;

        if (!(int)$responseCode) {
            $traffic->setNote('[responseCode: . ' . $responseCode . ' .] ' . $traffic->getNote());
            $responseCode = 500;
        }

        $traffic->setResponseCode($responseCode);
        $traffic->setUserId($userId);

        $this->updateTrafficService->run($traffic);

        if ($exception) {
            $this->logger->critical($exception);
            throw $exception;
        }
        return $response;
    }
}
