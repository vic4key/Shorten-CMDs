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

netsh interface ip set dns name="%INTERFACE_NAME%" static 1.1.1.1 validate=no
netsh interface ip add dns name="%INTERFACE_NAME%" 1.0.0.1 index=2 validate=no

ipconfig /flushdns

:: Exit

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Usage: dns-select-cloudflare #1
ECHO		#1 -^> The interface name
ECHO		Eg. dns-select-cloudflare Wi-Fi

:: Exit

:L_EXIT