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
    $app->group('/matches/brand', function (Group $group) {
        $group->get('/list', Matches\ListBrandsAction::class);
        $group->get('/{id}', Matches\ViewBrandAction::class);
    });
    $app->group('/matches/title', function (Group $group) {
        $group->get('/list', Matches\ListTitlesAction::class);
        $group->get('/{id}', Matches\ViewTitleAction::class);
    });
    $app->group('/matches/matchtype', function (Group $group) {
        $group->get('/list', Matches\ListMatchTypesAction::class);
        $group->get('/{id}', Matches\ViewMatchTypeAction::class);
    });
    $app->group('/matches/event', function (Group $group) {
        $group->get('/list', Matches\ListEventsAction::class);
        $group->get('/{id}', Matches\ViewEventAction::class);
        $group->get('/search/{keyword}', Matches\SearchEventAction::class);
    });
    $app->group('/matches/superstar', function (Group $group) {
        $group->get('/list', Matches\ListSuperstarsAction::class);
        $group->get('/{id}', Matches\ViewSuperstarAction::class);
        $group->get('/search/{keyword}', Matches\SearchSuperstarAction::class);
    });
    $app->group('/matches/match', function (Group $group) {
        $group->get('/list', Matches\ListMatchesAction::class);
        $group->get('/{id}', Matches\ViewMatchAction::class);
    });
    // $app->group('/matches/bet', function (Group $group) {
    //     $group->get('/list', Matches\ListBetsAction::class);
    //     $group->get('/{id}', Matches\ViewBetAction::class);
    // });
};
