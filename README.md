[![General Assembly Logo](https://camo.githubusercontent.com/1a91b05b8f4d44b5bbfb83abac2b0996d8e26c92/687474703a2f2f692e696d6775722e636f6d2f6b6538555354712e706e67)](https://generalassemb.ly/education/web-development-immersive)

## My Note API

My Note API is the backend processor for the web application My Note. This API
manages CRUD activities for user accounts and note items. The API also performs
those activities with user authentication.

## Links
-   [My Note API Service](https://mynoteapi.herokuapp.com/)
-   [My Note Client](https://angmas.github.io/my-note-client/)

## Technologies Used
-   [`rails-api`](https://github.com/rails-api/rails-api)
-   [`rails`](https://github.com/rails/rails)
-   [`active_model_serializers`](https://github.com/rails-api/active_model_serializers)
-   [`ruby`](https://www.ruby-lang.org/en/)
-   [`postgres`](http://www.postgresql.org)

Until Rails 5 is released, this template should follow the most recent released
version of Rails 4, as well as track `master` branches for `rails-api` and
`active_model_serializers`.

## Installation

1.  Fork and clone this repository.
1.  Install dependencies with `bundle install`.
1.  Create a `.env` for sensitive settings (`touch .env`).
1.  Generate new `development` and `test` secrets (`bundle exec rake secret`).
1.  Store them in `.env` with keys `SECRET_KEY_BASE_<DEVELOPMENT|TEST>`
    respectively.
1.  In order to make requests to your deployed API, you will need to set
    `SECRET_KEY_BASE` in the environment of the production API (using `heroku
    config:set` or the Heroku dashboard).
1.  In order to make requests from your deployed client application, you will
    need to set `CLIENT_ORIGIN` in the environment of the production API (e.g.
    `heroku config:set CLIENT_ORIGIN https://<github-username>.github.io`).
1.  Setup your database with `bin/rake db:nuke_pave` or `bundle exec rake
    db:nuke_pave`.
1.  Run the API server with `bin/rails server` or `bundle exec rails server`.

## Structure
`curl` command scripts are stored in [`scripts`](scripts) with names that
correspond to API actions.

User authentication is built-in.

## Tasks

Developers should run these often!

-   `bin/rake routes` lists the endpoints available in your API.
-   `bin/rake test` runs automated tests.
-   `bin/rails console` opens a REPL that pre-loads the API.
-   `bin/rails db` opens your database client and loads the correct database.
-   `bin/rails server` starts the API.
-   `scripts/*.sh` run various `curl` commands to test the API. See below.

<!-- TODO -   `rake nag` checks your code style. -->
<!-- TODO -   `rake lint` checks your code for syntax errors. -->

## API

### Authentication

| Verb   | URI Pattern            | Controller#Action |
|--------|------------------------|-------------------|
| POST   | `/sign-up`             | `users#signup`    |
| POST   | `/sign-in`             | `users#signin`    |
| PATCH  | `/change-password/:id` | `users#changepw`  |
| DELETE | `/sign-out/:id`        | `users#signout`   |

#### POST /sign-up

Request:

```sh
curl http://localhost:4741/sign-up \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "'"${EMAIL}"'",
      "password": "'"${PASSWORD}"'",
      "password_confirmation": "'"${PASSWORD}"'"
    }
  }'
```

```sh
EMAIL=ava@bob.com PASSWORD=hannah scripts/sign-up.sh
```

Response:

```md
HTTP/1.1 201 Created
Content-Type: application/json; charset=utf-8

{
  "user": {
    "id": 1,
    "email": "ava@bob.com"
  }
}
```

#### POST /sign-in

Request:

```sh
curl http://localhost:4741/sign-in \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "'"${EMAIL}"'",
      "password": "'"${PASSWORD}"'"
    }
  }'
```

```sh
EMAIL=ava@bob.com PASSWORD=hannah scripts/sign-in.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "user": {
    "id": 1,
    "email": "ava@bob.com",
    "token": "BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f"
  }
}
```

#### PATCH /change-password/:id

Request:

```sh
curl --include --request PATCH "http://localhost:4741/change-password/$ID" \
  --header "Authorization: Token token=$TOKEN" \
  --header "Content-Type: application/json" \
  --data '{
    "passwords": {
      "old": "'"${OLDPW}"'",
      "new": "'"${NEWPW}"'"
    }
  }'
```

```sh
ID=1 OLDPW=hannah NEWPW=elle TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/change-password.sh
```

Response:

```md
HTTP/1.1 204 No Content
```

#### DELETE /sign-out/:id

Request:

```sh
curl http://localhost:4741/sign-out/$ID \
  --include \
  --request DELETE \
  --header "Authorization: Token token=$TOKEN"
```

```sh
ID=1 TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/sign-out.sh
```

Response:

```md
HTTP/1.1 204 No Content
```

### Users

| Verb | URI Pattern | Controller#Action |
|------|-------------|-------------------|
| GET  | `/users`    | `users#index`     |
| GET  | `/users/1`  | `users#show`      |

#### GET /users

Request:

```sh
curl http://localhost:4741/users \
  --include \
  --request GET \
  --header "Authorization: Token token=$TOKEN"
```

```sh
TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/users.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "users": [
    {
      "id": 2,
      "email": "bob@ava.com"
    },
    {
      "id": 1,
      "email": "ava@bob.com"
    }
  ]
}
```

#### GET /users/:id

Request:

```sh
curl --include --request GET http://localhost:4741/users/$ID \
  --header "Authorization: Token token=$TOKEN"
```

```sh
ID=2 TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/user.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
	"user": {
		"id": 30,
		"email": "a",
		"notes": [
			{
				"id": 44,
				"note_title": "another",
				"note_detail": "note",
				"favorite": false,
				"created_at": "2017-05-03T06:33:43.704Z",
				"updated_at": "2017-05-03T06:33:43.704Z"
			},
			{
				"id": 16,
				"note_title": "wan the april",
				"note_detail": "with",
				"favorite": false,
				"created_at": "2017-05-02T11:57:15.699Z",
				"updated_at": "2017-05-03T06:34:07.322Z"
			},
			{
				"id": 17,
				"note_title": "figuring out some code",
				"note_detail": "very",
				"favorite": false,
				"created_at": "2017-05-02T12:09:08.440Z",
				"updated_at": "2017-05-03T06:34:37.340Z"
			},
			{
				"id": 18,
				"note_title": "why isn't it getting",
				"note_detail": "to",
				"favorite": false,
				"created_at": "2017-05-02T12:11:31.596Z",
				"updated_at": "2017-05-03T06:35:29.279Z"
			},
			{
				"id": 45,
				"note_title": "4556",
				"note_detail": "234",
				"favorite": false,
				"created_at": "2017-05-03T06:40:13.688Z",
				"updated_at": "2017-05-03T06:40:13.688Z"
			},
			{
				"id": 19,
				"note_title": "one more time 200",
				"note_detail": "",
				"favorite": false,
				"created_at": "2017-05-02T12:13:59.392Z",
				"updated_at": "2017-05-03T06:50:08.237Z"
			},
			{
				"id": 46,
				"note_title": "chekced",
				"note_detail": "",
				"favorite": true,
				"created_at": "2017-05-03T06:54:38.135Z",
				"updated_at": "2017-05-03T06:54:38.135Z"
			},
			{
				"id": 20,
				"note_title": "testing",
				"note_detail": "test",
				"favorite": null,
				"created_at": "2017-05-02T13:11:10.885Z",
				"updated_at": "2017-05-03T06:57:29.987Z"
			},
			{
				"id": 21,
				"note_title": "after refactoring modal",
				"note_detail": "",
				"favorite": null,
				"created_at": "2017-05-02T13:15:18.723Z",
				"updated_at": "2017-05-03T07:00:19.812Z"
			},
			{
				"id": 23,
				"note_title": "for the issue",
				"note_detail": "for",
				"favorite": true,
				"created_at": "2017-05-02T13:29:55.068Z",
				"updated_at": "2017-05-03T07:02:58.262Z"
			},
			{
				"id": 24,
				"note_title": "test ",
				"note_detail": "test",
				"favorite": true,
				"created_at": "2017-05-02T14:08:08.310Z",
				"updated_at": "2017-05-03T07:05:05.529Z"
			},
			{
				"id": 25,
				"note_title": "check rails",
				"note_detail": "",
				"favorite": true,
				"created_at": "2017-05-02T15:43:51.171Z",
				"updated_at": "2017-05-03T07:07:42.582Z"
			},
			{
				"id": 29,
				"note_title": "not checked",
				"note_detail": "yes",
				"favorite": true,
				"created_at": "2017-05-02T23:53:41.285Z",
				"updated_at": "2017-05-03T07:10:00.306Z"
			},
			{
				"id": 13,
				"note_title": "checkbox woes",
				"note_detail": "",
				"favorite": true,
				"created_at": "2017-05-02T11:20:18.176Z",
				"updated_at": "2017-05-03T07:10:50.873Z"
			},
			{
				"id": 47,
				"note_title": "will ui2 work?",
				"note_detail": "",
				"favorite": true,
				"created_at": "2017-05-03T07:13:45.592Z",
				"updated_at": "2017-05-03T07:13:45.592Z"
			},
			{
				"id": 48,
				"note_title": "note not checked",
				"note_detail": "",
				"favorite": false,
				"created_at": "2017-05-03T07:14:20.637Z",
				"updated_at": "2017-05-03T07:14:20.637Z"
			},
			{
				"id": 49,
				"note_title": "note checked",
				"note_detail": "x",
				"favorite": true,
				"created_at": "2017-05-03T07:14:38.293Z",
				"updated_at": "2017-05-03T07:14:38.293Z"
			},
			{
				"id": 50,
				"note_title": "dasdf",
				"note_detail": "asdfsd",
				"favorite": true,
				"created_at": "2017-05-03T07:18:21.261Z",
				"updated_at": "2017-05-03T07:18:21.261Z"
			},
			{
				"id": 31,
				"note_title": "will ui2 work?",
				"note_detail": "",
				"favorite": true,
				"created_at": "2017-05-03T01:10:25.991Z",
				"updated_at": "2017-05-03T07:25:53.908Z"
			},
			{
				"id": 51,
				"note_title": "button check",
				"note_detail": "",
				"favorite": true,
				"created_at": "2017-05-03T07:47:48.047Z",
				"updated_at": "2017-05-03T07:47:48.047Z"
			},
			{
				"id": 35,
				"note_title": "asdf",
				"note_detail": "asfdd",
				"favorite": false,
				"created_at": "2017-05-03T05:52:49.510Z",
				"updated_at": "2017-05-03T07:48:22.907Z"
			},
			{
				"id": 52,
				"note_title": "asdf",
				"note_detail": "",
				"favorite": true,
				"created_at": "2017-05-03T08:12:02.846Z",
				"updated_at": "2017-05-03T08:12:02.846Z"
			},
			{
				"id": 37,
				"note_title": "will this fruit",
				"note_detail": "jkly",
				"favorite": true,
				"created_at": "2017-05-03T06:13:13.064Z",
				"updated_at": "2017-05-03T08:12:35.265Z"
			},
			{
				"id": 38,
				"note_title": "ert",
				"note_detail": "ertttt",
				"favorite": false,
				"created_at": "2017-05-03T06:15:24.463Z",
				"updated_at": "2017-05-03T08:12:53.389Z"
			},
			{
				"id": 39,
				"note_title": "zzzttt",
				"note_detail": "zzyyyy",
				"favorite": false,
				"created_at": "2017-05-03T06:18:50.404Z",
				"updated_at": "2017-05-03T08:13:04.152Z"
			},
			{
				"id": 40,
				"note_title": "f",
				"note_detail": "fff",
				"favorite": false,
				"created_at": "2017-05-03T06:20:17.668Z",
				"updated_at": "2017-05-03T08:13:12.121Z"
			},
			{
				"id": 42,
				"note_title": "another",
				"note_detail": "another4444",
				"favorite": false,
				"created_at": "2017-05-03T06:26:36.406Z",
				"updated_at": "2017-05-03T08:13:41.140Z"
			},
			{
				"id": 53,
				"note_title": "hunter",
				"note_detail": "",
				"favorite": true,
				"created_at": "2017-05-03T08:13:51.208Z",
				"updated_at": "2017-05-03T08:13:51.208Z"
			},
			{
				"id": 41,
				"note_title": "1111test",
				"note_detail": "1111test",
				"favorite": false,
				"created_at": "2017-05-03T06:26:27.719Z",
				"updated_at": "2017-05-03T08:14:09.684Z"
			}
		]
	}
}
```

## DELETE /notes/:id
Request:

```sh
API="${API_ORIGIN:-http://localhost:4741}"
URL_PATH="/notes"
curl "${API}${URL_PATH}/${ID}" \
  --include \
  --request DELETE \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=$TOKEN"
```

```sh
ID=44 TOKEN=BAhJIiU0MjM3MzY5NGFjZjdlNmVjOWYyOThiODBhNjdmMTk2OAY6BkVG--cc0568b3b1310f3dd803cabcb4a20ff880bb58a7 sh scripts/destroy-note.sh
```

Response:

```md
HTTP/1.1 204 No Content
```

## PATCH /notes/:id
Request:

```sh
API="${API_ORIGIN:-http://localhost:4741}"
URL_PATH="/notes"
curl "${API}${URL_PATH}/${ID}" \
  --include \
  --request PATCH \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=$TOKEN" \
  --data '{
    "note": {
      "note_detail": "'"${ND}"'"
    }
  }'
```

```sh
ID=42 TOKEN=BAhJIiU0MjM3MzY5NGFjZjdlNmVjOWYyOThiODBhNjdmMTk2OAY6BkVG--cc0568b3b1310f3dd803cabcb4a20ff880bb58a7 sh scripts/destroy-note.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{"note":{"id":42,"note_title":"another","note_detail":"readme","favorite":false,"created_at":"2017-05-03T06:26:36.406Z","updated_at":"2017-05-03T12:26:06.379Z"}}
```
### Reset Database without dropping

This is not a task developers should run often, but it is sometimes necessary.

**locally**

```sh
bin/rake db:migrate VERSION=0
bin/rake db:migrate db:seed db:examples
```

**heroku**

```sh
heroku run rake db:migrate VERSION=0
heroku run rake db:migrate db:seed db:examples
```

## [License](LICENSE)

1.  All content is licensed under a CC­BY­NC­SA 4.0 license.
1.  All software code is licensed under GNU GPLv3. For commercial use or
    alternative licensing, please contact legal@ga.co.
