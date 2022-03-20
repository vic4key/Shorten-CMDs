@ECHO OFF

:: N-Args

SET NARGS=0
FOR %%I IN (%*) DO (
   SET /A NARGS+=1
   SET "ARGV[!NARGS!]=%%~I"
)

:: N-Args

IF %NARGS% NEQ 2 (
	GOTO L_INVALID_NARGS
)

:: Body

SET RSA_PRIVATE_FILE_NAME=%1
SET RSA_PUBLIC_FILE_NAME=%2

openssl rsa -pubout -in %RSA_PRIVATE_FILE_NAME% -out %RSA_PUBLIC_FILE_NAME%

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Usage: openssl-gen-pub.cmd #1 #2
ECHO		#1 -^> [I] The name of private key file
ECHO		#2 -^> [O] The name of public key file
ECHO	Example: openssl-gen-pub.cmd pri.pem pub.pem

:: Exit

:L_EXIT