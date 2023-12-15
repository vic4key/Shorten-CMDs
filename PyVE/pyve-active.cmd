@ECHO OFF

:: N-Args

SET NARGS=0
FOR %%I IN (%*) DO (
   SET /A NARGS+=1
   SET "ARGV[!NARGS!]=%%~I"
)

:: N-Args

SET AFN=activate

IF %NARGS% EQU 0 (
	IF EXIST %CD%\Scripts\%AFN%.bat (
		%CD%\Scripts\%AFN%.bat
		IF EXIST %CD%\.cmd (CALL .cmd)
	) ELSE (
		GOTO L_INVALID_NARGS
	)
) ELSE IF %NARGS% EQU 1 (
	IF [%1]==[.] (
		IF EXIST %CD%\Scripts\%AFN%.bat (
			%CD%\Scripts\%AFN%.bat
			IF EXIST %CD%\.cmd (CALL .cmd)
		) ELSE (
			GOTO L_INVALID_NARGS
		)
		%CD%\Scripts\%AFN%.bat
	) ELSE IF EXIST %CD%\%1\Scripts\%AFN%.bat (
		%CD%\%1\Scripts\%AFN%.bat
		IF EXIST %CD%\%1\.cmd (CALL %CD%\%1\.cmd)
		CD "%CD%\%1"
	) ELSE (
		GOTO L_INVALID_NARGS
	)
) ELSE (
	GOTO L_INVALID_NARGS
)

ECHO "CD %1"

:: Exit

GOTO L_EXIT

:: Usage

:L_INVALID_NARGS
ECHO	Usage: pyve-%AFN% [#1]
ECHO		#1 -^> The name of python virtual enviroment
ECHO	Example:
ECHO		pyve-%AFN% example
ECHO		pyve-%AFN% ; if the current directory is `example`

:: Exit

:L_EXIT