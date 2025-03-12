#!/bin/bash

# Colors and text formatting
bold=$(tput bold)
normal=$(tput sgr0)
green=$(tput setaf 2)
red=$(tput setaf 1)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)

# Function to fetch the latest tag from git based on the environment
get_latest_tag() {
    local env="$1"
    git fetch --tags > /dev/null 2>&1
    git tag --list "${env}/*" | sort -V | tail -n 1
}

# Function to increment the build number
increment_build() {
    local build="$1"
    echo $((build + 1))
}

# Function to extract the version and build number
extract_version_and_build() {
    local tag="$1"
    version=$(echo "$tag" | awk -F'/' '{print $2}' | awk -F'.' -v OFS='.' '{print $1,$2,$3}')
    build=$(echo "$tag" | awk -F'.' '{print $NF}')
}

# Function to push the new tag
push_tag() {
    local new_tag="$1"
    git tag "$new_tag"
    git push origin "$new_tag"
}

# Header
printf "\n${bold}${blue}--- Deploy Script ---${normal}\n"

# Prompt for the environment
printf "\n${bold}Select environment:${normal}\n"
printf "1: development\n"
printf "2: staging\n"
printf "3: production\n"
printf "4: appstore\n\n\n"
read -p "Enter the number: " env_choice

# Map user input to environment name
case $env_choice in
    1) env="development" ;;
    2) env="staging" ;;
    3) env="production" ;;
    4) env="appstore" ;;
    *) printf "${red}Invalid selection!${normal}\n"; exit 1 ;;
esac

# Fetch the latest tags from the selected environment or fallback to staging/development
latest_tag=$(get_latest_tag "$env")
if [ -z "$latest_tag" ]; then
    # Fallback to staging or development if production has no tags
    printf "\n${yellow}No tags found for $env. Checking other environments...${normal}\n"
    latest_tag=$(get_latest_tag "staging")
    [ -z "$latest_tag" ] && latest_tag=$(get_latest_tag "development")

    # Start from version 1.0.0.0 if no tags at all
    if [ -z "$latest_tag" ]; then
        printf "\n${yellow}No tags found in any environment. Starting from version 1.0.0.1${normal}\n"
        latest_tag="1.0.0.1"
    else
        printf "\n${green}Latest tag found in another environment: ${bold}$latest_tag${normal}\n"
    fi
else
    printf "\n${green}Latest tag in $env: ${bold}$latest_tag${normal}\n"
fi

# Extract the version and current build
extract_version_and_build "$latest_tag"
current_version=$version
current_build=$build

# Ask for a new version or use the old one
printf "\n"
read -p "Enter new version (leave blank to keep ${bold}$current_version${normal}): " new_version
[ -z "$new_version" ] && new_version="$current_version"

# Ask for a new build number or increment automatically
printf "\n"
read -p "Enter new build number (leave blank to increment ${bold}$current_build${normal} by 1): " new_build
[ -z "$new_build" ] && new_build=$(increment_build "$current_build")

# Preview the new tag
new_tag="$env/$new_version.$new_build"
printf "\n${bold}${blue}New tag to be created: ${green}$new_tag${normal}\n"

# Confirm and push
printf "\n"
read -p "${bold}Press Enter to confirm and push the tag, or Ctrl+C to cancel.${normal}"
push_tag "$new_tag"

# Success message
printf "\n${bold}${green}Tag $new_tag pushed successfully!${normal}\n"
