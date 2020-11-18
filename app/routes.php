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
    $app->group('/auth', function (Group $group) {
        $group->get('', Auth\ViewAuthAction::class)->setName('auth-view');
        $group->post('', Auth\UpdateAuthAction::class)->setName('auth-refresh');
    });

    // User
    $app->group('/user', function (Group $group) {
        $group->get('/list', User\ListUsersAction::class);
        $group->get('/{userId:[0-9]+}', User\ViewUserAction::class);
        $group->get('/search/{keyword}', User\SearchUsernameAction::class);
        $group->get('/discord/{discordId}', User\ViewDiscordUserAction::class);
        $group->get('/chatango/{chatangoId}', User\ViewChatangoUserAction::class);
        $group->post('/login', User\LoginUserAction::class)->setName('login');
        // $group->post('/register', User\RegisterUserAction::class)->setName('register');
    });

    // Matches
    $app->group('/matches/brand', function (Group $group) {
        $group->get('/list', Matches\ListBrandsAction::class);
        $group->get('/{brandId:[0-9]+}', Matches\ViewBrandAction::class);
    });
    $app->group('/matches/title', function (Group $group) {
        $group->get('/list', Matches\ListTitlesAction::class);
        $group->get('/{titleId:[0-9]+}', Matches\ViewTitleAction::class);
    });
    $app->group('/matches/matchtype', function (Group $group) {
        $group->get('/list', Matches\ListMatchTypesAction::class);
        $group->get('/{matchTypeId:[0-9]+}', Matches\ViewMatchTypeAction::class);
    });
    $app->group('/matches/contestant', function (Group $group) {
        $group->get('/list', Matches\ListContestantsAction::class);
    });
    $app->group('/matches/event', function (Group $group) {
        $group->get('/list', Matches\ListEventsAction::class);
        $group->get('/{eventId:[0-9]+}', Matches\ViewEventAction::class);
        $group->get('/search/{keyword}', Matches\SearchEventAction::class);
    });
    $app->group('/matches/superstar', function (Group $group) {
        $group->get('/list', Matches\ListSuperstarsAction::class);
        $group->get('/{superstarId:[0-9]+}', Matches\ViewSuperstarAction::class);
        $group->get('/search/{keyword}', Matches\SearchSuperstarAction::class);
    });
    $app->group('/matches/match', function (Group $group) {
        $group->get('/list', Matches\ListMatchesAction::class);
        $group->get('/betopen', Matches\ListBetOpenMatchesAction::class);
        $group->get('/{matchId:[0-9]+}', Matches\ViewMatchAction::class);
        $group->get('/{matchId:[0-9]+}/bets', Matches\ListMatchBetsAction::class);
        $group->get('/{matchId:[0-9]+}/ratings', Matches\ListMatchMatchRatingsAction::class);
        $group->get('/{matchId:[0-9]+}/contestants', Matches\ListMatchContestantsAction::class);
    });
    $app->group('/matches/season', function (Group $group) {
        $group->get('/list', Matches\ListSeasonsAction::class);
        $group->get('/{seasonId:[0-9]+}', Matches\ViewSeasonAction::class);
        $group->get('/{seasonId:[0-9]+}/stats', Matches\ListSeasonStatsAction::class);
        $group->get('/match/{matchId:[0-9]+}', Matches\ViewMatchSeasonAction::class);
    });
    $app->group('/matches/bet', function (Group $group) {
        $group->get('/list', Matches\ListBetsAction::class);
        $group->get('/user/{userId:[0-9]+}', Matches\ListUserBetsAction::class);
        $group->get('/match/{matchId:[0-9]+}', Matches\ListMatchBetsAction::class);
        $group->get('/{userId:[0-9]+}/{matchId:[0-9]+}', Matches\ViewBetAction::class);
        $group->post('', Matches\AddBetAction::class);
    });
    $app->group('/matches/rating', function (Group $group) {
        $group->get('/list', Matches\ListMatchRatingsAction::class);
        $group->get('/user/{userId:[0-9]+}', Matches\ListUserMatchRatingsAction::class);
        $group->get('/match/{matchId:[0-9]+}', Matches\ListMatchMatchRatingsAction::class);
        $group->get('/{userId:[0-9]+}/{matchId:[0-9]+}', Matches\ViewMatchRatingAction::class);
        $group->post('', Matches\AddMatchRatingAction::class);
    });
    $app->group('/matches/stats', function (Group $group) {
        $group->get('/list', Matches\ListStatsAction::class);
        $group->get('/user/{userId:[0-9]+}', Matches\ListUserStatsAction::class);
        $group->get('/season/{seasonId:[0-9]+}', Matches\ListSeasonStatsAction::class);
        $group->get('/{userId:[0-9]+}/{seasonId:[0-9]+}', Matches\ViewStatsAction::class);
    });
};
