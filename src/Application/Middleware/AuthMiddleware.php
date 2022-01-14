<?php
declare(strict_types=1);

namespace App\Application\Middleware;

use App\Domain\Auth\Data\Auth;
use App\Domain\Auth\Exception\AuthTokenExpiredException;
use App\Domain\Auth\Exception\AuthTokenInvalidException;
use App\Domain\Auth\Exception\AuthTokenNotFoundException;
use App\Domain\Auth\Service\ValidateAuthService;
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

    public function __construct(ValidateAuthService $validateAuthService)
    {
        $this->validateAuthService = $validateAuthService;
    }

    /**
     * {@inheritdoc}
     */
    public function process(Request $request, RequestHandler $handler): Response
    {
        $routeContext = RouteContext::fromRequest($request);
        $route = $routeContext->getRoute();
        $routeName = $route->getName();

        $adminRouteArray = ['auth-override', 'register'];
        $modRouteArray = ['chat-command-add', 'altlink-list'];
        $userRouteArray = [
            'match-rate-add',
            'match-bet-add',
            'user-update',
            'user-update-username',
            'user-update-email',
            'user-update-discord',
            'user-update-chatango',
            'user-update-twitter',
            'user-update-login-token',
            'user-update-secret-token',
        ];
        $authRequiredRouteArray = array_merge($adminRouteArray, $modRouteArray, $userRouteArray);

        try {
            $auth = $this->validateAuthService->run();
        } catch (AuthTokenNotFoundException | AuthTokenInvalidException | AuthTokenExpiredException $e) {
            $authError = $e;
            $auth = Auth::create();
        }

        $request = $request->withAttribute('auth', $auth);

        if (!in_array($routeName, $authRequiredRouteArray)) {
            return $handler->handle($request);
        }

        if (isset($authError)) {
            throw $authError;
        }

        if (!$auth->isUser() && in_array($routeName, $userRouteArray)) {
            throw new HttpForbiddenException($request);
        }

        if (!$auth->isMod() && in_array($routeName, $modRouteArray)) {
            throw new HttpForbiddenException($request);
        }

        if (!$auth->isAdmin() && in_array($routeName, $adminRouteArray)) {
            throw new HttpForbiddenException($request);
        }

        return $handler->handle($request);
    }
}
