# Tools
Linting can be done on the CLI via OC Lint / Xcodebuild /xcpretty

## Integration

Pretty difficult to integrate in modern Xcode. xctool is outdated,documentation refers to Facebook's version of xctool as the replacement for xcodebuild (which replaced xctool), and Apple's developers themselves have issues getting a decent integration: https://www.linkedin.com/pulse/using-oclint-without-rebuilding-your-project-kyle-sherman/ 

## CLI commands

     xcodebuild clean build CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO  | xcpretty -r json-compilation-database -o compile_commands.json

     oclint-json-compilation-database 
