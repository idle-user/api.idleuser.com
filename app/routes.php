<?php
declare(strict_types=1);

use App\Application\Actions\Auth;
use App\Application\Actions\User;
use App\Application\Actions\Matches;
use App\Application\Actions\Chatroom;
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
        $group->put('/override/{userId:[0-9]+}', Auth\OverrideAuthAction::class)->setName('auth-override');
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
    $app->group('/matches', function (Group $group) {
        $group->group('/brand', function (Group $group) {
            $group->get('/list', Matches\ListBrandsAction::class);
            $group->get('/{brandId:[0-9]+}', Matches\ViewBrandAction::class);
        });
        $group->group('/title', function (Group $group) {
            $group->get('/list', Matches\ListTitlesAction::class);
            $group->get('/{titleId:[0-9]+}', Matches\ViewTitleAction::class);
        });
        $group->group('/matchtype', function (Group $group) {
            $group->get('/list', Matches\ListMatchTypesAction::class);
            $group->get('/{matchTypeId:[0-9]+}', Matches\ViewMatchTypeAction::class);
        });
        $group->group('/contestant', function (Group $group) {
            $group->get('/list', Matches\ListContestantsAction::class);
        });
        $group->group('/event', function (Group $group) {
            $group->get('/list', Matches\ListEventsAction::class);
            $group->get('/future', Matches\ListFutureEventsAction::class);
            $group->get('/{eventId:[0-9]+}', Matches\ViewEventAction::class);
            $group->get('/search/{keyword}', Matches\SearchEventAction::class);
        });
        $group->group('/superstar', function (Group $group) {
            $group->get('/list', Matches\ListSuperstarsAction::class);
            $group->get('/{superstarId:[0-9]+}', Matches\ViewSuperstarAction::class);
            $group->get('/search/{keyword}', Matches\SearchSuperstarAction::class);
        });
        $group->group('/match', function (Group $group) {
            $group->get('/list', Matches\ListMatchesAction::class);
            $group->get('/betopen', Matches\ListBetOpenMatchesAction::class);
            $group->get('/{matchId:[0-9]+}', Matches\ViewMatchAction::class);
            $group->get('/{matchId:[0-9]+}/bets', Matches\ListMatchBetsAction::class);
            $group->get('/{matchId:[0-9]+}/ratings', Matches\ListMatchMatchRatingsAction::class);
            $group->get('/{matchId:[0-9]+}/calculation', Matches\ViewMatchCalculationAction::class);
            $group->get('/{matchId:[0-9]+}/contestants', Matches\ListMatchContestantsAction::class);
            $group->get('/calculation/{matchId:[0-9]+}', Matches\ViewMatchCalculationAction::class);
            $group->get('/calculation/list', Matches\ListMatchCalculationsAction::class);
        });
        $group->group('/season', function (Group $group) {
            $group->get('/list', Matches\ListSeasonsAction::class);
            $group->get('/{seasonId:[0-9]+}', Matches\ViewSeasonAction::class);
            $group->get('/{seasonId:[0-9]+}/stats', Matches\ListSeasonStatsAction::class);
            $group->get('/{seasonId:[0-9]+}/leaderboard', Matches\ViewLeaderboardAction::class);
            $group->get('/match/{matchId:[0-9]+}', Matches\ViewMatchSeasonAction::class);
        });
        $group->group('/bet', function (Group $group) {
            $group->get('/list', Matches\ListBetsAction::class);
            $group->get('/user/{userId:[0-9]+}', Matches\ListUserBetsAction::class);
            $group->get('/match/{matchId:[0-9]+}', Matches\ListMatchBetsAction::class);
            $group->get('/{userId:[0-9]+}/{matchId:[0-9]+}', Matches\ViewBetAction::class);
            $group->post('', Matches\AddBetAction::class);
        });
        $group->group('/rating', function (Group $group) {
            $group->get('/list', Matches\ListMatchRatingsAction::class);
            $group->get('/user/{userId:[0-9]+}', Matches\ListUserMatchRatingsAction::class);
            $group->get('/match/{matchId:[0-9]+}', Matches\ListMatchMatchRatingsAction::class);
            $group->get('/{userId:[0-9]+}/{matchId:[0-9]+}', Matches\ViewMatchRatingAction::class);
            $group->post('', Matches\AddMatchRatingAction::class);
        });
        $group->group('/stats', function (Group $group) {
            $group->get('/list', Matches\ListStatsAction::class);
            $group->get('/user/{userId:[0-9]+}', Matches\ListUserStatsAction::class);
            $group->get('/season/{seasonId:[0-9]+}', Matches\ListSeasonStatsAction::class);
            $group->get('/season/{seasonId:[0-9]+}/leaderboard', Matches\ViewLeaderboardAction::class);
            $group->get('/{userId:[0-9]+}/{seasonId:[0-9]+}', Matches\ViewStatsAction::class);
        });
        $group->group('/leaderboard', function (Group $group) {
            $group->get('/{seasonId:[0-9]+}', Matches\ViewLeaderboardAction::class);
        });
    });

    // Chatroom
    $app->group('/chatroom', function (Group $group) {
        $group->group('/command', function (Group $group) {
            $group->get('/list', Chatroom\ListCommandsAction::class);
            $group->get('/{command}', Chatroom\ViewCommandAction::class);
            $group->post('', Chatroom\AddCommandAction::class)->setName('chatroom-command-add');
        });
    });
};
