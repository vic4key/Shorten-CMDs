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
SET RSA_PLAIN_FILE_NAME=%2
SET RSA_ENCRYPTED_FILE_NAME=%3

openssl rsautl -encrypt -inkey %RSA_PUBLIC_FILE_NAME% -pubin -in %RSA_PLAIN_FILE_NAME% -out %RSA_ENCRYPTED_FILE_NAME%

:: Exit

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Usage: openssl-encrypt.cmd #1 #2 #3
ECHO		#1 -^> [I] The name of public key file
ECHO		#2 -^> [I] The name of plain file
ECHO		#3 -^> [O] The name of encrypted file
ECHO	Example: openssl-encrypt.cmd pub.pem test.txt test.encrypted.txt

:: Exit

:L_EXIT