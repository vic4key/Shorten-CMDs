@ECHO OFF

:: N-Args

SET NARGS=0
FOR %%I IN (%*) DO (
   SET /A NARGS+=1
   SET "ARGV[!NARGS!]=%%~I"
)

:: N-Args

IF %NARGS% EQU 0 (
	GOTO L_INVALID_NARGS
)

:: Clone

git clone %*

:: Exit

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Usage: git-clone #1
ECHO		#1 -^> The repository url
ECHO	Example:
ECHO		git-clone https://github.com/test/example.git
ECHO		git-clone https://github.com/test/example.git example-v2

:: Exit

:L_EXIT