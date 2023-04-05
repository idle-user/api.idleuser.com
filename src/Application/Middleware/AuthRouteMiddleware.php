<?php
declare(strict_types=1);

namespace App\Application\Middleware;

use App\Domain\Auth\Service\ValidateAuthService;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\MiddlewareInterface as Middleware;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use Slim\Exception\HttpForbiddenException;
use Slim\Routing\RouteContext;

// TODO: Separate out to 3 checks defined in routes instead
class AuthRouteMiddleware implements Middleware
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

        $adminRouteArray = ['auth-override'];
        $modRouteArray = ['chat-command-add', 'altlink-list'];
        $userRouteArray = [
            'match-rate-add',
            'match-bet-add',
            'match-favorite-add',
            'user-update',
            'user-update-secret',
            'user-update-username',
            'user-update-email',
            'user-update-discord',
            'user-update-chatango',
            'user-update-twitter',
            'user-update-login-token',
            'user-update-secret-token',
        ];
        $authRouteArray = ['auth-view', 'auth-update'];
        $authRequiredRouteArray = array_merge($adminRouteArray, $modRouteArray, $userRouteArray, $authRouteArray);

        if (!in_array($routeName, $authRequiredRouteArray)) {
            return $handler->handle($request);
        }

        $auth = $request->getAttribute('auth');
        $auth_error = $request->getAttribute('auth-error');
        if ($request->getAttribute('auth-error')) {
            throw $auth_error;
        }

        if (in_array($routeName, $userRouteArray)) {
            if (!$auth->isUser()) {
                throw new HttpForbiddenException($request);
            }

            $userId = (int)$route->getArgument('userId');

            if ($auth->getUserId() != $userId && !$auth->isAdmin()) {
                throw new HttpForbiddenException($request);
            }
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
