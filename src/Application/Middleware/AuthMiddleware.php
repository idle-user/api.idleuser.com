<?php
declare(strict_types=1);

namespace App\Application\Middleware;

use App\Domain\Auth\Data\Auth;
use App\Domain\Auth\Exception\AuthTokenExpiredException;
use App\Domain\Auth\Exception\AuthTokenInvalidException;
use App\Domain\Auth\Exception\AuthTokenNotFoundException;
use App\Domain\Auth\Service\ValidateAuthService;
use App\Exception\ValidationException;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\MiddlewareInterface as Middleware;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;

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

        try {
            $auth = $this->validateAuthService->run();
            $request = $request->withAttribute('auth-error', false);
        } catch (AuthTokenNotFoundException|AuthTokenInvalidException|AuthTokenExpiredException|ValidationException $e) {
            $auth = Auth::create();
            $request = $request->withAttribute('auth-error', $e);
        }

        $request = $request->withAttribute('auth', $auth);

        return $handler->handle($request);
    }
}
