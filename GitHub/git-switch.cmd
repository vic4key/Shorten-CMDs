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

:: Switch

SET tag_name=%1
git checkout -b %tag_name%
git checkout %tag_name%

:: Exit

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Usage: git-switch #1
ECHO		#1 -^> The tag name
ECHO	Example: git-switch dev

:: Exit

:L_EXIT