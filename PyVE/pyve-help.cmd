@ECHO OFF

ECHO List of commands as the following :

FOR /R %%i IN (pyve-*.cmd) DO (
	ECHO 	%%~ni
)