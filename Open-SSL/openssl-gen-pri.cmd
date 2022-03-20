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
SET RSA_PRIVATE_KEY_SIZE=%2

openssl genrsa -out %RSA_PRIVATE_FILE_NAME% %RSA_PRIVATE_KEY_SIZE%

:: Exit

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Usage: openssl-gen-pri.cmd #1 [#2]
ECHO		#1 -^> [O] The name of private key file
ECHO		#2 -^> [I] The size of private key file (Example: 2048-bits)
ECHO	Example: openssl-gen-pri.cmd pri.pem 2048

:: Exit

:L_EXIT