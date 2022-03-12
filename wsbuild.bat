<Reference: https://www.wireshark.org/docs/wsdg_html_chunked/ChSetupWindows.html>
rem mkdir D:\GITHUB\wireshark_dev\wsbuild64
D:
cd D:\GITHUB\wireshark_dev\wsbuild64
set WIRESHARK_BASE_DIR=D:\GITHUB\wireshark_dev\wireshark
set CMAKE_PREFIX_PATH=D:\DevTools\Qt\5.15.2\msvc2019_64
set WIRESHARK_VERSION_EXTRA=-YourExtraVersionInfo
cmake -G "Visual Studio 17 2022" -A x64 ..\wireshark <Tam> This steps took me a while, I need to run the script on elevated mode, then change the WIRESHARK_BASE_DIR (append wireshark to the end of the path), or else it does not work, reference here: https://stdworkflow.com/600/wireshark-cmake-compilation-error-fatal-error-windows-setup-win-setup-ps1-failed
<Tam> Even so there is error still there, but after all I can build successfully
rem Then build the exe using the command line:
msbuild /m /p:Configuration=RelWithDebInfo Wireshark.sln


How to build using VS Studio?
<Tam> The debug version have this Pre-build script:
setlocal
cd D:\GITHUB\wireshark_dev\wsbuild64
if %errorlevel% neq 0 goto :cmEnd
D:
if %errorlevel% neq 0 goto :cmEnd
"C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe" -E cmake_autogen D:/GITHUB/wireshark_dev/wsbuild64/CMakeFiles/wireshark_autogen.dir/AutogenInfo.json Debug
if %errorlevel% neq 0 goto :cmEnd
:cmEnd
endlocal & call :cmErrorLevel %errorlevel% & goto :cmDone
:cmErrorLevel
exit /b %1
:cmDone
if %errorlevel% neq 0 goto :VCEnd

<Tam> For debug version I needed to add the Post build script as below (how can I know that? I looked at the log of Visual Studio Command line - which built successfully):
setlocal
set PATH=D:/DevTools/Qt/5.15.2/msvc2019_64/bin;%PATH%
if %errorlevel% neq 0 goto :cmEnd
D:\DevTools\Qt\5.15.2\msvc2019_64\bin\windeployqt.exe --no-compiler-runtime --verbose 0 --pdb D:/GITHUB/wireshark_dev/wsbuild64/run/RelWithDebInfo/Wireshark.exe
if %errorlevel% neq 0 goto :cmEnd
:cmEnd
endlocal & call :cmErrorLevel %errorlevel% & goto :cmDone
:cmErrorLevel
exit /b %1
:cmDone
if %errorlevel% neq 0 goto :VCEnd
:VCEnd



