@echo  off
echo.

if exist mov.ans          erase mov.ans
if exist grad*.in         erase grad*.in
if exist gradres.tmp      erase gradres.tmp
if exist gradtemp         erase gradtemp
if exist okay             erase okay
if exist testout          erase testout

if exist results          erase results
if exist results          goto  locked

if not exist mov.asm      goto error3
if not exist mov.exe      goto error2
if not exist gradcomp.exe goto error1
if not exist gradcpy.bat  goto error1
if not exist graddata.exe goto error1
if not exist graddoc.exe  goto error1
if not exist gradmvok.exe goto error1
if not exist gradmov.mod  goto error1
if not exist gradgtl.exe  goto error1
if not exist gradlog.exe  goto error1
if not exist gradlogt.exe goto error1
if not exist gradmmov.exe goto error1
if not exist gradres.exe  goto error1

rem // init grading count
if exist gradmov.cnt goto tmetest
call gradcpy gradmov.mod gradmov.cnt
:tmetest

rem // init history log
if exist gradmov.tme goto endtme
echo Grading and testing history log > gradmov.tme
:endtme
if %1. == s. goto run
gradgtl gradmov.tme
if errorlevel 4 goto exit

:run
rem // update count and log
gradlog gradmov.cnt gradmov.tme p17 2
if errorlevel 4 goto locked

echo MOV Grading System Version 4.0
echo MOV Grading System Version 4.0 >> results

type  gradid.p17
type  gradid.p17   >> results
type  gradmov.tme  >> results


echo    *** Checking opcodes used
echo    *** Checking opcodes used >> results

gradmmov mov.asm >> results
gradmmov mov.asm
echo.
echo. >> results

if       not errorlevel 1 goto opokay
 echo    *** Instructions other than mov or int were found
 echo.
 echo ++ Grade ++    0 = Points earned
 echo.
 echo    *** Instructions other than mov or int were found     >> results
 echo.                                                         >> results
 echo ++ Grade ++    0 = Points earned                         >> results
 echo.                                                         >> results
goto  gradesum

:opokay
echo    *** Running functional tests
echo    *** Running functional tests  >> results


:t01
graddata 01 > grad01.in
if       errorlevel 1 goto exit
 echo    Running test 01  >> results
 echo    Running test 01
gradmvok < grad01.in > okay
mov      < grad01.in > testout
gradcomp
if       not errorlevel 1 goto t01b
 echo.
 echo    Error encountered in test 01
 echo    grad01.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 01                                   >> results
 echo    grad01.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++    0 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradesum
:t01b
erase grad01.in
erase testout
erase okay


:t02
graddata 02 > grad02.in
if       errorlevel 1 goto exit
 echo    Running test 02  >> results
 echo    Running test 02
gradmvok < grad02.in > okay
mov      < grad02.in > testout
gradcomp
if       not errorlevel 1 goto t02b
 echo.
 echo    Error encountered in test 02
 echo    grad02.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 02                                   >> results
 echo    grad02.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++    0 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradesum
:t02b
erase grad02.in
erase testout
erase okay


:t03
graddata 03 > grad03.in
if       errorlevel 1 goto exit
 echo    Running test 03  >> results
 echo    Running test 03
gradmvok < grad03.in > okay
mov      < grad03.in > testout
gradcomp
if       not errorlevel 1 goto t03b
 echo.
 echo    Error encountered in test 03
 echo    grad03.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 03                                   >> results
 echo    grad03.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++    0 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradesum
:t03b
erase grad03.in
erase testout
erase okay


:t04
graddata 04 > grad04.in
if       errorlevel 1 goto exit
 echo    Running test 04  >> results
 echo    Running test 04
gradmvok < grad04.in > okay
mov      < grad04.in > testout
gradcomp
if       not errorlevel 1 goto t04b
 echo.
 echo    Error encountered in test 04
 echo    grad04.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 04                                   >> results
 echo    grad04.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++    0 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradesum
:t04b
erase grad04.in
erase testout
erase okay


:t05
graddata 05 > grad05.in
if       errorlevel 1 goto exit
 echo    Running test 05  >> results
 echo    Running test 05
gradmvok < grad05.in > okay
mov      < grad05.in > testout
gradcomp
if       not errorlevel 1 goto t05b
 echo.
 echo    Error encountered in test 05
 echo    grad05.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 05                                   >> results
 echo    grad05.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++    0 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradesum
