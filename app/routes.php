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
        $group->get('/betopen', Matches\ListBetOpenMatchesAction::class);
        $group->get('/{id}', Matches\ViewMatchAction::class);
        $group->get('/{matchId}/bets', Matches\ListMatchBetsAction::class);
        $group->get('/{matchId}/ratings', Matches\ListMatchMatchRatingsAction::class);
    });
    $app->group('/matches/season', function (Group $group) {
        $group->get('/list', Matches\ListSeasonsAction::class);
        $group->get('/{id}', Matches\ViewSeasonAction::class);
        $group->get('/{seasonId}/stats', Matches\ListSeasonStatsAction::class);
        $group->get('/match/{matchId}', Matches\ViewMatchSeasonAction::class);
    });
    $app->group('/matches/bet', function (Group $group) {
        $group->get('/list', Matches\ListBetsAction::class);
        $group->get('/user/{userId}', Matches\ListUserBetsAction::class);
        $group->get('/match/{matchId}', Matches\ListMatchBetsAction::class);
        $group->get('/{userId}/{matchId}', Matches\ViewBetAction::class);
    });
    $app->group('/matches/matchrating', function (Group $group) {
        $group->get('/list', Matches\ListMatchRatingsAction::class);
        $group->get('/user/{userId}', Matches\ListUserMatchRatingsAction::class);
        $group->get('/match/{matchId}', Matches\ListMatchMatchRatingsAction::class);
        $group->get('/{userId}/{matchId}', Matches\ViewMatchRatingAction::class);
    });
    $app->group('/matches/stats', function (Group $group) {
        $group->get('/list', Matches\ListStatsAction::class);
        $group->get('/user/{userId}', Matches\ListUserStatsAction::class);
        $group->get('/season/{seasonId}', Matches\ListSeasonStatsAction::class);
        $group->get('/{userId}/{seasonId}', Matches\ViewStatsAction::class);
    });
};
