@echo off
setlocal

pushd "%~dp0.." || exit /b 1
if exist ".env" (
    for /f "usebackq eol=# tokens=1,* delims==" %%A in (".env") do (
        if "%%A"=="FITGRESS_DB_NAME" set "LOCAL_FITGRESS_DB_NAME=%%B"
        if "%%A"=="FITGRESS_DB_USER" set "LOCAL_FITGRESS_DB_USER=%%B"
        if "%%A"=="FITGRESS_DB_PASSWORD" set "LOCAL_FITGRESS_DB_PASSWORD=%%B"
        if "%%A"=="POSTGRES_PORT" set "LOCAL_POSTGRES_PORT=%%B"
    )
)

if not defined FITGRESS_DB_NAME if defined LOCAL_FITGRESS_DB_NAME set "FITGRESS_DB_NAME=%LOCAL_FITGRESS_DB_NAME%"
if not defined FITGRESS_DB_USER if defined LOCAL_FITGRESS_DB_USER set "FITGRESS_DB_USER=%LOCAL_FITGRESS_DB_USER%"
if not defined FITGRESS_DB_PASSWORD if defined LOCAL_FITGRESS_DB_PASSWORD set "FITGRESS_DB_PASSWORD=%LOCAL_FITGRESS_DB_PASSWORD%"
if not defined POSTGRES_PORT if defined LOCAL_POSTGRES_PORT set "POSTGRES_PORT=%LOCAL_POSTGRES_PORT%"
if not defined FITGRESS_DB_NAME set "FITGRESS_DB_NAME=fitgress"
if not defined FITGRESS_DB_USER set "FITGRESS_DB_USER=fitgress"
if not defined FITGRESS_DB_PASSWORD set "FITGRESS_DB_PASSWORD=fitgress"
if not defined POSTGRES_PORT set "POSTGRES_PORT=5432"
if not defined FITGRESS_DB_URL set "FITGRESS_DB_URL=jdbc:postgresql://localhost:%POSTGRES_PORT%/%FITGRESS_DB_NAME%"

if exist "backend\mvnw.cmd" (
    call "backend\mvnw.cmd" -f "backend\pom.xml" -Dflyway.cleanDisabled=false flyway:clean flyway:migrate %*
) else (
    mvn -f "backend\pom.xml" -Dflyway.cleanDisabled=false flyway:clean flyway:migrate %*
)
set "MAVEN_EXIT_CODE=%ERRORLEVEL%"
popd
exit /b %MAVEN_EXIT_CODE%
