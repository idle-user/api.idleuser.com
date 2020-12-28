<?php
declare(strict_types=1);

namespace App\Application\Middleware;

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

        if (empty($route)) {
            throw new HttpNotFoundException($request);
        }

        $parsedBody = $request->getParsedBody();
        $argsUserId = $route->getArgument('userId');
        $postUserId = isset($parsedBody['user_id']) ? $parsedBody['user_id'] : null;

        try {
            $authInfo = $this->validateAuthService->run();
            $authUserId = $authInfo->getUserId();
            $isSelf = $authUserId == $argsUserId || $authUserId == $postUserId;
            $authIsMod = $authInfo->isMod();
            $authIsAdmin = $authInfo->isAdmin();
        } catch (AuthTokenNotFoundException | AuthTokenInvalidException | AuthTokenExpiredException $e) {
            $authError = $e;
            $authUserId = null;
            $isSelf = false;
            $authIsMod = false;
            $authIsAdmin = false;
        }

        $request = $request->withAttribute('auth_user_id', $authUserId);
        $request = $request->withAttribute('auth_is_self', $isSelf);
        $request = $request->withAttribute('auth_is_mod', $authIsMod);
        $request = $request->withAttribute('auth_is_admin', $authIsAdmin);

        $adminRouteArray = ['auth-override', 'register'];
        $modRouteArray = ['chatroom-command-add'];
        $userPostRouteArray = [
            'match-rate-add',
            'match-bet-add',
            'user-update',
            'user-update-username',
            'user-update-email',
            'user-update-discord',
            'user-update-chatango',
            'user-update-twitter',
            'user-update-login-token',
        ];
        $authRequiredRouteArray = array_merge($adminRouteArray, $modRouteArray, $userPostRouteArray);

        if (!in_array($routeName, $authRequiredRouteArray)) {
            return $handler->handle($request);
        }

        if (isset($authError)) {
            throw $authError;
        }

        if (in_array($routeName, $userPostRouteArray)) {
            if (!$isSelf && !$authInfo->isAdmin()) {
                throw new HttpForbiddenException($request);
            }
        }

        if (in_array($routeName, $modRouteArray)) {
            if (!$authInfo->isMod()) {
                throw new HttpForbiddenException($request);
            }
        }

        if (in_array($routeName, $adminRouteArray)) {
            if (!$authInfo->isAdmin()) {
                throw new HttpForbiddenException($request);
            }
        }

        return $handler->handle($request);
    }
}
