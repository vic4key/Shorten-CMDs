@ECHO OFF

FOR /f %%V IN ('git rev-parse --short HEAD') DO SET "HEAD_ID=%%V"

SET /p response=[+] Delete the last commit or HEAD `%HEAD_ID%` ? 
SET "confirm=0"
IF [%response%]==[Y] SET confirm=1
IF [%response%]==[y] SET confirm=1

IF [%confirm%]==[1] (
  git rebase -i HEAD~2
  git-commit-force
) ELSE (
  ECHO Cancelled
)