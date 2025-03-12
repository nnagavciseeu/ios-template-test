swift run \
    --package-path Packages/OpenAPI \
    swift-openapi-generator generate \
    --config template/Resources/OpenAPI/openapi-generator-config.yaml \
    --output-directory Packages/OpenAPI/Sources/OpenAPI \
    template/Resources/OpenAPI/openapi.yaml