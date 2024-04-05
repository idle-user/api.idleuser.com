<?php
declare(strict_types=1);

use App\Application\Actions\AltLink;
use App\Application\Actions\Auth;
use App\Application\Actions\Chat;
use App\Application\Actions\Matches;
use App\Application\Actions\Pickem;
use App\Application\Actions\User;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\App;
use Slim\Interfaces\RouteCollectorProxyInterface as Group;

return function (App $app) {
    $app->options('/{routes:.*}', function (Request $request, Response $response) {
        // CORS Pre-Flight OPTIONS Request Handler
        return $response;
    });

    $app->get('/', function (Request $request, Response $response) {
        $payload = [
            'statusCode' => 200,
            'data' => [
                "title" => 'documentation',
                'link' => 'https://github.com/idle-user/api.idleuser.com'
            ],
        ];
        $json = json_encode($payload, JSON_PRETTY_PRINT);
        $response->getBody()->write($json);
        return $response;
    });

    // Auth
    $app->group('/auth', function (Group $group) {
        $group->get('', Auth\ViewAuthAction::class)->setName('auth-view');
        $group->post('', Auth\UpdateAuthAction::class)->setName('auth-update');
        $group->put('/user/{userId:[0-9]+}', Auth\OverrideAuthAction::class)->setName('auth-override');
    });

    // User
    $app->group('/users', function (Group $group) {
        $group->get('', User\ListUsersAction::class);
        $group->get('/{userId:[0-9]+}', User\ViewUserAction::class);
        $group->get('/search/{keyword}', User\SearchUsernameAction::class);
        $group->get('/discord/{discordId}', User\ViewDiscordUserAction::class);
        $group->get('/chatango/{chatangoId}', User\ViewChatangoUserAction::class);
        $group->post('/login', User\LoginUserAction::class);
        $group->post('/register', User\RegisterUserAction::class)->setName('register');
        $group->get('/login/token', User\LoginTokenUserAction::class)->setName('user-login-with-token');
        $group->post('/login/token', User\UpdateLoginTokenUserAction::class)->setName('user-update-login-token');
        $group->post('/secret/token', User\UpdateSecretTokenUserAction::class)->setName('user-update-secret-token');
        $group->post('/secret/reset', User\ResetSecretUserAction::class)->setName('user-reset-secret');
        $group->put('/{userId:[0-9]+}', User\UpdateUserAction::class)->setName('user-update');
        $group
            ->patch('/{userId:[0-9]+}/secret', User\UpdateSecretUserAction::class)
            ->setName('user-update-secret');
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
        $group->post('/bet', Matches\AddBetAction::class)->setName('match-bet-add');
        $group->patch('/bet', Matches\UpdateBetAction::class)->setName('match-bet-update');
        $group->post('/rate', Matches\AddMatchRatingAction::class)->setName('match-rate-add');
        $group->post('/favorite', Matches\AddFavoriteSuperstarAction::class)->setName('match-favorite-add');
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
            $group->get('/{matchId:[0-9]+}/bets/detail', Matches\ListMatchBetsDetailAction::class);
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
            $group->get('/detail', Matches\ListBetsDetailAction::class);
            $group->get('/user/{userId:[0-9]+}', Matches\ListUserBetsAction::class);
            $group->get('/user/{userId:[0-9]+}/detail', Matches\ListUserBetsDetailAction::class);
            $group->get('/user/{userId:[0-9]+}/current/detail', Matches\ListCurrentUserBetsDetailAction::class);
            $group->get('/match/{matchId:[0-9]+}', Matches\ListMatchBetsAction::class);
            $group->get('/match/{matchId:[0-9]+}/detail', Matches\ListMatchBetsDetailAction::class);
            $group->get('/match/{matchId:[0-9]+}/user/{userId:[0-9]+}', Matches\ViewBetAction::class);
            $group->get('/match/{matchId:[0-9]+}/user/{userId:[0-9]+}/detail', Matches\ViewBetDetailAction::class);
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
        $group->group('/royalrumbles', function (Group $group) {
            $group->get('', Matches\ListRoyalRumblesAction::class);
            $group->get('/entries', Matches\ListRoyalRumblesEntriesAction::class);
            $group->get('/{royalrumbleId:[0-9]+}', Matches\ViewRoyalRumbleAction::class);
            $group->get('/{royalrumbleId:[0-9]+}/entries', Matches\ListRoyalRumbleEntriesAction::class);
            $group->get(
                '/{royalrumbleId:[0-9]+}/entries/user/{userId:[0-9]+}',
                Matches\ViewRoyalRumbleUserEntryAction::class,
            );
            $group
                ->post('/{royalrumbleId:[0-9]+}', Matches\AddRoyalRumbleEntryAction::class)
                ->setName('royalrumble-entry-add');
        });
    });

    // Chat Commands
    $app->group('/chat', function (Group $group) {
        $group->group('/commands', function (Group $group) {
            $group->get('', Chat\ListCommandsAction::class);
            $group->get('/{command}', Chat\ViewCommandAction::class);
            $group->post('', Chat\AddCommandAction::class)->setName('chat-command-add');
        });
        $group->group('/scheduler', function (Group $group) {
            $group->get('', Chat\ListSchedulerAction::class);
            $group->get('/{schedulerId:[0-9]+}', Chat\ViewSchedulerAction::class);
        });
    });

    // AltLink (WIP)
    $app->group('/altlink', function (Group $group) {
        $group->get('', AltLink\ListAltLinksAction::class)->setName('altlink-list');
        $group->get('/{alias}', AltLink\ViewAltLinkAction::class)->setName('altlink-view');
        $group->post('', AltLink\AddAltLinkAction::class)->setName('altlink-add');
    });

    // Pickem (WIP)
    $app->group('/pickem', function (Group $group) {
        $group->post('/prompt', Pickem\AddPromptAction::class)->setName('pickem-prompt-add');
        $group->patch('/prompt', Pickem\UpdatePromptAction::class)->setName('pickem-prompt-update');
        $group->post('/pick', Pickem\AddPickAction::class)->setName('pickem-pick-add');
        $group->patch('/pick', Pickem\UpdatePickAction::class)->setName('pickem-pick-update');
        $group->group('/prompts', function (Group $group) {
            $group->get('', Pickem\ListPromptsAction::class);
            $group->get('/{promptId:[0-9]+}', Pickem\ViewPromptAction::class);
        });
        $group->get('/picks', Pickem\ListPicksAction::class);
//        $group->group('/stats', function (Group $group) {
//            $group->get('', Pickem\ListStatsAction::class);
//            $group->get('/{userId:[0-9]+}', Pickem\ViewStatsAction::class);
//        });
    });
};
