@ECHO OFF

:: N-Args

SET NARGS=0
FOR %%I IN (%*) DO (
   SET /A NARGS+=1
   SET "ARGV[!NARGS!]=%%~I"
)

:: N-Args

IF %NARGS% NEQ 3 (
	GOTO L_INVALID_NARGS
)

:: Body

SET RSA_PUBLIC_FILE_NAME=%1
SET RSA_SIGNED_FILE_NAME=%2
SET RSA_PLAIN_FILE_NAME=%3

openssl dgst -sha1 -verify %RSA_PUBLIC_FILE_NAME% -signature %RSA_SIGNED_FILE_NAME% %RSA_PLAIN_FILE_NAME%

:: Exit

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Usage: openssl-verify.cmd #1 #2 #3
ECHO		#1 -^> [I] The name of public key file
ECHO		#2 -^> [I] The name of signed file
ECHO		#3 -^> [I] The name of plain file
ECHO	Example: openssl-verify.cmd pub.pem test.signed.txt test.txt

:: Exit

:L_EXIT