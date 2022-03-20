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

SET RSA_PUBLIC_FILE_NAME=%1

openssl rsa -pubin -inform PEM -text -noout -in %RSA_PUBLIC_FILE_NAME%

:: Exit

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Usage: openssl-view-pub.cmd #1
ECHO		#1 -^> [I] The name of public key file
ECHO	Example: openssl-view-pub.cmd pub.pem

:: Exit

:L_EXIT