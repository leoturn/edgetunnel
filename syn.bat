@echo off
chcp 65001
title Git Sync with Upstream

rem 设置工作目录为 C:\minigtp
cd /d C:\minigtp

rem 显示当前工作目录
echo 当前工作目录是：%cd%
echo.

rem 配置git全局用户名和邮箱（避免冲突）
echo 配置Git全局用户名和邮箱...
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
echo 配置完毕。
echo.

rem 确认是否已有上游仓库
git remote -v
echo.

rem 检查是否已经添加上游仓库，如果没有则添加
echo 检查是否已有上游仓库...
git remote | findstr upstream > nul
if %errorlevel% neq 0 (
    echo 没有找到上游仓库，正在添加...
    git remote add upstream https://github.com/cmliu/edgetunnel.git
    echo 上游仓库已添加。
) else (
    echo 已找到上游仓库。
)
echo.

rem 获取上游仓库的最新更改
echo 正在获取上游仓库的最新更改...
git fetch upstream
echo 获取完毕。
echo.

rem 切换到主分支
echo 切换到主分支...
git checkout main
echo 切换完成。
echo.

rem 合并上游的主分支到本地主分支
echo 正在将上游的主分支合并到本地主分支...
git merge upstream/main --allow-unrelated-histories
echo 合并完成。
echo.

rem 如果发生冲突，手动解决冲突，暂停5秒
git status
echo 如果存在冲突，请手动解决。按任意键继续...
pause

rem 提交解决后的冲突
git add .
git commit -m "解决冲突并同步上游仓库"
echo 提交完成。
echo.

rem 强制推送到GitHub
echo 强制推送到GitHub...
git push origin main --force
echo 强制推送完成。
echo.

rem 检查其他分支
echo 检查其他分支...
git branch
echo.

rem 提示用户可以手动切换和同步其他分支
echo 如果你有其他分支，手动切换到分支并运行 git merge upstream/<branch> 来同步更新。
echo 请检查是否需要同步其他分支。
pause
