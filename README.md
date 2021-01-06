# api.idleuser.com

This API was created using [Slim 4](https://www.slimframework.com/docs/v4/) with [Slim-Skeleton](https://github.com/slimphp/Slim-Skeleton) to get started. This is my first attempt at creating an API. It took me a while to understand how Slim 4 worked, but once it clicked, everything became an ease. The only work from that point on was figuring out a good routing structure.

The purpose of this API is to provide a central point for my existing projects that relied on their own database handlers. I had various projects in different languages, so you can see how creating and maintaining their database handler can be tiresome.

All end points below are available on https://api.idleuser.com/.

## Response Codes

```
200: OK
400: BAD_REQUEST
401: UNAUTHENTICATED
403: INSUFFICIENT_PRIVILEGES
404: RESOURCE_NOT_FOUND
405: NOT_ALLOWED
409: CONFLICT_ERROR
422: VALIDATION_ERROR
50X: SERVER_ERROR
```

## End Points

# Auth End Points

| End Point                 | Auth Required | Description                     |
| ------------------------- | ------------- | ------------------------------- |
| `GET /auth`               | Yes           | Test auth token                 |
| `POST /auth`              | No            | Request new auth token          |
| `PUT /auth/user/{userId}` | Yes           | Request new auth token for user |

# User End Points

| End Point                          | Auth Required | Description                       |
| ---------------------------------- | ------------- | --------------------------------- |
| `POST /users/login`                | No            | Login to account                  |
| `POST /users/register`             | Yes           | Register account                  |
| `POST /users/login/token`          | Yes           | Request login token for web       |
| `PUT /users/{userId}`              | Yes           | Update account                    |
| `PATCH /users/{userId}/username`   | Yes           | Update username                   |
| `PATCH /users/{userId}/email`      | Yes           | Update email                      |
| `PATCH /users/{userId}/discord`    | Yes           | Update Discord ID                 |
| `PATCH /users/{userId}/chatango`   | Yes           | Update Chatango username          |
| `PATCH /users/{userId}/twitter`    | Yes           | Update Twitter ID                 |
| `GET /users`                       | No            | View all users                    |
| `GET /users/{userId}`              | No            | View user by ID                   |
| `GET /users/search/{keyword}`      | No            | View users with matching username |
| `GET /users/discord/{discordId}`   | No            | View user by Discord ID           |
| `GET /users/chatango/{chatangoId}` | No            | View user by Chatango ID          |

# Matches (WatchWrestling) End Points

| End Point                                                            | Auth Required | Description                                     |
| -------------------------------------------------------------------- | ------------- | ----------------------------------------------- |
| `POST /watchwrestling/bet`                                           | Yes           | Bet on match                                    |
| `POST /watchwrestling/rate`                                          | Yes           | Rate match                                      |
| `GET /watchwrestling/brands`                                         | No            | View all brands                                 |
| `GET /watchwrestling/brands/{brandId}`                               | No            | View brand by ID                                |
| `GET /watchwrestling/titles`                                         | No            | View all titles                                 |
| `GET /watchwrestling/titles/{titleId}`                               | No            | View title by ID                                |
| `GET /watchwrestling/matchtypes`                                     | No            | View all match types                            |
| `GET /watchwrestling/matchtypes/{matchTypeId}`                       | No            | View match type by ID                           |
| `GET /watchwrestling/contestants`                                    | No            | View all contestants                            |
| `GET /watchwrestling/contestants/match/{matchId}`                    | No            | View contestants by match ID                    |
| `GET /watchwrestling/events`                                         | No            | View all events                                 |
| `GET /watchwrestling/events/future`                                  | No            | View all future events                          |
| `GET /watchwrestling/events/{eventId}`                               | No            | View event by ID                                |
| `GET /watchwrestling/events/search/{keyword}`                        | No            | View events with matching name                  |
| `GET /watchwrestling/superstars`                                     | No            | View all superstars                             |
| `GET /watchwrestling/superstars/{superstarId}`                       | No            | View superstar by ID                            |
| `GET /watchwrestling/superstars/search/{keyword}`                    | No            | View superstar with matching name               |
| `GET /watchwrestling/matches`                                        | No            | View all matches                                |
| `GET /watchwrestling/matches/detail`                                 | No            | View all matches with detail                    |
| `GET /watchwrestling/matches/calculation`                            | No            | View all matches calculations                   |
| `GET /watchwrestling/matches/betopen`                                | No            | View all matches with bets open                 |
| `GET /watchwrestling/matches/betopen/detail`                         | No            | View all matches with bets open and with detail |
| `GET /watchwrestling/matches/recent/detail`                          | No            | View last closed match with detail              |
| `GET /watchwrestling/matches/current/detail`                         | No            | View current match with detail                  |
| `GET /watchwrestling/matches/{matchId}`                              | No            | View match by ID                                |
| `GET /watchwrestling/matches/{matchId}/bets`                         | No            | View match bets by match ID                     |
| `GET /watchwrestling/matches/{matchId}/bets/calculation`             | No            | View match bet calculations by match ID         |
| `GET /watchwrestling/matches/{matchId}/detail`                       | No            | View match with detail by match ID              |
| `GET /watchwrestling/matches/{matchId}/ratings`                      | No            | View match ratings by match ID                  |
| `GET /watchwrestling/matches/{matchId}/calculation`                  | No            | View match calculation by match ID              |
| `GET /watchwrestling/matches/{matchId}/contestants`                  | No            | View match contestants by match ID              |
| `GET /watchwrestling/bets`                                           | No            | View all match bets                             |
| `GET /watchwrestling/bets/calculation`                               | No            | View all match bet calculations                 |
| `GET /watchwrestling/bets/user/{userId}`                             | No            | View match bets by user ID                      |
| `GET /watchwrestling/bets/user/{userId}/calculation`                 | No            | View match bet calculations by user ID          |
| `GET /watchwrestling/bets/match/{matchId}`                           | No            | View match bets by match ID                     |
| `GET /watchwrestling/bets/match/{matchId}/calculation`               | No            | View match bet calculations by match ID         |
| `GET /watchwrestling/bets/match/{matchId}/user/{userId}`             | No            | View bet by match ID and user ID                |
| `GET /watchwrestling/bets/match/{matchId}/user/{userId}/calculation` | No            | View bet calculation by match ID and user ID    |
| `GET /watchwrestling/ratings`                                        | No            | View all match ratings                          |
| `GET /watchwrestling/ratings/user/{userId}`                          | No            | View all match rating by user ID                |
| `GET /watchwrestling/ratings/match/{matchId}`                        | No            | View match ratings by match ID                  |
| `GET /watchwrestling/ratings/match/{matchId}/user/{userId}`          | No            | View match rating by match ID and user ID       |
| `GET /watchwrestling/stats`                                          | No            | View all user stats                             |
| `GET /watchwrestling/stats/user/{userId}`                            | No            | View stats by user ID                           |
| `GET /watchwrestling/stats/season/{seasonId}`                        | No            | View stats by season ID                         |
| `GET /watchwrestling/user/{userId}/season/{seasonId}`                | No            | View stats by user ID and season ID             |
| `GET /leaderboard/season/{seasonId}`                                 | No            | View leaderboard by season ID                   |

# Chat Commands (Discord/Chatango) End Points

| End Point                      | Auth Required | Description        |
| ------------------------------ | ------------- | ------------------ |
| `GET /chat/commands`           | No            | View all commands  |
| `GET /chat/commands/{command}` | No            | View command by ID |
| `POST /chat/commands`          | Yes           | Add command        |
