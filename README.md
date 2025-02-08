# API Documentation - [api.idleuser.com](https://api.idleuser.com/)

This API is built using [Slim 4](https://www.slimframework.com/docs/v4/) with the [Slim-Skeleton](https://github.com/slimphp/Slim-Skeleton) as a starting point. It serves as a centralized backend for my various projects, each of which previously maintained its own database handler.

The goal of this API is to unify database interactions across multiple projects written in different languages, simplifying maintenance and development.

All endpoints listed below are available at **[https://api.idleuser.com/](https://api.idleuser.com/)**.

---

## 📌 Response Codes

The API returns the following standard HTTP response codes:

| Code | Meaning                     |
|------|-----------------------------|
| 200  | OK                          |
| 400  | Bad Request                 |
| 401  | Unauthenticated              |
| 403  | Insufficient Privileges      |
| 404  | Resource Not Found           |
| 405  | Method Not Allowed           |
| 409  | Conflict Error               |
| 422  | Validation Error             |
| 50X  | Server Error                 |

---

## 📍 API Endpoints

### 🔑 Authentication Endpoints

| Endpoint                      | Auth Required | Description                         |
|--------------------------------|--------------|-------------------------------------|
| `GET /auth`                    | ✅ Yes       | Validate authentication token      |
| `POST /auth`                   | ❌ No        | Request a new authentication token |
| `PUT /auth/user/{userId}`      | ✅ Yes       | Generate a new auth token for a user |

---

### 👤 User Endpoints

| Endpoint                        | Auth Required | Description                      |
|---------------------------------|--------------|----------------------------------|
| `POST /users/login`             | ❌ No        | Login to an account             |
| `POST /users/register`          | ✅ Yes       | Register a new account          |
| `POST /users/login/token`       | ✅ Yes       | Request a login token for web   |
| `POST /users/secret/token`      | ✅ Yes       | Request a secret token for web  |
| `PUT /users/{userId}`           | ✅ Yes       | Update account details          |
| `PATCH /users/{userId}/username`| ✅ Yes       | Update username                 |
| `PATCH /users/{userId}/email`   | ✅ Yes       | Update email                    |
| `PATCH /users/{userId}/discord` | ✅ Yes       | Update Discord ID               |
| `PATCH /users/{userId}/chatango`| ✅ Yes       | Update Chatango username        |
| `GET /users`                    | ❌ No        | Retrieve all users              |
| `GET /users/{userId}`           | ❌ No        | Retrieve user by ID             |
| `GET /users/search/{keyword}`   | ❌ No        | Search users by username        |
| `GET /users/discord/{discordId}`| ❌ No        | Find user by Discord ID         |
| `GET /users/chatango/{chatangoId}`| ❌ No      | Find user by Chatango ID        |

---

### 🤼 Matches (WatchWrestling) Endpoints

| Endpoint                                                        | Auth Required | Description                                         |
|-----------------------------------------------------------------|--------------|-----------------------------------------------------|
| `POST /watchwrestling/bet`                                      | ✅ Yes       | Place a match bet                                   |
| `PUT /watchwrestling/bet`                                       | ✅ Yes       | Update an existing match bet                        |
| `POST /watchwrestling/rate`                                     | ✅ Yes       | Rate a match                                        |
| `POST /watchwrestling/favorite`                                 | ✅ Yes       | Mark a superstar as a favorite                      |
| `GET /watchwrestling/brands`                                    | ❌ No        | Retrieve all wrestling brands                       |
| `GET /watchwrestling/brands/{brandId}`                          | ❌ No        | Retrieve brand details by ID                        |
| `GET /watchwrestling/titles`                                    | ❌ No        | Retrieve all championship titles                    |
| `GET /watchwrestling/titles/{titleId}`                          | ❌ No        | Retrieve title details by ID                        |
| `GET /watchwrestling/matchtypes`                                | ❌ No        | Retrieve all match types                            |
| `GET /watchwrestling/matchtypes/{matchTypeId}`                  | ❌ No        | Retrieve match type by ID                           |
| `GET /watchwrestling/contestants`                               | ❌ No        | Retrieve all contestants                            |
| `GET /watchwrestling/contestants/match/{matchId}`               | ❌ No        | Retrieve contestants by match ID                    |
| `GET /watchwrestling/events`                                    | ❌ No        | Retrieve all events                                 |
| `GET /watchwrestling/events/future`                             | ❌ No        | Retrieve upcoming events                            |
| `GET /watchwrestling/events/{eventId}`                          | ❌ No        | Retrieve event details by ID                        |
| `GET /watchwrestling/events/search/{keyword}`                   | ❌ No        | Search events by name                               |
| `GET /watchwrestling/superstars`                                | ❌ No        | Retrieve all superstars                             |
| `GET /watchwrestling/superstars/{superstarId}`                  | ❌ No        | Retrieve superstar details by ID                    |
| `GET /watchwrestling/superstars/search/{keyword}`               | ❌ No        | Search superstars by name                           |
| `GET /watchwrestling/matches`                                   | ❌ No        | Retrieve all matches                                |
| `GET /watchwrestling/matches/detail`                            | ❌ No        | Retrieve detailed match information                 |
| `GET /watchwrestling/matches/calculation`                       | ❌ No        | Retrieve match calculations                         |
| `GET /watchwrestling/matches/betopen`                           | ❌ No        | Retrieve all matches with bets open                 |
| `GET /watchwrestling/matches/betopen/detail`                    | ❌ No        | Retrieve all matches with bets open and with detail |
| `GET /watchwrestling/matches/recent/detail`                     | ❌ No        | Retrieve last closed match with detail              |
| `GET /watchwrestling/matches/current/detail`                    | ❌ No        | Retrieve current match with detail                  |
| `GET /watchwrestling/matches/{matchId}`                         | ❌ No        | Retrieve match by ID                                |
| `GET /watchwrestling/matches/{matchId}/bets`                    | ❌ No        | Retrieve match bets by match ID                     |
| `GET /watchwrestling/matches/{matchId}/bets/detail`             | ❌ No        | Retrieve match bet details by match ID              |
| `GET /watchwrestling/matches/{matchId}/detail`                  | ❌ No        | Retrieve match with detail by match ID              |
| `GET /watchwrestling/matches/{matchId}/ratings`                 | ❌ No        | Retrieve match ratings by match ID                  |
| `GET /watchwrestling/matches/{matchId}/calculation`             | ❌ No        | Retrieve match calculation by match ID              |
| `GET /watchwrestling/matches/{matchId}/calculation`             | ❌ No        | Retrieve match calculation by match ID              |
| `GET /watchwrestling/matches/{matchId}/contestants`             | ❌ No        | Retrieve match contestants by match ID              |
| `GET /watchwrestling/bets`                                      | ❌ No        | Retrieve all match bets                             |
| `GET /watchwrestling/bets/detail`                               | ❌ No        | Retrieve all match bet details                      |
| `GET /watchwrestling/bets/user/{userId}`                        | ❌ No        | Retrieve match bets by user ID                      |
| `GET /watchwrestling/bets/user/{userId}/detail`                 | ❌ No        | Retrieve match bet details by user ID               |
| `GET /watchwrestling/bets/match/{matchId}`                      | ❌ No        | Retrieve match bets by match ID                     |
| `GET /watchwrestling/bets/match/{matchId}/detail`               | ❌ No        | Retrieve match bet details by match ID              |
| `GET /watchwrestling/bets/match/{matchId}/user/{userId}`        | ❌ No        | Retrieve bet by match ID and user ID                |
| `GET /watchwrestling/bets/match/{matchId}/user/{userId}/detail` | ❌ No        | Retrieve bet detail by match ID and user ID         |
| `GET /watchwrestling/ratings`                                   | ❌ No        | Retrieve all match ratings                          |
| `GET /watchwrestling/ratings/user/{userId}`                     | ❌ No        | Retrieve all match rating by user ID                |
| `GET /watchwrestling/ratings/match/{matchId}`                   | ❌ No        | Retrieve match ratings by match ID                  |
| `GET /watchwrestling/ratings/match/{matchId}/user/{userId}`     | ❌ No        | Retrieve match rating by match ID and user ID       |
| `GET /watchwrestling/stats`                                     | ❌ No        | Retrieve all user stats                             |
| `GET /watchwrestling/stats/user/{userId}`                       | ❌ No        | Retrieve stats by user ID                           |
| `GET /watchwrestling/stats/season/{seasonId}`                   | ❌ No        | Retrieve stats by season ID                         |
| `GET /watchwrestling/user/{userId}/season/{seasonId}`           | ❌ No        | Retrieve stats by user ID and season ID             |
| `GET /leaderboard/season/{seasonId}`                            | ❌ No        | Retrieve leaderboard by season ID                   |


---

### 💬 Chat Commands (Discord/Chatango) Endpoints

| Endpoint                    | Auth Required | Description                  |
|-----------------------------|--------------|------------------------------|
| `GET /chat/commands`        | ❌ No        | Retrieve all chat commands  |
| `GET /chat/commands/{command}` | ❌ No    | Retrieve command details    |
| `POST /chat/commands`       | ✅ Yes       | Add a new chat command      |

---