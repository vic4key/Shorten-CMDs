@ECHO OFF

:: N-Args

SET NARGS=0
FOR %%I IN (%*) DO (
   SET /A NARGS+=1
   SET "ARGV[!NARGS!]=%%~I"
)

:: N-Args

IF %NARGS% NEQ 1 (
	GOTO L_INVALID_NARGS
)

:: Commit

SET message=%1
git commit -m %message%

:: Push

SET /p response=[+] Push changes to remote reposity ? 
SET "confirm=0"
IF [%response%]==[Y] SET confirm=1
IF [%response%]==[y] SET confirm=1

IF [%confirm%]==[1] (
  git push
) ELSE (
  ECHO Canceled
)

:: Exit

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Usage: git-commit #1
ECHO		#1 -^> The message for git commit
ECHO	Example: git-commit "The message for git commit"

:: Exit

:L_EXIT