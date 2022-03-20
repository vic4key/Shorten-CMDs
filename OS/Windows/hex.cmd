@ECHO OFF

:: N-Args

SET NARGS=0
FOR %%I IN (%*) DO (
   SET /A NARGS+=1
   SET "ARGV[!NARGS!]=%%~I"
)

:: N-Args

IF %NARGS% EQU 0 (
	GOTO L_INVALID_NARGS
)

:: Args
SET ARGS=-C
IF %NARGS% GEQ 2 (
  SET /A NCOLS=16
  SET /A NROWS=%2
  SET /A NBYTES=%NCOLS%*%NROWS%
  SET ARGS=%ARGS% -n %NBYTES%
)
SET ARGS=%ARGS% %1

HEXDUMP %ARGS%

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Usage: hex.cmd #1 #2
ECHO    #1 -^> [I] The name of data file
ECHO    #2 -^> [I] The number of lines (1 line = 16 bytes)
ECHO	Example: hex.cmd data.bin 7

:: Exit

:L_EXIT