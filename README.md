# template

template.

## App architecture

The app is written purely in Swift 5. We are using a modified MVVM architecture as a design pattern where each screen is treated as scene. We are using the `PovioMVVM` template to create a new scenes.

### Environments
We have different environments for different purposes:
- Dev (Only for Developers)
- Sta (Staging env where the client is testing out the app)
- QA (A copy of "Sta" env but intended for internal QA team, by default uses Sta environment)
- Prod (Production only env, deployed to Firebase)
- AppStore (Appstore Deployment only! Uses Prod environment)

### Project structure

The Xcode project is divided into 4 main folders:

- `Common` (All common code that is not related to certain views, scenes, workers, etc)
- `Resources` (Image assets, localizations, plists, configs, etc)
- `Scenes` (All app Scenes where each scene is a screen)
- `Packages` (All local package references are in this folder)

### Localization
All localization strings are defined in the [Google Spreadsheet](https://docs.google.com/spreadsheets/).

### Secrets
Secrets are and should be stored in `.xcconfig` files. Based on the environment they are stored either in
- `Dev.xcconfig`
- `Sta.xcconfig`

#### :warning: Important

> Production secrets **are and should not commited or stored locally**, but should be set as a **Git Secret** under the `PROD_XCCONFIG` key. After each fastlane deployment, the secret gets decoded and a `Prod.xcconfig` file gets created and used accordingly.

## Building the project

This project uses [Swift Package Manager](https://swift.org/package-manager/) (SPM) for dependency management.

## Deployment

We support continuous deployment (CD) to Firebase and Testflight - by default Firebase is used for Dev, Sta and Prod. To deploy to Testflight or Appstore, use the Appstore deployment lane. In order to prepare a build, you can simply run the following script:

```bash
sh Scripts/deploy.sh
```

This will run a Deploy Wizard, where you can chose the following deployment lanes:

- Development: Deploys Dev environment to Firebase and notifies Internal Tester Group only
- QA: Deploys Dev or Sta environment (based on your configuration) to Firebase and notifies Internal Tester Group only
- Staging: Deploys Sta environment to Firebase and notifies Internal and External Tester Groups
- Production: Deploys Prod environment to Firebase and notifies Internal and External Tester Groups
- AppStore: Deploys Prod environment to AppStore (Testflight), where you can either put it into Testflight or push to App Review.

What the script basically does, is it creates a tag to your current commit and pushes it to the origin. Eg. for the staging deployment it creates a tag: `staging/1.0.0.35` and so on.

## Branching

`main` branch is only used for released code. On the other hand, `develop` branch should be used for all development activities. Both `main` and `develop` branches are protected. You can only push to them via pull request. We use [git flow](http://nvie.com/posts/a-successful-git-branching-model/).

| Name | Purpose |
|---------|---------|
| `main` | Should always reflect what's released to the AppStore. |
| `develop` | Development branch. |
| `epic/*` | A development branch containing two or more feature branches, from develop. Merges into develop. |
| `feature/*` | Feature development branches from develop. Merges into develop. |
| `release/*` | Release branches from develop. Merges into master. |
| `hotfix/*` | Hotfix branches from master. Merge into master. |

### Naming convention

We should apply the following pattern when creating branches, for the sake of consistency:

#### Available branch types

- `feature` - developing new features/functionalities
- `epic` - a bigger feature task that consists of more sub-feature tasks
- `chore` - small task that is neither feature nor fix
- `fix` - fixing code bugs
- `release` - branch is opened when preparing release for App Store
- `hotfix` - when we want to patch a bug in production

#### Examples

- feature/login-flow
- epic/paywall
- fix/navigation-crash
- hotfix/users-unable-to-login
- chore/update-localization
- release/2.9.3
