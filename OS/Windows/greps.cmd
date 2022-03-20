@ECHO OFF

SETLOCAL EnableDelayedExpansion

:: Parse the parameters
SET KEYWORD=%1
SET EXTENSION=%~2
SET DIRECTORY=%~3

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

IF /I %KEYWORD% EQU ^-H (
  GOTO L_HELP
)

IF /I %KEYWORD% EQU ^-HELP (
  GOTO L_HELP
)

IF /I %KEYWORD% EQU ^--HELP (
  GOTO L_HELP
)

IF /I %KEYWORD% EQU ^/H (
  GOTO L_HELP
)

IF /I %KEYWORD% EQU ^/HELP (
  GOTO L_HELP
)

:: Remove the first dequote char in the in the keyword variable
IF "!KEYWORD:~0,1!" EQU ^"^"^" (
  SET KEYWORD=!KEYWORD:~1,-1!
)

:: Remove the last dequote char in the in the keyword variable
IF "ECHO !KEYWORD:~-1!" EQU ^"^"^" (
  SET KEYWORD=!KEYWORD:~1!
)

:: Show the options
ECHO Option:

ECHO    Use %N% parameter(s)

IF %N% GEQ 1 (
ECHO    Keyword     -^> !KEYWORD!
) ELSE (
ECHO    Keyword     -^> ^<None^>
)

IF %N% GEQ 2 (
ECHO    Extension   -^> %EXTENSION%
) ELSE (
ECHO    Extension   -^> ^<None^>
)

IF %N% GEQ 3 (
ECHO    Directory   -^> %DIRECTORY%
) ELSE (
ECHO    Directory   -^> ^<None^>
)

:: Start to search
ECHO Result:

IF %N% EQU 1 (
  GREP -rina --color=auto --regex="!KEYWORD!"
  GOTO L_DONE
)

IF %N% EQU 2 (
  GREP -rina --color=auto --regex="!KEYWORD!" --include=*.{%EXTENSION%}
  GOTO L_DONE
)

IF %N% GEQ 3 (
  GREP -rina --color=auto --regex="!KEYWORD!" --include=*.{%EXTENSION%} %DIRECTORY%
  GOTO L_DONE
)

:L_DONE
ECHO    Done^^!

GOTO L_EXIT

::Help
:L_HELP
ECHO Usage: greps #1 [#2 #3]
ECHO    #1 -^> The keyword to search
ECHO    #2 -^> The file extensions to search
ECHO    #3 -^> The directory to search
ECHO Recursively find all files in current and subfolders based on pattern matching.
ECHO Pattern is, by default, a basic regular expression (BRE).
ECHO Example:
ECHO   GREPS "Keyword"
ECHO   GREPS "Keyword" "txt,log,dat"
ECHO   GREPS "Keyword" "txt,log,dat" *

GOTO L_EXIT

:L_NONARG
ECHO Usage: greps #1 [#2 #3]
ECHO Try ^'greps --help^' for more information.

:: Exit
:L_EXIT