@ECHO OFF

ECHO List of Open SSL commands :

ECHO    1. openssl-gen-pri.cmd  - Generate a private key file
ECHO    2. openssl-gen-pub.cmd  - Generate a public key file
ECHO    -
ECHO    3. openssl-view-pri.cmd - View a private key file
ECHO    4. openssl-view-pub.cmd - View a public key file
ECHO    -
ECHO    5. openssl-encrypt.cmd  - Encrypt a plain file with a public key file
ECHO    6. openssl-decrypt.cmd  - Decrypt an encrypted file with a private key file
ECHO    -
ECHO    7. openssl-sign.cmd     - Sign a plain file
ECHO    8. openssl-verify.cmd   - Verify a signed file
ECHO    -
ECHO    9.  openssl-gen-cert-key.cmd - Generate a certification key file
ECHO    10. openssl-gen-cert-csr.cmd - Generate a ca-signed certification file
ECHO    11. openssl-gen-cert-crt.cmd - Generate a certification file
ECHO    12. openssl-view-cert.cmd    - View a certification file

:: FOR /R %%i IN (openssl-*.cmd) DO (
::	ECHO 	%%~nxi
::)