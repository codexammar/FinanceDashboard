#!/bin/bash

# Exit if any command fails
set -e

# Define paths
DIST_DIR="dist"
DEPLOY_TEMP="../temp-deploy"

echo "🔄 Switching to main branch..."
git checkout main

echo "🧹 Cleaning previous build output..."
rm -rf $DIST_DIR $DEPLOY_TEMP
mkdir -p $DEPLOY_TEMP

echo "🛠 Publishing Blazor WASM app (no compression)..."
dotnet publish -c Release -o $DIST_DIR --p:BlazorEnableCompression=false

echo "📁 Copying wwwroot contents to temp deploy folder..."
cp -r $DIST_DIR/wwwroot/* $DEPLOY_TEMP

echo "🔀 Switching to gh-pages branch..."
git checkout gh-pages

echo "🧽 Clearing old files from gh-pages..."
rm -rf *

echo "📦 Copying new files into gh-pages..."
cp -r $DEPLOY_TEMP/* .

echo "📎 Making sure .nojekyll exists..."
touch .nojekyll

echo "🔒 Force adding necessary folders..."
git add -f _framework/
git add .nojekyll
git add .

echo "✅ Committing and pushing to GitHub Pages..."
git commit -m "Auto-deploy Blazor app with no compression"
git push origin gh-pages

echo "🔄 Switching back to main branch..."
git checkout main

echo "🎉 Deploy complete! Visit: https://codexammar.github.io/FinanceDashboard/"
