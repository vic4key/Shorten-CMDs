@ECHO OFF

:: N-Args

SET NARGS=0
FOR %%I IN (%*) DO (
   SET /A NARGS+=1
   SET "ARGV[!NARGS!]=%%~I"
)

:: N-Args

IF %NARGS% NEQ 4 (
	GOTO L_INVALID_NARGS
)

:: Body

SET CERT_KEY_FILE_NAME=%1
SET CERT_CSR_FILE_NAME=%2
SET CERT_CRT_FILE_NAME=%3
SET CERT_NDATE_EXPIRED=%4

openssl x509 -req -days %CERT_NDATE_EXPIRED% -in %CERT_CSR_FILE_NAME% -signkey %CERT_KEY_FILE_NAME% -out %CERT_CRT_FILE_NAME%

:: Exit

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Usage: openssl-gen-cert-crt.cmd #1 #2 #3 #4
ECHO		#1 -^> [I] The name of certification key file
ECHO		#2 -^> [I] The name of ca-signed certificate file
ECHO		#3 -^> [O] The name of certificate file
ECHO		#4 -^> [I] The number of expired dates (Example: 365 days).
ECHO	Example: openssl-gen-cert-crt.cmd example.key example.csr example.crt 365

:: Exit

:L_EXIT