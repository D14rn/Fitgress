# Fitgress
App to follow your fitness progress in different tracks

## Run locally

Start the database first. Run the backend and frontend in separate terminals from the repository root.

### Database

```powershell
docker compose up -d postgres
```

### Backend

Requires JDK 25. From the repository root, enter the backend directory:
```sh
cd backend
```

On Linux or macOS, set `FITGRESS_JDK_HOME` to the JDK 25 directory, then source the environment script:
```sh
export FITGRESS_JDK_HOME="/path/to/jdk-25"
. ./env.sh
./mvnw spring-boot:run
```

On Windows, set `FITGRESS_JDK_HOME` to the JDK 25 directory (this persists the environment variable):
```powershell
setx FITGRESS_JDK_HOME "C:\path\to\jdk-25"
```
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
