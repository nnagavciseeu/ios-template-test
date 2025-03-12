# Define paths
GOOGLE_SERVICE_INFO_PLIST_FROM="${PROJECT_DIR}/${PRODUCT_NAME}/Resources/Google/${FIREBASE_CONFIG_FILE}.plist"
BUILD_APP_DIR="${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}"
GOOGLE_SERVICE_INFO_PLIST_TO="${BUILD_APP_DIR}/GoogleService-Info.plist"

# Check if the source plist file exists
if [ ! -f "${GOOGLE_SERVICE_INFO_PLIST_FROM}" ]; then
  echo "error: ${GOOGLE_SERVICE_INFO_PLIST_FROM} not found"
  exit 1
fi

# Copy the plist file to the build directory
cp "${GOOGLE_SERVICE_INFO_PLIST_FROM}" "${GOOGLE_SERVICE_INFO_PLIST_TO}"

# Check if the copy operation was successful
if [ $? -ne 0 ]; then
  echo "error: Failed to copy ${GOOGLE_SERVICE_INFO_PLIST_FROM} to ${GOOGLE_SERVICE_INFO_PLIST_TO}"
  exit 1
fi

echo "Successfully copied ${GOOGLE_SERVICE_INFO_PLIST_FROM} to ${GOOGLE_SERVICE_INFO_PLIST_TO}"