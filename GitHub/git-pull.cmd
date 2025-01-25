@ECHO OFF

SETLOCAL ENABLEDELAYEDEXPANSION

:: N-Args

SET NARGS=0
FOR %%I IN (%*) DO (
   SET /A NARGS+=1
   SET "ARGV[!NARGS!]=%%~I"
)

:: Status/Differences

IF !NARGS! NEQ 0 (
    git pull --no-rebase origin !ARGV[1]! !ARGV[2]! !ARGV[3]!
) ELSE (
    FOR /F "delims=" %%i IN ('git branch --show-current') DO (
        SET "BRANCH_NAME=%%i"
        git pull --no-rebase -- "origin" !BRANCH_NAME!
    )
)

ENDLOCAL
