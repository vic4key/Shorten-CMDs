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

SET RSA_PRIVATE_FILE_NAME=%1
SET RSA_ENCRYPTED_FILE_NAME=%2
SET RSA_DECRYPTED_FILE_NAME=%3

openssl rsautl -decrypt -inkey %RSA_PRIVATE_FILE_NAME% -in %RSA_ENCRYPTED_FILE_NAME% -out %RSA_DECRYPTED_FILE_NAME%

:: Exit

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Usage: openssl-decrypt.cmd #1 #2 #3
ECHO		#1 -^> [I] The name of private key file
ECHO		#2 -^> [I] The name of encrypted file
ECHO		#3 -^> [O] The name of decrypted file
ECHO	Example: openssl-decrypt.cmd pri.pem test.encrypted.txt test.decrypted.txt

:: Exit

:L_EXIT