<?php
declare(strict_types=1);

namespace App\Application\Middleware;

use App\Domain\Auth\Service\AuthService;
use App\Domain\Auth\Service\LogAuthService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\MiddlewareInterface as Middleware;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use Slim\Exception\HttpNotFoundException;
use Slim\Routing\RouteContext;

class AuthMiddleware implements Middleware
{
    private $authService;
    private $logAuthService;

    public function __construct(AuthService $authService, LogAuthService $logAuthService)
    {
        $this->authService = $authService;
        $this->logAuthService = $logAuthService;
    }

    /**
     * {@inheritdoc}
     */
    public function process(Request $request, RequestHandler $handler): Response
    {
        $routeContext = RouteContext::fromRequest($request);
        $route = $routeContext->getRoute();
        $routeName = $route->getName();

        if (empty($route)) {
            throw new HttpNotFoundException($request);
        }

        $publicRoutesArray = ['auth-view', 'auth-refresh', 'login', 'register'];

        if (!in_array($routeName, $publicRoutesArray)) {
            $authInfo = $this->authService->run($request->getQueryParams());
            $this->logAuthService->run([$authInfo, $request]);
        }

        return $handler->handle($request);
    }
}