:t05b
erase grad05.in
erase testout
erase okay


:t06
graddata 06 > grad06.in
if       errorlevel 1 goto exit
 echo    Running test 06  >> results
 echo    Running test 06
gradmvok < grad06.in > okay
mov      < grad06.in > testout
gradcomp
if       not errorlevel 1 goto t06b
 echo.
 echo    Error encountered in test 06
 echo    grad06.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 06                                   >> results
 echo    grad06.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++    0 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradesum
:t06b
erase grad06.in
erase testout
erase okay


:t07
graddata 07 > grad07.in
if       errorlevel 1 goto exit
 echo    Running test 07  >> results
 echo    Running test 07
gradmvok < grad07.in > okay
mov      < grad07.in > testout
gradcomp
if       not errorlevel 1 goto t07b
 echo.
 echo    Error encountered in test 07
 echo    grad07.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 07                                   >> results
 echo    grad07.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++    0 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradesum
:t07b
erase grad07.in
erase testout
erase okay


:t08
graddata 08 > grad08.in
if       errorlevel 1 goto exit
 echo    Running test 08  >> results
 echo    Running test 08
gradmvok < grad08.in > okay
mov      < grad08.in > testout
gradcomp
if       not errorlevel 1 goto t08b
 echo.
 echo    Error encountered in test 08
 echo    grad08.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 08                                   >> results
 echo    grad08.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++    0 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradesum
:t08b
erase grad08.in
erase testout
erase okay


:t09
graddata 09 > grad09.in
if       errorlevel 1 goto exit
 echo    Running test 09  >> results
 echo    Running test 09
gradmvok < grad09.in > okay
mov      < grad09.in > testout
gradcomp
if       not errorlevel 1 goto t09b
 echo.
 echo    Error encountered in test 09
 echo    grad09.in   is the input file
 echo    testout     is your program's output file
 echo    okay        is the expected output file
 echo.
 echo ++ Grade ++    0 = Points earned for correct answers.
 echo.
 echo.                                                                  >> results
 echo    Error encountered in test 09                                   >> results
 echo    grad09.in   is the input file                                  >> results
 echo    testout     is your program's output file                      >> results
 echo    okay        is the expected output file                        >> results
 echo.                                                                  >> results
 echo ++ Grade ++    0 = Points earned for correct answers.             >> results
 echo.                                                                  >> results
goto  gradesum
:t09b
erase grad09.in
erase testout
erase okay


echo    *** Passed all functional tests
echo    *** Passed all functional tests  >> results

rem // All tests passed. Grade efficiency.
:end
Echo ++ Grade ++   80 = Points earned for correct answers.
Echo ++ Grade ++   80 = Points earned for correct answers. >> results
echo.
echo. >> results


:gradedoc
rem Grade documentation
graddoc mov.asm >> results
graddoc mov.asm
echo.
echo. >> results

:gradesum
rem Calculate the grade
gradres
type  gradres.tmp
type  gradres.tmp >> results
erase gradres.tmp

echo Building the file mov.ans for electronic submission...
echo Building the file mov.ans for electronic submission... >> results
echo. >> results
call gradcpy.bat results+mov.asm mov.ans
goto exit

:error1
echo.
echo The grading system has detected a problem.
echo Some of the required files are missing.
echo Try to re-copy all the grading files from the course locker.
echo If this fails then contact the instructor.
echo The grading system has detected a problem.                   >> results
echo Some of the required files are missing.                      >> results
echo Try to re-copy all the grading files from the course locker. >> results
echo If this fails then contact the instructor.                   >> results
echo.
goto exit

:error2
echo.
echo The executable file 'mov.exe' does not exist in this directory.
echo.
echo The executable file 'mov.exe' does not exist in this directory. >> results
goto exit

:error3
echo.
echo The source assembler file 'mov.asm' does not exist in this directory.
echo This file is needed to continue testing.
echo.
echo The source assembler file 'mov.asm' does not exist in this directory. >> results
echo This file is needed to continue testing.                                   >> results
goto exit

:locked
echo.
echo The grading system can not access its files.
echo Shutdown the system and reboot.
echo.
goto exit

:exit
echo.
