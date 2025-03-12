if [ "${ENABLE_PREVIEWS}" = "YES" ]; then
  echo "Skipping script for Previews..."
  exit 0;
fi

if test -d "/opt/homebrew/bin/"; then
  PATH="/opt/homebrew/bin/:${PATH}"
fi

export PATH

if [ -z "$CI" ]; then
  if which swiftlint >/dev/null; then
    swiftlint
  else
    echo "error: SwiftLint not installed. Install it using `brew install swiftlint` command or download it from https://github.com/realm/SwiftLint"
    exit 1
  fi
fi