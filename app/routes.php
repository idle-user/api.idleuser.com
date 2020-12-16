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
        $group->get('', Auth\ViewAuthAction::class);
        $group->post('', Auth\UpdateAuthAction::class);
        $group->put('/override/user/{userId:[0-9]+}', Auth\OverrideAuthAction::class)->setName('auth-override');
    });

    // User
    $app->group('/users', function (Group $group) {
        $group->get('', User\ListUsersAction::class);
        $group->get('/{userId:[0-9]+}', User\ViewUserAction::class);
        $group->get('/search/{keyword}', User\SearchUsernameAction::class);
        $group->get('/discord/{discordId}', User\ViewDiscordUserAction::class);
        $group->get('/chatango/{chatangoId}', User\ViewChatangoUserAction::class);
        $group->post('/login', User\LoginUserAction::class);
        $group->post('/login/token', User\UpdateLoginTokenUserAction::class)->setName('login-token-update');
        $group->post('/register', User\RegisterUserAction::class)->setName('register');
        $group->put('/{userId:[0-9]+}', User\UpdateUserAction::class)->setName('user-update');
        $group
            ->patch('/{userId:[0-9]+}/username', User\UpdateUsernameUserAction::class)
            ->setName('user-update-username');
        $group->patch('/{userId:[0-9]+}/email', User\UpdateEmailUserAction::class)->setName('user-update-email');
        $group
            ->patch('/{userId:[0-9]+}/discord', User\UpdateDiscordIdUserAction::class)
            ->setName('user-update-discord');
        $group
            ->patch('/{userId:[0-9]+}/chatango', User\UpdateChatangoIdUserAction::class)
            ->setName('user-update-chatango');
        $group
            ->patch('/{userId:[0-9]+}/twitter', User\UpdateTwitterIdUserAction::class)
            ->setName('user-update-twitter');
    });

    // Matches (WatchWrestling)
    $app->group('/watchwrestling', function (Group $group) {
        $group->post('/rate', Matches\AddMatchRatingAction::class)->setName('match-rate-add');
        $group->post('/bet', Matches\AddBetAction::class)->setName('match-bet-add');
        $group->group('/brands', function (Group $group) {
            $group->get('', Matches\ListBrandsAction::class);
            $group->get('/{brandId:[0-9]+}', Matches\ViewBrandAction::class);
        });
        $group->group('/titles', function (Group $group) {
            $group->get('', Matches\ListTitlesAction::class);
            $group->get('/{titleId:[0-9]+}', Matches\ViewTitleAction::class);
        });
        $group->group('/matchtypes', function (Group $group) {
            $group->get('', Matches\ListMatchTypesAction::class);
            $group->get('/{matchTypeId:[0-9]+}', Matches\ViewMatchTypeAction::class);
        });
        $group->group('/contestants', function (Group $group) {
            $group->get('', Matches\ListContestantsAction::class);
            $group->get('/match/{matchId:[0-9]+}', Matches\ListMatchContestantsAction::class);
        });
        $group->group('/events', function (Group $group) {
            $group->get('', Matches\ListEventsAction::class);
            $group->get('/future', Matches\ListFutureEventsAction::class);
            $group->get('/{eventId:[0-9]+}', Matches\ViewEventAction::class);
            $group->get('/search/{keyword}', Matches\SearchEventAction::class);
        });
        $group->group('/superstars', function (Group $group) {
            $group->get('', Matches\ListSuperstarsAction::class);
            $group->get('/{superstarId:[0-9]+}', Matches\ViewSuperstarAction::class);
            $group->get('/search/{keyword}', Matches\SearchSuperstarAction::class);
        });
        $group->group('/matches', function (Group $group) {
            $group->get('', Matches\ListMatchesAction::class);
            $group->get('/detail', Matches\ListMatchesDetailAction::class);
            $group->get('/calculation', Matches\ListMatchCalculationsAction::class);
            $group->get('/betopen', Matches\ListBetOpenMatchesAction::class);
            $group->get('/betopen/detail', Matches\ListBetOpenMatchesDetailAction::class);
            $group->get('/recent/detail', Matches\ViewRecentMatchDetailAction::class);
            $group->get('/current/detail', Matches\ViewCurrentMatchDetailAction::class);
            $group->get('/{matchId:[0-9]+}', Matches\ViewMatchAction::class);
            $group->get('/{matchId:[0-9]+}/bets', Matches\ListMatchBetsAction::class);
            $group->get('/{matchId:[0-9]+}/detail', Matches\ViewMatchDetailAction::class);
            $group->get('/{matchId:[0-9]+}/ratings', Matches\ListMatchMatchRatingsAction::class);
            $group->get('/{matchId:[0-9]+}/calculation', Matches\ViewMatchCalculationAction::class);
            $group->get('/{matchId:[0-9]+}/contestants', Matches\ListMatchContestantsAction::class);
        });
        $group->group('/seasons', function (Group $group) {
            $group->get('', Matches\ListSeasonsAction::class);
            $group->get('/{seasonId:[0-9]+}', Matches\ViewSeasonAction::class);
            $group->get('/{seasonId:[0-9]+}/stats', Matches\ListSeasonStatsAction::class);
            $group->get('/{seasonId:[0-9]+}/leaderboard', Matches\ViewLeaderboardAction::class);
            $group->get('/match/{matchId:[0-9]+}', Matches\ViewMatchSeasonAction::class);
        });
        $group->group('/bets', function (Group $group) {
            $group->get('', Matches\ListBetsAction::class);
            $group->get('/user/{userId:[0-9]+}', Matches\ListUserBetsAction::class);
            $group->get('/match/{matchId:[0-9]+}', Matches\ListMatchBetsAction::class);
            $group->get('/match/{matchId:[0-9]+}/user/{userId:[0-9]+}', Matches\ViewBetAction::class);
        });
        $group->group('/ratings', function (Group $group) {
            $group->get('', Matches\ListMatchRatingsAction::class);
            $group->get('/user/{userId:[0-9]+}', Matches\ListUserMatchRatingsAction::class);
            $group->get('/match/{matchId:[0-9]+}', Matches\ListMatchMatchRatingsAction::class);
            $group->get('/match/{matchId:[0-9]+}/user/{userId:[0-9]+}', Matches\ViewMatchRatingAction::class);
        });
        $group->group('/stats', function (Group $group) {
            $group->get('', Matches\ListStatsAction::class);
            $group->get('/user/{userId:[0-9]+}', Matches\ListUserStatsAction::class);
            $group->get('/season/{seasonId:[0-9]+}', Matches\ListSeasonStatsAction::class);
            $group->get('/user/{userId:[0-9]+}/season/{seasonId:[0-9]+}', Matches\ViewStatsAction::class);
            $group->get('/leaderboard/season/{seasonId:[0-9]+}', Matches\ViewLeaderboardAction::class);
        });
    });

    // Chatroom
    $app->group('/chatroom', function (Group $group) {
        $group->group('/commands', function (Group $group) {
            $group->get('', Chatroom\ListCommandsAction::class);
            $group->get('/{command}', Chatroom\ViewCommandAction::class);
            $group->post('', Chatroom\AddCommandAction::class)->setName('chatroom-command-add');
        });
    });
};
