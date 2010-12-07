@ECHO OFF

set framework_version=3.5
set msb=%windir%\Microsoft.NET\Framework\v%framework_version%\MSBuild.exe
set project=SubSonic.Linq.msbuild
set outdir=Release
set basename=.
set releasedir=Release

if not exist %msb% goto msbuild_not_found
goto do_build

:do_build
echo Building the project ...
if not exist %outdir% mkdir %outdir%
%msb% /target:Merge /property:Platform="Any CPU" /property:Configuration=Release /property:OutDir=bin\Release\ /property:outputdir=%releasedir% "%project%"
if errorlevel 1 goto build_error
goto build_ok

:build_ok
goto end

:msbuild_not_found
echo MSBuild not found (exptected version of .NET Framework: %framework_version%)
if not "%1" == "batch" pause
exit 1

:build_error
echo Error while building the project.
if not "%1" == "batch" pause
exit 2

:end
if not "%1" == "batch" pause
exit 0
