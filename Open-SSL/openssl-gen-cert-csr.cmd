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

SET CERT_KEY_FILE_NAME=%1
SET CERT_CSR_FILE_NAME=%2

openssl req -new -key %CERT_KEY_FILE_NAME% -out %CERT_CSR_FILE_NAME%

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Usage: openssl-gen-cert-csr.cmd #1 #2
ECHO		#1 -^> [I] The name of certification key file
ECHO		#2 -^> [O] The name of ca-signed certificate file
ECHO	Example: openssl-gen-cert-csr.cmd example.key example.csr

:: Exit

:L_EXIT