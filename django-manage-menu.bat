@echo off
ECHO OFF

CLS
ECHO %CD%
ECHO ##########################
ECHO #   DJANGO MANAGE MENU   #
ECHO #      FOR WINDOWS       #
ECHO #      VERSION 1.1       #
ECHO ##########################
ECHO.
ECHO LOOKING FOR manage.py...
IF EXIST "%~dp0manage.py" (
    ECHO SETTING manage.py AS "%~dp0manage.py"
    SET MANAGEPATH=%~dp0
    SET MANAGEPY=%MANAGEPATH%manage.py
) ELSE (
    ECHO manage.py NOT IN THE PATH "%~dp0"
)
IF "%~1"=="" (
    ECHO FIRST PARAMETER WAS NOT PASSED FOR "%~f0"
) ELSE (
    SET MANAGEPATH=%~f1
    SET MANAGEPY=%MANAGEPATH%\manage.py
    ECHO SETTING manage.py AS "%MANAGEPY%"
)
IF NOT EXIST "%MANAGEPY%" GOTO NO1

ECHO USING "%MANAGEPY%"
 
IF EXIST "%MANAGEPATH%\manage-menu.cfg" (
    ECHO LOADING VARIABLES...
    FOR /F %%e IN (%MANAGEPATH%\manage-menu.cfg) DO (
        ECHO SETTING %%e
        CALL SET %%e
    )
) ELSE (
    ECHO VARIABLES FILE "%MANAGEPATH%\manage-menu.cfg" NOT FOUND!
)

PAUSE

REM SHOWING MENU

:MENU
CLS
ECHO ##########################
ECHO #   DJANGO MANAGE MENU   #
ECHO #      FOR WINDOWS       #
ECHO #      VERSION 1.1       #
ECHO ##########################
ECHO #                        #
ECHO ######### ADMIN ##########
ECHO # 1. SHELL               #
ECHO # 2. CREATE SUPER USER   #
ECHO #                        #
ECHO ######## DATABASE ########
ECHO # 3. MAKE MIGRATIONS     #
ECHO # 4. MIGRATE             #
ECHO #                        #
ECHO #### WEB SERVER ##########
ECHO # 5. COLLECT STATIC      #
ECHO # 6. RUNSERVER           #
ECHO #                        #
ECHO ##########################
ECHO #      OTHERS TOOLS      #
ECHO ##########################
ECHO # 7. UNISON              #
ECHO # 8. DOCUMENTATION       #
ECHO #                        #
ECHO ##########################
ECHO # 9. EXIT                #
ECHO ##########################
choice /C 123456789 /M "SELECT AN OPTION:"

IF %ERRORLEVEL% EQU 1 GOTO OPT1
IF %ERRORLEVEL% EQU 2 GOTO OPT2
IF %ERRORLEVEL% EQU 3 GOTO OPT3
IF %ERRORLEVEL% EQU 4 GOTO OPT4
IF %ERRORLEVEL% EQU 5 GOTO OPT5
IF %ERRORLEVEL% EQU 6 GOTO OPT6
IF %ERRORLEVEL% EQU 7 GOTO OPT7
IF %ERRORLEVEL% EQU 8 GOTO OPT8
IF %ERRORLEVEL% EQU 9 GOTO OPT9

:OPT1
START %PYTHONPATH%\python.exe "%MANAGEPY%" shell
PAUSE
GOTO MENU

:OPT2
%PYTHONPATH%\python.exe "%MANAGEPY%" createsuperuser
PAUSE
GOTO MENU

:OPT3
%PYTHONPATH%\python.exe "%MANAGEPY%" makemigrations
PAUSE
GOTO MENU

:OPT4
%PYTHONPATH%\python.exe "%MANAGEPY%" migrate
REM %PYTHONPATH%\python.exe "%MANAGEPY%" migrate --fake app 0001
PAUSE
GOTO MENU

:OPT5
%PYTHONPATH%\python.exe "%MANAGEPY%" collectstatic --noinput
PAUSE
GOTO MENU

:OPT6
START %PYTHONPATH%\python.exe "%MANAGEPY%" runserver
PAUSE
GOTO MENU

:OPT7
"%UNISONPATH%"%UNISONEXE% "%UNISONLOCAL%" "%UNISONSERVER%" -auto
PAUSE
GOTO MENU

:OPT8

REM SHOWING DOCUMENTATION MENU

:MENUDOC
CLS
ECHO ##########################
ECHO #   DJANGO MANAGE MENU   #
ECHO #      FOR WINDOWS       #
ECHO #      VERSION 1.1       #
ECHO ##########################
ECHO #   DOCUMENTATION MENU   #
ECHO ##########################
ECHO # 1. SPHINX DOC          #
ECHO # 2. ReST VIEW           #
ECHO # 3. PyLit               #
ECHO #                        #
ECHO ##########################
ECHO # 4. EXIT                #
ECHO ##########################
choice /C 1234 /M "SELECT AN OPTION:"

IF %ERRORLEVEL% EQU 1 GOTO DOC1
IF %ERRORLEVEL% EQU 2 GOTO DOC2
IF %ERRORLEVEL% EQU 3 GOTO DOC3
IF %ERRORLEVEL% EQU 4 GOTO DOC4

:DOC1
%PYTHONPATH%\Scripts\sphinx-apidoc.exe -o .\"%DOCPATH"\src .
CALL .\"%DOCPATH"\make.bat html
PAUSE
GOTO MENUDOC

:DOC2
SET /P FILE=Which RST file would like to show?
START %PYTHONPATH%\Scripts\restview.exe "%FILE%"
PAUSE
GOTO MENUDOC

:DOC3
SET /P FILE=Which RST file would like to convert?
%PYTHONPATH%\python.exe %PYLITPATH%\pylit.py "%FILE%" "%FILE:~0,-4%.py"
PAUSE
GOTO MENUDOC

:DOC4
GOTO MENU

:NO1
ECHO manage.py NOT FOUND !
PAUSE
GOTO OPT9

:OPT9
EXIT
