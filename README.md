# Fitgress
App to follow your fitness progress in different tracks

## Run locally

Start the database first. Run the backend and frontend in separate terminals from the repository root.

### Database

```powershell
docker compose up -d postgres
```

### Resetting the local database

The database must already be running via Docker Compose. The reset scripts read the
database name, user, password, and port from `.env`.\
Environment variables already set in the current shell and extra Maven `-Dflyway.*`
arguments take precedence.

- Linux/MacOS: `./dev/reset-db.sh`
- Windows: `dev\reset-db.cmd`.

### Backend

Requires JDK 25. Set `FITGRESS_JDK_HOME` in the root `.env` file to your local
JDK 25 path, using the path format for your platform, e.g.:
- Linux/MacOS: `/path/to/jdk-25/Contents/Home/` 
- Windows: `path/to/jdk/jdk-25.0.2+10/`

```sh
cd backend
```

On Linux or macOS:
```sh
. ./env.sh
./mvnw spring-boot:run
```

On Windows:
```powershell
. .\env.ps1
.\mvnw.cmd spring-boot:run
```

### Frontend

```powershell
cd frontend
npm ci
npm start
```

### Documentation

```powershell
uv sync
uv run zensical serve
```
