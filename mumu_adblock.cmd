@echo off
title MuMu 模拟器开屏广告一键拦截与恢复工具
chcp 65001 >nul

:: 检查管理员权限
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [提示] 正在申请管理员权限...
    powershell "Start-Process cmd -ArgumentList '/c %~s0' -Verb RunAs"
    exit /b
)

:MENU
cls
echo ========================================================
echo        MuMu 模拟器开屏广告一键拦截与恢复工具
echo ========================================================
echo.

set "targetDir=%APPDATA%\Netease\MuMuPlayer\data"
set "targetFile=%targetDir%\startupImage"

:: 检查当前状态
if exist "%targetFile%" (
    if exist "%targetFile%\*" (
        echo [当前状态] 未拦截 (广告缓存目录正常存在)
    ) else (
        echo [当前状态] ★ 已开启拦截 (广告占位文件生效中)
    )
) else (
    echo [当前状态] 未初始化 (尚未生成广告缓存)
)

echo.
echo  [1] 开启开屏广告拦截 (清除缓存并生成占位保护)
echo  [2] 恢复开屏广告 (还原默认缓存目录)
echo  [3] 退出工具
echo.
echo ========================================================
set /p choice=请输入选项 [1-3] 并按回车: 

if "%choice%"=="1" goto BLOCK
if "%choice%"=="2" goto RESTORE
if "%choice%"=="3" goto EXIT

echo [错误] 无效选项，请重新输入！
pause
goto MENU

:BLOCK
echo.
echo [*] 正在为 MuMu 模拟器配置广告拦截...

if not exist "%targetDir%" mkdir "%targetDir%"

:: 如果是目录则清空删除
if exist "%targetFile%\*" (
    rd /s /q "%targetFile%"
) else (
    if exist "%targetFile%" del /f /q "%targetFile%"
)

:: 创建 0 字节只读占位文件
cd. > "%targetFile%"
attrib +r "%targetFile%" >nul 2>&1

echo [成功] 开屏广告拦截已成功开启！
echo [提示] 启动模拟器时将不再下载和展示开屏启动图。
echo.
pause
goto MENU

:RESTORE
echo.
echo [*] 正在恢复 MuMu 模拟器默认广告配置...

if exist "%targetFile%" (
    attrib -r "%targetFile%" >nul 2>&1
    if exist "%targetFile%\*" (
        rd /s /q "%targetFile%"
    ) else (
        del /f /q "%targetFile%"
    )
)

:: 重建默认目录
if not exist "%targetDir%" mkdir "%targetDir%"
mkdir "%targetFile%"

echo [成功] 已恢复为默认状态！
echo.
pause
goto MENU

:EXIT
exit