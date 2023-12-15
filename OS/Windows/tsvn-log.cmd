@ECHO OFF

SETLOCAL EnableDelayedExpansion

:: Parse the parameters
SET SVN_URL=%1
SET SVN_REV=%~2

:: Count the number of paremeter
SET /A N=0
:L_NARG_START
IF .%1==. GOTO L_NARG_NEXT
SET /A N=%N%+1
SHIFT
GOTO L_NARG_START
:L_NARG_NEXT

:: Go to say enter command to go to help
IF %N% EQU 0 (
  GOTO L_NONARG
)

:: Go to help

IF /I %SVN_URL% EQU ^-H (
  GOTO L_HELP
)

IF /I %SVN_URL% EQU ^-HELP (
  GOTO L_HELP
)

IF /I %SVN_URL% EQU ^--HELP (
  GOTO L_HELP
)

IF /I %SVN_URL% EQU ^/H (
  GOTO L_HELP
)

IF /I %SVN_URL% EQU ^/HELP (
  GOTO L_HELP
)

:: Remove the first dequote char in the in the SVN_URL variable
IF "!SVN_URL:~0,1!" EQU ^"^"^" (
  SET SVN_URL=!SVN_URL:~1,-1!
)

:: Remove the last dequote char in the in the SVN_URL variable
IF "ECHO !SVN_URL:~-1!" EQU ^"^"^" (
  SET SVN_URL=!SVN_URL:~1!
)

IF /i "%SVN_URL:~0,4%"=="http" (
  REM ECHO OK
) ELSE IF /i "%SVN_URL:~0,4%"=="/eng" (
  SET SVN_URL=!TSVN_DEFAULT_SERVER!!SVN_URL!
) ELSE IF /i "%SVN_URL:~0,8%"=="/vietnam" (
  SET SVN_URL=!TSVN_DEFAULT_SERVER!/eng!SVN_URL!
)

:: Run the command

IF %N% EQU 1 (
  ECHO Show log of %SVN_URL% from HEAD
  TortoiseProc.exe /command:log /path:"!SVN_URL!" /startrev:HEAD
  GOTO L_DONE
)

IF %N% EQU 2 (
  ECHO Show log of %SVN_URL% from %SVN_REV%
  TortoiseProc.exe /command:log /path:"!SVN_URL!" /startrev:%SVN_REV%
  GOTO L_DONE
)

:L_DONE
REM ECHO    Done^^!

GOTO L_EXIT

::Help
:L_HELP
ECHO Usage: tsvn-log #1 [#2]
ECHO    #1 -^> The url of branch
ECHO    #2 -^> The start revision (Default at HEAD)
ECHO Show log of a branch by Tortoise SVN.

GOTO L_EXIT

:L_NONARG
ECHO Usage: tsvn-log #1 [#2]
ECHO Try ^'tsvn-log --help^' for more information.

:: Exit
:L_EXIT