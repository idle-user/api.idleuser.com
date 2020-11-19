<?php
declare(strict_types=1);

namespace App\Application\Middleware;

use App\Domain\Auth\Service\ValidateAuthService;
use App\Domain\Auth\Service\LogAuthService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\MiddlewareInterface as Middleware;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use Slim\Exception\HttpNotFoundException;
use Slim\Exception\HttpForbiddenException;
use Slim\Routing\RouteContext;

class AuthMiddleware implements Middleware
{
    private $validateAuthService;
    private $logAuthService;

    public function __construct(ValidateAuthService $validateAuthService, LogAuthService $logAuthService)
    {
        $this->validateAuthService = $validateAuthService;
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

        if (in_array($routeName, $publicRoutesArray)) {
            return $handler->handle($request);
        }

        $authInfo = $this->validateAuthService->run($request->getQueryParams());
        $this->logAuthService->run([$authInfo, $request]);

        $modRoutesArray = ['chatroom-command-add'];

        if (in_array($routeName, $modRoutesArray)) {
            if (!$authInfo->isMod()) {
                throw new HttpForbiddenException($request);
            }
        }

        $adminRoutesArray = ['auth-override'];

        if (in_array($routeName, $adminRoutesArray)) {
            if (!$authInfo->isAdmin()) {
                throw new HttpForbiddenException($request);
            }
        }

        return $handler->handle($request);
    }
}
