@echo  off
echo.

if not exist gradcpy.bat   goto error1
if not exist gradcpya.bat  goto error1
if not exist gradlogt.exe  goto error1
if not exist gradmark.exe  goto error1
if not exist rlcdrvr.exe   goto error2

rem // verify the user typed the correct command
rem // if this is a marking run then do not test files
if %1. == mark.  goto tmetest
if %1. == .      goto errcmd

rem // verify the input and output file exist
if %1 == 1 goto tmetest
if %1 == 2 goto tmetest
if %1 == 3 goto tmetest
goto errcmd
if %1 == 4 goto tmetest
if %1 == 5 goto tmetest
if %1 == 6 goto tmetest
if %1 == 7 goto tmetest
if %1 == 8 goto tmetest
if %1 == 9 goto tmetest
goto errcmd

:tmetest
if exist gradrlc.tme goto endtme
echo Grading and testing history log > gradrlc.tme
:endtme

rem // test for marking run or user test
if not %1. == mark. goto usertest
gradmark gradrlc.tme
goto exit

:usertest
rem // update the time
gradlogt gradrlc.tme %1 Display
if errorlevel 4 goto locked

rem // run the test
rlcdrvr %1
goto exit

:errcmd
echo.
echo To run a test type:
echo    testrlc n     ... where n is 1, 2 or 3
echo.
echo To mark the program as working type:
echo    testrlc.bat  mark
echo.
goto   exit

:errin
echo.
echo The input valid testcases are 1, 2, 3
echo.
goto   exit

:error1
echo.
echo The grading system has detected a problem.
echo Some of the required files are missing.
echo Try to re-copy all the grading files from the course locker.
echo If this fails then contact the instructor.
echo.
goto   exit

:error2
echo.
echo The executable file 'rlcdrvr.exe' does not exist in this directory.
echo.
goto   exit

:locked
echo.
echo I can not access the required files.
echo Shutdown and reboot the system.
echo.
goto exit

:exit
echo.
