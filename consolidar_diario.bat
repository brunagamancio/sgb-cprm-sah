@echo off
echo Iniciando consolidação diária...
cd /d "%~dp0"

for /f "tokens=1-3 delims=/" %%a in ('powershell -command "Get-Date -Format 'dd/MM/yyyy'"') do (
    set dia=%%a
    set mes=%%b
    set ano=%%c
)
set data_commit=%dia%/%mes%/%ano%
set data_branch=%ano%%mes%%dia%

echo Data: %data_commit%
echo Branch: atualizacoes-%data_branch%
echo.

.\git-bash.exe -c "
cd '%cd%' && 
git checkout main && 
git merge --squash atualizacoes-%data_branch% && 
git commit -m 'Consolidação diária: %data_commit%' && 
git push meu-repo main && 
git branch -D atualizacoes-%data_branch%
"

echo Consolidação concluída!
pause