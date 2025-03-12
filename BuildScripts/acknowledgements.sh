if [ "${ENABLE_PREVIEWS}" = "YES" ]; then
  echo "Skipping script for Previews..."
  exit 0;
fi

if test -d "/opt/homebrew/bin/"; then
  PATH="/opt/homebrew/bin/:${PATH}"
fi

export PATH

if [ -z "$CI" ]; then
  if command -v swift-package-list &> /dev/null; then
    OUTPUT_PATH=$SOURCE_ROOT/$TARGETNAME/Resources/Acknowledgements
    swift-package-list "$PROJECT_FILE_PATH" --output-type settings-bundle --output-path "$OUTPUT_PATH" --requires-license
  else
    echo "warning: swift-package-list not installed"
  fi
fi
