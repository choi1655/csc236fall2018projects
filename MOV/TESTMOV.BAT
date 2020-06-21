@echo  off
echo.

rem // verify the input and output file exist
if not exist gradlogt.exe  goto error1
if not exist gradmark.exe  goto error1
if not exist mov.exe       goto error2

:tmetest
if exist gradmov.tme goto endtme
echo Grading and testing history log > gradmov.tme
:endtme

rem // test for marking run or user test or nt test
if %1. == mark. goto mark
if %1. == .     goto user
goto errcmd

:mark
gradmark gradmov.tme
goto exit

:user
rem // update the time
gradlogt gradmov.tme keyboard test
if errorlevel 4 goto locked

rem // run the test
echo.Input  xyz  (x=A-Z or 0-9   y=0-9   z=+ or other)
echo.Output xyzx (if z==+) x=x+y
echo.Enter data...
echo.xyzx
mov
echo.
goto exit

:error1
echo.
echo The grading system has detected a problem.
echo Some of the required files are missing.
echo Try to re-copy all the grading files from the course locker.
echo If this fails then contact the instructor.
echo.
goto exit

:error2
echo.
echo The executable file 'mov.exe' does not exist in this directory
echo.
goto exit

:errcmd
echo.
echo Command        Type of test
echo ------------   ----------------------------
echo tesmov         Run a test from the movboard
echo testmov mark   Mark the program as working
echo.
goto exit

:locked
echo.
echo I can not access the required files.
echo - Close this DOS window and open it again.
echo - If that does not work then logout and login again
echo If the problem persists contact the instructor.
echo.
goto exit

:exit
echo.
