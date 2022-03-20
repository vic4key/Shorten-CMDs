@ECHO OFF

SETLOCAL ENABLEDELAYEDEXPANSION

ECHO DF Iterator 1.0

SET NARGS=0
FOR %%I IN (%*) DO (
   SET /A NARGS+=1
   SET "ARGV[!NARGS!]=%%~I"
)

:: N-Args

IF %NARGS% LSS 2 (
	GOTO L_INVALID_NARGS
)

SET WILDCARD=%1

SET ARGS=%*
SET ARGS=!ARGS:*%1 =!

ECHO The file wild-card : `%WILDCARD%`
ECHO The file command   : `%ARGS%`
ECHO.

:: <NA>  - List files in the current directory
:: /R    - List recursive files in the current directory
:: /D    - List directories in the current directory
:: /R /D - List recursive directories in the current directory

FOR /R %%i IN (%WILDCARD%) DO (
	CMD /c ECHO %ARGS%
	CMD /c %ARGS%
)

:: Exit

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Usage: itdf #1 #2
ECHO		#1 -^> The wildcard for iterating
ECHO		#2 -^> The command to execute to iterated file
ECHO		Eg.
ECHO		   ITFILE ECHO %%~i   - Display removing any surrounding quotes ("")
ECHO		   ITFILE ECHO %%~fi  - Display fully qualified path name
ECHO		   ITFILE ECHO %%~di  - Display drive letter only
ECHO		   ITFILE ECHO %%~pi  - Display path only
ECHO		   ITFILE ECHO %%~nxi - Display file name and extension only
ECHO		   ITFILE ECHO %%~ni  - Display file name only
ECHO		   ITFILE ECHO %%~xi  - Display file extension only
ECHO		   ITFILE ECHO %%~si  - Display path contains short names only
ECHO		   ITFILE ECHO %%~ai  - Display le attributes of file
ECHO		   ITFILE ECHO %%~ti  - Display te/time of file
ECHO		   ITFILE ECHO %%~zi  - Display ze of file

:: Exit

:L_EXIT