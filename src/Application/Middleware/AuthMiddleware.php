<?php
declare(strict_types=1);

namespace App\Application\Middleware;

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

        $adminRoutesArray = ['auth-override', 'register'];
        $modRoutesArray = ['chatroom-command-add'];
        $userPostRoutesArray = [
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
        $authRequiredRouteArray = array_merge($adminRoutesArray, $modRoutesArray, $userPostRoutesArray);

        if (!in_array($routeName, $authRequiredRouteArray)) {
            return $handler->handle($request);
        }

        $authInfo = $this->validateAuthService->run();
        $parsedBody = $request->getParsedBody();
        $argsUserId = $route->getArgument('userId');
        $postUserId = isset($parsedBody['user_id']) ? $parsedBody['user_id'] : null;
        $isSelf = $authInfo->getUserId() == $argsUserId || $authInfo->getUserId() == $postUserId;

        if (in_array($routeName, $userPostRoutesArray)) {
            if (!$isSelf && !$authInfo->isAdmin()) {
                throw new HttpForbiddenException($request);
            }
        }

        if (in_array($routeName, $modRoutesArray)) {
            if (!$authInfo->isMod()) {
                throw new HttpForbiddenException($request);
            }
        }

        if (in_array($routeName, $adminRoutesArray)) {
            if (!$authInfo->isAdmin()) {
                throw new HttpForbiddenException($request);
            }
        }

        return $handler->handle($request);
    }
}
