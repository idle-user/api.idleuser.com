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

        $adminRoutesArray = ['auth-override'];
        $modRoutesArray = ['chatroom-command-add'];
        $userPostRoutesArray = ['match-rate-add', 'match-bet-add'];
        $authRequiredRouteArray = array_merge($adminRoutesArray, $modRoutesArray, $userPostRoutesArray);

        if (!in_array($routeName, $authRequiredRouteArray)) {
            return $handler->handle($request);
        }

        $params = $request->getQueryParams();
        $parsedBody = $request->getParsedBody();
        $authInfo = $this->validateAuthService->run($params);
        $this->logAuthService->run([$authInfo, $request]);

        if (in_array($routeName, $userPostRoutesArray)) {
            if (!$authInfo->isAdmin() && $authInfo->getUserId() != $parsedBody['user_id']) {
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
