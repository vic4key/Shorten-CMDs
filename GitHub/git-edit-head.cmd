@ECHO OFF

FOR /f %%V IN ('git rev-parse --short HEAD') DO SET "HEAD_ID=%%V"

SET /p response=[+] Edit the last commit or HEAD `%HEAD_ID%` ? 
SET "confirm=0"
IF [%response%]==[Y] SET confirm=1
IF [%response%]==[y] SET confirm=1

IF [%confirm%]==[0] (
  GOTO L_CANCELLED
)

SET /p type=[+] Enter the new commit message : 
IF NOT [%type%]==[] (
  git commit --amend -m %type%
) ELSE (
  git commit --amend --no-edit
)

git-commit-force

GOTO L_EXIT

:: Cancelled

:L_CANCELLED
ECHO Cancelled

:: Exit

:L_EXIT