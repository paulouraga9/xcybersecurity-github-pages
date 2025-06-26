#!/bin/bash

echo "========================================"
echo "Xcybersecurity Website Deployment Script"
echo "========================================"
echo
echo "This script will help you deploy your website to GitHub Pages"
echo "with your custom domain www.x4cybersecurity.com"
echo

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo "ERROR: Git is not installed"
    echo "Please install Git first:"
    echo "- macOS: Install Xcode Command Line Tools or use Homebrew"
    echo "- Linux: sudo apt install git (Ubuntu/Debian) or sudo yum install git (CentOS/RHEL)"
    exit 1
fi

echo "Git is installed ✓"
echo

# Get user input
read -p "Enter your GitHub username: " GITHUB_USERNAME
read -p "Enter repository name (or press Enter for 'xcybersecurity-website'): " REPO_NAME

if [ -z "$REPO_NAME" ]; then
    REPO_NAME="xcybersecurity-website"
fi

echo
echo "Configuration:"
echo "- GitHub Username: $GITHUB_USERNAME"
echo "- Repository Name: $REPO_NAME"
echo "- Custom Domain: www.x4cybersecurity.com"
echo

read -p "Is this correct? (y/n): " CONFIRM
if [[ ! $CONFIRM =~ ^[Yy]$ ]]; then
    echo "Deployment cancelled."
    exit 0
fi

echo
echo "========================================"
echo "Step 1: Setting up local repository"
echo "========================================"

# Initialize git repository
if ! git init; then
    echo "ERROR: Failed to initialize Git repository"
    exit 1
fi

echo "Git repository initialized ✓"

# Configure git user (if not already configured)
git config user.name "Paul Ouraga" 2>/dev/null
git config user.email "info@x4cybersecurity.com" 2>/dev/null

echo "Git user configured ✓"

# Add all files
if ! git add .; then
    echo "ERROR: Failed to add files to Git"
    exit 1
fi

echo "Files added to Git ✓"

# Create initial commit
if ! git commit -m "Initial commit: Xcybersecurity website deployment"; then
    echo "ERROR: Failed to create initial commit"
    exit 1
fi

echo "Initial commit created ✓"

# Rename branch to main
git branch -M main
echo "Branch renamed to main ✓"

echo
echo "========================================"
echo "Step 2: Connecting to GitHub"
echo "========================================"
echo
echo "IMPORTANT: You need to create a repository on GitHub first!"
echo
echo "1. Go to https://github.com/new"
echo "2. Repository name: $REPO_NAME"
echo "3. Make it PUBLIC"
echo "4. DO NOT initialize with README"
echo "5. Click 'Create repository'"
echo

read -p "Have you created the repository on GitHub? (y/n): " READY
if [[ ! $READY =~ ^[Yy]$ ]]; then
    echo "Please create the repository first, then run this script again."
    exit 0
fi

# Add remote origin
if ! git remote add origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"; then
    echo "ERROR: Failed to add remote origin"
    echo "Please check your username and repository name"
    exit 1
fi

echo "Remote origin added ✓"

echo
echo "========================================"
echo "Step 3: Pushing to GitHub"
echo "========================================"
echo
echo "You will be prompted for your GitHub credentials..."
echo

# Push to GitHub
if ! git push -u origin main; then
    echo "ERROR: Failed to push to GitHub"
    echo "This might be due to:"
    echo "- Incorrect username/password"
    echo "- Repository doesn't exist"
    echo "- Repository is not public"
    echo
    echo "Please check and try again."
    exit 1
fi

echo "Code pushed to GitHub successfully ✓"

echo
echo "========================================"
echo "Step 4: Enable GitHub Pages"
echo "========================================"
echo
echo "Now you need to enable GitHub Pages:"
echo
echo "1. Go to: https://github.com/$GITHUB_USERNAME/$REPO_NAME/settings/pages"
echo "2. Under 'Source', select 'Deploy from a branch'"
echo "3. Choose 'main' branch and '/ (root)' folder"
echo "4. Click 'Save'"
echo "5. Under 'Custom domain', enter: www.x4cybersecurity.com"
echo "6. Click 'Save' again"
echo "7. Check 'Enforce HTTPS' (after DNS is configured)"
echo

read -p "Have you enabled GitHub Pages? (y/n): " PAGES_DONE

echo
echo "========================================"
echo "Step 5: Configure DNS"
echo "========================================"
echo
echo "Configure these DNS records with your domain registrar:"
echo
echo "CNAME Record:"
echo "  Name: www"
echo "  Value: $GITHUB_USERNAME.github.io"
echo "  TTL: 3600"
echo
echo "A Records (for apex domain):"
echo "  Name: @ (or blank)"
echo "  Values: 185.199.108.153"
echo "         185.199.109.153"
echo "         185.199.110.153"
echo "         185.199.111.153"
echo "  TTL: 3600"
echo

echo "========================================"
echo "DEPLOYMENT COMPLETE! 🎉"
echo "========================================"
echo
echo "Your website will be available at:"
echo "- GitHub Pages URL: https://$GITHUB_USERNAME.github.io/$REPO_NAME"
echo "- Custom Domain: https://www.x4cybersecurity.com (after DNS propagates)"
echo
echo "DNS propagation can take 24-48 hours."
echo
echo "To update your website in the future:"
echo "1. Make changes to your files"
echo "2. Run: git add ."
echo "3. Run: git commit -m \"Update website\""
echo "4. Run: git push origin main"
echo
echo "Your professional cybersecurity website is now live!"
echo

