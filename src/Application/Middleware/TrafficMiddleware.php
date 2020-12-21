<?php
declare(strict_types=1);

namespace App\Application\Middleware;

use App\Domain\Traffic\Service\AddTrafficService;
use App\Domain\Traffic\Service\UpdateResponseTrafficService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\MiddlewareInterface as Middleware;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;

class TrafficMiddleware implements Middleware
{
    private $addTrafficService;
    private $updateResponseTrafficService;

    public function __construct(
        AddTrafficService $addTrafficService,
        UpdateResponseTrafficService $updateResponseTrafficService
    ) {
        $this->addTrafficService = $addTrafficService;
        $this->updateResponseTrafficService = $updateResponseTrafficService;
    }

    /**
     * {@inheritdoc}
     */
    public function process(Request $request, RequestHandler $handler): Response
    {
        $traffic = $this->addTrafficService->run($request);

        $response = $handler->handle($request);

        // TODO: capture error response

        $this->updateResponseTrafficService->run($traffic, $response);

        return $response;
    }
}
