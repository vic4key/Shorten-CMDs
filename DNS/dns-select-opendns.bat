@ECHO OFF

SET NARGS=0
FOR %%I IN (%*) DO (
   SET /A NARGS+=1
   SET "ARGV[!NARGS!]=%%~I"
)

:: N-Args

IF %NARGS% NEQ 1 (
	GOTO L_INVALID_NARGS
)

SET INTERFACE_NAME=%1

ECHO Changing DNS Server ...

netsh interface ip set dns name="%INTERFACE_NAME%" static 208.67.222.222 validate=no
netsh interface ip add dns name="%INTERFACE_NAME%" 208.67.220.220 index=2 validate=no

ipconfig /flushdns

:: Exit

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Usage: dns-select-opendns #1
ECHO		#1 -^> The interface name
ECHO		Eg. dns-select-opendns Wi-Fi

:: Exit

:L_EXIT