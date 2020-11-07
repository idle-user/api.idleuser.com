<?php
declare(strict_types=1);

namespace App\Application\Middleware;

use App\Domain\Auth\Service\AuthService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\MiddlewareInterface as Middleware;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use Slim\Exception\HttpNotFoundException;
use Slim\Exception\HttpForbiddenException;
use Slim\Routing\RouteContext;

class AuthMiddleware implements Middleware
{

    private $authService;

    public function __construct(AuthService $authService)
    {
        $this->authService = $authService;
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

        $publicRoutesArray = array('auth', 'login', 'register');

        if (!in_array($routeName, $publicRoutesArray)) {
            $this->authService->run($request->getQueryParams());
        }

        return $handler->handle($request);
    }
}
