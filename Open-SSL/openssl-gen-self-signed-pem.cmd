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

SET SELF_SIGNED_FILE_NAME=%1
SET PRIVATE_KEY_FILE_NAME=%2

openssl req -newkey rsa:2048 -new -nodes -x509 -days 365 -keyout %PRIVATE_KEY_FILE_NAME% -out %SELF_SIGNED_FILE_NAME%

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Generate a self-signed file (for ssl certificate, server, etc)
ECHO	Usage: openssl-gen-self-signed-pem.cmd #1 #2
ECHO		#1 -^> [O] The name of self-signed pem file (default key length is 2048)
ECHO		#2 -^> [O] The name of private key file (auto combine to a single .pem file if same name with self-signed file name)
ECHO	Example: openssl-gen-self-signed-pem.cmd self-signed.pem self-signed.pem

:: Exit

:L_EXIT

rem https://www.suse.com/support/kb/doc/?id=000018152
rem openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout key.pem -out cert.pem

rem https://serverfault.com/questions/889581/how-to-generate-a-pem-certificate-in-an-easy-way-for-testing
rem first generate CSR and KEY
rem openssl req -new -newkey rsa:4096 -nodes -keyout snakeoil.key -out snakeoil.csr
rem then generate PEM and self-sign with KEY
rem openssl x509 -req -sha256 -days 365 -in snakeoil.csr -signkey snakeoil.key -out snakeoil.pem