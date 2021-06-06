# **Fastlane documentation**

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

``` shell
xcode-select --install
```

Install _fastlane_ using

``` shell
[sudo] gem install fastlane -NV
```

or alternatively using `brew install fastlane`

# Available Actions
## Android
### android test

``` shell
fastlane android test
```

Runs all the tests

### android beta

``` shell
fastlane android beta
```

Submit a new beta build to Google Play

### android promote_to_production

``` shell
fastlane android promote_to_production
```

Promote beta track to prod

### android production

``` shell
fastlane android production
```

Submit a new production build to Google Play

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
