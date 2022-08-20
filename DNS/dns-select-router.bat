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

CALL dns-select-auto.cmd %INTERFACE_NAME%

netsh interface ip set dns name="%INTERFACE_NAME%" static 192.168.0.1 validate=no

ipconfig /flushdns

:: Exit

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Usage: dns-select-google #1
ECHO		#1 -^> The interface name
ECHO		Eg. dns-select-google Wi-Fi

:: Exit

:L_EXIT