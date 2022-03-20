@ECHO OFF

:: N-Args

SET NARGS=0
FOR %%I IN (%*) DO (
   SET /A NARGS+=1
   SET "ARGV[!NARGS!]=%%~I"
)

:: N-Args

SET AFN=create

IF %NARGS% NEQ 1 (
	GOTO L_INVALID_NARGS
)

virtualenv %1

:: Exit

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Usage: pyve-%AFN% #1
ECHO		#1 -^> The name of python virtual enviroment
ECHO	Example:
ECHO		pyve-%AFN% example

:: Exit

:L_EXIT