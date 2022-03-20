@ECHO OFF

:: N-Args

SET NARGS=0
FOR %%I IN (%*) DO (
   SET /A NARGS+=1
   SET "ARGV[!NARGS!]=%%~I"
)

:: N-Args

IF %NARGS% LSS 1 (
	GOTO L_INVALID_NARGS
)

:: Add

git submodule add --force %*

:: Exit

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Usage: git-sub-add #1
ECHO		#1 -^> The repository url
ECHO	Example: git-sub-add https://github.com/vic4key/Vutils.git

:: Exit

:L_EXIT