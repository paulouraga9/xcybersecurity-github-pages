@echo off
echo ========================================
echo Xcybersecurity Website Deployment Script
echo ========================================
echo.
echo This script will help you deploy your website to GitHub Pages
echo with your custom domain www.x4cybersecurity.com
echo.

REM Check if Git is installed
git --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Git is not installed or not in PATH
    echo Please install Git from: https://git-scm.com/download/win
    echo Then run this script again.
    pause
    exit /b 1
)

echo Git is installed ✓
echo.

REM Get user input
set /p GITHUB_USERNAME="Enter your GitHub username: "
set /p REPO_NAME="Enter repository name (or press Enter for 'xcybersecurity-website'): "

if "%REPO_NAME%"=="" set REPO_NAME=xcybersecurity-website

echo.
echo Configuration:
echo - GitHub Username: %GITHUB_USERNAME%
echo - Repository Name: %REPO_NAME%
echo - Custom Domain: www.x4cybersecurity.com
echo.

set /p CONFIRM="Is this correct? (y/n): "
if /i not "%CONFIRM%"=="y" (
    echo Deployment cancelled.
    pause
    exit /b 0
)

echo.
echo ========================================
echo Step 1: Setting up local repository
echo ========================================

REM Initialize git repository
git init
if errorlevel 1 (
    echo ERROR: Failed to initialize Git repository
    pause
    exit /b 1
)

echo Git repository initialized ✓

REM Configure git user (if not already configured)
git config user.name "Paul Ouraga" 2>nul
git config user.email "info@x4cybersecurity.com" 2>nul

echo Git user configured ✓

REM Add all files
git add .
if errorlevel 1 (
    echo ERROR: Failed to add files to Git
    pause
    exit /b 1
)

echo Files added to Git ✓

REM Create initial commit
git commit -m "Initial commit: Xcybersecurity website deployment"
if errorlevel 1 (
    echo ERROR: Failed to create initial commit
    pause
    exit /b 1
)

echo Initial commit created ✓

REM Rename branch to main
git branch -M main
echo Branch renamed to main ✓

echo.
echo ========================================
echo Step 2: Connecting to GitHub
echo ========================================
echo.
echo IMPORTANT: You need to create a repository on GitHub first!
echo.
echo 1. Go to https://github.com/new
echo 2. Repository name: %REPO_NAME%
echo 3. Make it PUBLIC
echo 4. DO NOT initialize with README
echo 5. Click 'Create repository'
echo.

set /p READY="Have you created the repository on GitHub? (y/n): "
if /i not "%READY%"=="y" (
    echo Please create the repository first, then run this script again.
    pause
    exit /b 0
)

REM Add remote origin
git remote add origin https://github.com/%GITHUB_USERNAME%/%REPO_NAME%.git
if errorlevel 1 (
    echo ERROR: Failed to add remote origin
    echo Please check your username and repository name
    pause
    exit /b 1
)

echo Remote origin added ✓

echo.
echo ========================================
echo Step 3: Pushing to GitHub
echo ========================================
echo.
echo You will be prompted for your GitHub credentials...
echo.

REM Push to GitHub
git push -u origin main
if errorlevel 1 (
    echo ERROR: Failed to push to GitHub
    echo This might be due to:
    echo - Incorrect username/password
    echo - Repository doesn't exist
    echo - Repository is not public
    echo.
    echo Please check and try again.
    pause
    exit /b 1
)

echo Code pushed to GitHub successfully ✓

echo.
echo ========================================
echo Step 4: Enable GitHub Pages
echo ========================================
echo.
echo Now you need to enable GitHub Pages:
echo.
echo 1. Go to: https://github.com/%GITHUB_USERNAME%/%REPO_NAME%/settings/pages
echo 2. Under 'Source', select 'Deploy from a branch'
echo 3. Choose 'main' branch and '/ (root)' folder
echo 4. Click 'Save'
echo 5. Under 'Custom domain', enter: www.x4cybersecurity.com
echo 6. Click 'Save' again
echo 7. Check 'Enforce HTTPS' (after DNS is configured)
echo.

set /p PAGES_DONE="Have you enabled GitHub Pages? (y/n): "

echo.
echo ========================================
echo Step 5: Configure DNS
echo ========================================
echo.
echo Configure these DNS records with your domain registrar:
echo.
echo CNAME Record:
echo   Name: www
echo   Value: %GITHUB_USERNAME%.github.io
echo   TTL: 3600
echo.
echo A Records (for apex domain):
echo   Name: @ (or blank)
echo   Values: 185.199.108.153
echo          185.199.109.153  
echo          185.199.110.153
echo          185.199.111.153
echo   TTL: 3600
echo.

echo ========================================
echo DEPLOYMENT COMPLETE! 🎉
echo ========================================
echo.
echo Your website will be available at:
echo - GitHub Pages URL: https://%GITHUB_USERNAME%.github.io/%REPO_NAME%
echo - Custom Domain: https://www.x4cybersecurity.com (after DNS propagates)
echo.
echo DNS propagation can take 24-48 hours.
echo.
echo To update your website in the future:
echo 1. Make changes to your files
echo 2. Run: git add .
echo 3. Run: git commit -m "Update website"
echo 4. Run: git push origin main
echo.
echo Your professional cybersecurity website is now live!
echo.

pause

