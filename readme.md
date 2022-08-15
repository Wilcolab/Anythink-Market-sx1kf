# Welcome to the Anythink Market repo

To start the app use Docker. It will start both frontend and backend, including all the relevant dependencies, and the db.

Please find more info about each part in the relevant Readme file ([frontend](frontend/readme.md) and [backend](backend/README.md)).

## Development

When implementing a new feature or fixing a bug, please create a new pull request against `main` from a feature/bug branch and add `@vanessa-cooper` as reviewer.

## First setup

- Install Docker
- Verify Docker: `docker -v` and `docker-compose -v`
- Run Docker Compose on the project root directory: `docker-compose up`
- Test the backend accessing [http://localhost:3000/api/ping](http://localhost:3000/api/ping)
- Test the frontend accesing [http://localhost:3001/register](http://localhost:3001/register)

