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

class TrafficMiddleware implements Middleware
{
    private $addTrafficService;
    private $updateTrafficService;

    public function __construct(
        AddTrafficService    $addTrafficService,
        UpdateTrafficService $updateTrafficService
    )
    {
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
        } catch (Exception $e) {
            $exception = $e;
        }

        $userId = $request->getAttribute('auth')->getUserId();
        $responseCode = $exception ? $exception->getCode() : $response->getStatusCode();

        $traffic->setResponseCode($responseCode);
        $traffic->setUserId($userId);

        $this->updateTrafficService->run($traffic);

        if ($exception) throw $exception;
        return $response;
    }
}
