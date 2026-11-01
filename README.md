# Fitgress
App to follow your fitness progress in different tracks

## Run locally

Start the database first. Run the backend and frontend in separate terminals from the repository root.

### Database

```powershell
docker compose up -d postgres
```

### Backend

Requires JDK 25. Set `FITGRESS_JDK_HOME` to the path of the JDK 25 directory:
```powershell
setx FITGRESS_JDK_HOME "C:\path\to\jdk-25"
```

Run the env script then the API:
```powershell
cd backend
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
