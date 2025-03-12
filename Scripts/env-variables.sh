#!/bin/sh

# Skip running this script on CI
if [ "$SKIP_CUSTOM_SCRIPTS" = "true" ]; then
  echo "Skipping custom script on CI when running tests."
  exit 0
fi

# Derive SRCROOT if it is empty
if [ -z "$SRCROOT" ]; then
  if [ -n "$WORKSPACE_PATH" ]; then
    SRCROOT=$(dirname "$WORKSPACE_PATH")
    SRCROOT=$(dirname "$SRCROOT")
    echo "Derived SRCROOT from WORKSPACE_PATH: $SRCROOT"
  else
    echo "Error: SRCROOT and WORKSPACE_PATH are both undefined."
    exit 1
  fi
fi

# Resolve appName
appName="${TARGET_NAME}"
if [ -z "$appName" ]; then
  if [ -n "$SCHEME_NAME" ]; then
    appName="${SCHEME_NAME%% *}"  # Use the first word of SCHEME_NAME
    echo "Derived appName from SCHEME_NAME: $appName"
  elif [ -n "$WORKSPACE_PATH" ]; then
    appName=$(basename "$WORKSPACE_PATH" | sed 's/\.xcworkspace$//; s/\.xcodeproj$//')
    echo "Derived appName from WORKSPACE_PATH: $appName"
  else
    echo "Error: Could not determine appName."
    exit 1
  fi
fi

# Add extra nesting for the project structure
nestedAppDir="${SRCROOT}/${appName}"

# Debugging Output
echo "Resolved SRCROOT: $SRCROOT"
echo "Resolved appName: $appName"
echo "Nested App Directory: $nestedAppDir"

# Get the current configuration and trim any whitespace
currentConfigRaw="${SCHEME_NAME}"
currentConfig=$(echo "$currentConfigRaw" | xargs) # Trim spaces

# Check for keywords in the configuration
if echo "$currentConfig" | grep -qi "appstore"; then
  resolvedEnv="prod"
elif echo "$currentConfig" | grep -qi "dev"; then
  resolvedEnv="dev"
elif echo "$currentConfig" | grep -qi "prod"; then
  resolvedEnv="prod"
elif echo "$currentConfig" | grep -qi "qa"; then
  resolvedEnv="dev"
elif echo "$currentConfig" | grep -qi "sta"; then
  resolvedEnv="staging"
else
  echo "Error: Could not determine environment from configuration name $currentConfig. Ensure it contains one of 'dev', 'prod', or 'sta'."
  exit 1
fi

echo "Original CONFIGURATION: $currentConfigRaw"
echo "Trimmed CONFIGURATION: $currentConfig"
echo "Resolved Environment: $resolvedEnv"

# Paths
configFilePath="${nestedAppDir}/Resources/Configs/${resolvedEnv}.xcconfig"
outputSwiftFilePath="${SRCROOT}/Packages/Utils/Sources/Configuration.swift"

# Debug: Log paths to verify
echo "Using the following paths:"
echo "Config File: $configFilePath"
echo "Output Swift File: $outputSwiftFilePath"

# Prefix for XCConfig keys
prefix="XCCONFIG_"

# Ensure the .xcconfig file exists
if [ ! -f "$configFilePath" ]; then
  echo "Error: $configFilePath does not exist. Please ensure it is created before running this script."
  exit 1
fi

# Step 1: Parse .xcconfig and generate Configuration.swift
echo "Generating Configuration.swift from ${configFilePath}..."

# Header for the Swift file
cat > "$outputSwiftFilePath" <<EOL
// swiftlint:disable all
// This file was auto-generated via a script inside scheme build pre-actions.

import PovioKitCore

public enum Configuration {
EOL

# Read keys and values from .xcconfig
while IFS='=' read -r key value; do
  # Skip comments and invalid lines
  if [[ "$key" =~ ^//.*$ || -z "$key" || -z "$value" ]]; then
    continue
  fi

  # Clean the key and value
  cleanKey=$(echo "$key" | xargs)
  cleanValue=$(echo "$value" | xargs | sed 's/\$()[^\/]*//g') # remove $() placeholders

  # Convert key to camelCase for Swift variable
  swiftVarName=$(echo "$cleanKey" | awk -F'_' '{
    for (i=1; i<=NF; i++) {
      if (i == 1) printf tolower($i)
      else printf toupper(substr($i,1,1)) tolower(substr($i,2))
    }
    printf "\n"
  }')

  # Inject into Swift file
  echo "  public static let $swiftVarName = \"$cleanValue\"" >> "$outputSwiftFilePath"
done < "$configFilePath"

# Close the Swift file
echo "}" >> "$outputSwiftFilePath"
echo "// swiftlint:enable all" >> "$outputSwiftFilePath"
echo "Configuration.swift generated successfully."

# Debugging Output
echo "Generated Swift configuration file at: $outputSwiftFilePath"
