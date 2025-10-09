#!/bin/bash

USAGE="\033[0;37m[INFO] - usage: USERNAME=my-github-username PLUGIN_NAME=my-awesome-plugin REPOSITORY_NAME=my-awesome-plugin.nvim make setup\n\033[0m"
echo -e "$USAGE"

if [[ -z "$USERNAME" ]]; then
    read -rp '> No USERNAME provided. Enter your GitHub/GitLab username: ' USERNAME
fi

if [[ -z "$REPOSITORY_NAME" ]]; then
    REPOSITORY_NAME=$(basename -s .git $(git config --get remote.origin.url))

    read -rp $'> No REPOSITORY_NAME provided. Is \033[1;32m'"$REPOSITORY_NAME"$'\033[0m good? [Y/n]: ' yn
    case "$yn" in
        [Yy]* ) : ;;
        [Nn]* ) read -rp '> Enter your repository name: ' REPOSITORY_NAME ;;
        * )
            echo -e "$USAGE" 2>&1
            exit 1
            ;;
    esac
fi

if [[ -z "$PLUGIN_NAME" ]]; then
    DEFAULT_REPOSITORY_NAME="$(echo "$REPOSITORY_NAME" | sed -e "s/\.nvim//")"
    read -rp $'> No PLUGIN_NAME provided, defaulting to \033[1;32m'"$DEFAULT_REPOSITORY_NAME"$'\033[0m, continue? [Y/n]: ' yn
    case "$yn" in
        [Yy]* ) PLUGIN_NAME="$DEFAULT_REPOSITORY_NAME" ;;
        [Nn]* ) read -rp '> Enter your plugin name: ' PLUGIN_NAME ;;
        * )
            echo -e "$USAGE" 2>&1
            exit 1
            ;;
    esac
fi

echo -e "Username:\t\033[1;32m$USERNAME\033[0m\nRepository:  \033[1;32m$REPOSITORY_NAME\033[0m\nPlugin:      \033[1;32m$PLUGIN_NAME\033[0m\n\n\tRenaming placeholder files..."

rm -rf doc CHANGELOG.md
mv plugin/your-plugin-name.lua plugin/"$PLUGIN_NAME".lua
mv lua/your-plugin-name lua/"$PLUGIN_NAME"
mv README{_TEMPLATE,}.md

echo -e "\tReplacing placeholder names..."

PASCAL_CASE_PLUGIN_NAME=$(echo "$PLUGIN_NAME" | perl -pe 's/(^|-)./uc($&)/ge;s/-//g')

grep -rl "YourPluginName" .github/ plugin/ tests/ lua/ | xargs sed -i "" -e "s/YourPluginName/$PASCAL_CASE_PLUGIN_NAME/g"
grep -rl "your-plugin-name" README.md .github/ plugin/ tests/ lua/ | xargs sed -i "" -e "s/your-plugin-name/$PLUGIN_NAME/g"
grep -rl "YOUR_GITHUB_USERNAME" README.md .github/ | xargs sed -i "" -e "s/YOUR_GITHUB_USERNAME/$USERNAME/g"
grep -rl "YOUR_REPOSITORY_NAME" README.md .github/ | xargs sed -i "" -e "s/YOUR_REPOSITORY_NAME/$REPOSITORY_NAME/g"
echo -e "\n\033[1;32mOK.\033[0m"

echo -e "\tFetching dependencies (tests and documentation generator)..."
make deps
echo -e "\n\033[1;32mOK.\033[0m"

echo -e "\tGenerating docs..."
make documentation
echo -e "\n\033[1;32mOK.\033[0m"

echo -e "\tRunning tests..."
make test
echo -e "\n\033[1;32mOK.\033[0m"
