@ECHO OFF

:: N-Args

SET NARGS=0
FOR %%I IN (%*) DO (
   SET /A NARGS+=1
   SET "ARGV[!NARGS!]=%%~I"
)

:: N-Args

IF %NARGS% NEQ 1 (
	GOTO L_INVALID_NARGS
)

:: Body

SET RSA_PRIVATE_FILE_NAME=%1

openssl rsa -in %RSA_PRIVATE_FILE_NAME% -text -noout

:: Exit

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Usage: openssl-view-pri.cmd #1
ECHO		#1 -^> [I] The name of private key file
ECHO	Example: openssl-view-pri.cmd pri.pem

:: Exit

:L_EXIT