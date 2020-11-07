<?php
declare(strict_types=1);

use App\Application\Actions\Auth;
use App\Application\Actions\User;
use App\Application\Actions\Matches;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\App;
use Slim\Interfaces\RouteCollectorProxyInterface as Group;

return function (App $app) {
    $app->options('/{routes:.*}', function (Request $request, Response $response) {
        // CORS Pre-Flight OPTIONS Request Handler
        return $response;
    });

    // Auth
    $app->group('/', function (Group $group) {
        $group->get('auth', Auth\AuthAction::class)->setName('auth');
        $group->post('login', User\LoginUserAction::class)->setName('login');
        $group->post('register', User\RegisterUserAction::class)->setName('register');
    });

    // User
    $app->group('/user', function (Group $group) {
        $group->get('/list', User\ListUsersAction::class);
        $group->get('/{id}', User\ViewUserAction::class);
        $group->get('/search/{keyword}', User\SearchUsernameAction::class);
    });

    // Matches
    $app->group('/matches/match', function (Group $group) {
        $group->get('/list', Matches\ListMatchesAction::class);
        $group->get('/{id}', Matches\ViewMatchAction::class);
    });
    $app->group('/matches/superstar', function (Group $group) {
        $group->get('/list', Matches\ListSuperstarsAction::class);
        $group->get('/{id}', Matches\ViewSuperstarAction::class);
        $group->get('/search/{keyword}', Matches\SearchSuperstarAction::class);
    });
};
