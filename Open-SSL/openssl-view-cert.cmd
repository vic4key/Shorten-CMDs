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

SET VIEW_CER_TYPE=%1
SET VIEW_CERT_FILE=%2

IF /I "%VIEW_CER_TYPE%"=="crt" (
  openssl x509 -in %VIEW_CERT_FILE% -text -noout
) ELSE IF /I "%VIEW_CER_TYPE%"=="csr" (
  openssl req -in %VIEW_CERT_FILE% -noout -text
) ELSE IF /I "%VIEW_CER_TYPE%"=="key" (
  openssl rsa -in %VIEW_CERT_FILE% -check
) ELSE (
  GOTO L_INVALID_NARGS
)

::openssl genrsa -out %RSA_PRIVATE_FILE_NAME% %RSA_PRIVATE_KEY_SIZE%

:: Exit

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Usage: openssl-view-cert.cmd #1 [#2]
ECHO		#1 -^> [I] The view type (Types: crt, csr, key)
ECHO		#2 -^> [I] The crt/csr/key file
ECHO	Example: openssl-view-cert.cmd crt example.crt

:: Exit

:L_EXIT