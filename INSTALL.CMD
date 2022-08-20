@ECHO OFF

SETLOCAL EnableDelayedExpansion

ECHO *** INSTALL SHORTEN CLI ***

ECHO.

:: Ask for confirmation to continue

SET /p response=[?] Would You Like To Append These Shorten CLI To User's PATH Environment Variable (Y/[N]) ? 
SET "confirm=0"
IF [%response%]==[Y] SET confirm=1
IF [%response%]==[y] SET confirm=1

IF [%confirm%]==[1] (
  REM ECHO.
) ELSE (
  ECHO [+] Cancelled
  GOTO L_CANCELLED
)

SET SHORTEN_CLI_DIRS=%CD%\OS\Windows;%CD%\GitHub;%CD%\PyVE;%CD%\Open-SSL;%CD%\DNS

:: Ask for OS platform and update OS's relevant dirs to SHORTEN_CLI_DIRS

SET /p response=[?] You're Using 64-bit ? (Y/[N]) ? 
SET "conditions=0"
IF [%response%]==[Y] SET conditions=1
IF [%response%]==[y] SET conditions=1

IF [%conditions%]==[1] (
	SET SHORTEN_CLI_DIRS=%SHORTEN_CLI_DIRS%;%CD%\Open-SSL\openssl-1.1\x64\bin
) else (
	SET SHORTEN_CLI_DIRS=%SHORTEN_CLI_DIRS%;%CD%\Open-SSL\openssl-1.1\x86\bin
)

:: ECHO %SHORTEN_CLI_DIRS%

:: Install required

ECHO Installing required ...
pip install virtualenv

:: Make backup file path with date time format eg. 20221221_1234

SET _DELIMITER=
SET _DATE=%date:~-4,4%%date:~-7,2%%date:~-10,2%
SET _TIME=%TIME%
SET _TIME=%_TIME:~0,-3%
SET _TIME=%_TIME::=!_DELIMITER!%
SET DATE_TIME=%_DATE%_%_TIME: =0%
SET BACKUP_FILE_PATH=%CD%\USER_PATH_ENV_%DATE_TIME%.reg

:: Backup User's Path Environment Variable

ECHO [+] Backup User's Path Environment Variable to '%BACKUP_FILE_PATH%'

SET REG_PATH_USR_KEY=HKEY_CURRENT_USER\Environment
SET REG_PATH_USR_VAL=Path

REGEDIT /e "%BACKUP_FILE_PATH%" "%REG_PATH_USR_KEY%"

:: Get User's Environment Variable

FOR /F "tokens=2*" %%A in ('REG QUERY %REG_PATH_USR_KEY% /v %REG_PATH_USR_VAL%') DO (SET PATH_USR=%%~B)
SET PATH_USR=%PATH_USR%;%SHORTEN_CLI_DIRS%
:: ECHO %PATH_USR%

:: Modify User's Environment Variable 

ECHO [+] Add Shorten CLI To User's Path Environment Variable

REG ADD "%REG_PATH_USR_KEY%" /f /v "%REG_PATH_USR_VAL%" /t REG_SZ /d "%PATH_USR%"

:: Make a fake notification to all applications that OS's settings changed
ECHO Applying changes to OS's settings ...
SETX OPENSSL_CONF "%CD%\Open-SSL\openssl-1.1\ssl\openssl.cnf"
:: SETX OS_SETTINGS_CHANGED 1

:L_CANCELLED

PAUSE