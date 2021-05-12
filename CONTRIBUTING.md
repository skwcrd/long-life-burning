# Contributing

_See also: [Flutter's code of conduct](https://flutter.dev/design-principles/#code-of-conduct)_

Want to contribute to the Flutter sample ecosystem? Great! First, read this page (including the small print at the end). Contributions of all kinds are greatly appreciated. To help smoothen the process we have a few non-exhaustive guidelines to follow which should get you going in no time.

## Is this the right place for your contribution?

This repo is used by members of the Flutter team and a few partners as a place to store example apps and demos. It's not meant to be the one and only source of truth for Flutter samples or the only place people go to learn about the best ways to build with Flutter. What that means in practice is that if you've written a great example app, it doesn't need to be maintained here in order to get noticed, be of help to new Flutter devs, and have an impact on the community.

You can maintain your sample app in your own repo (or with another source control provider) and still be as important a part of the Flutter-verse as anything you see here. You can let us know on the [FlutterDev Google Group](https://groups.google.com/forum/#!forum/flutter-dev) when you've published something and Tweet about it with the [#flutterio](https://twitter.com/search?q=%23flutterio) hashtag.

## So what should be contributed here, then?

Fixes and necessary improvements to the existing samples, mostly.

## Before you contribute

Before we can use your code, you must sign the [Google Individual Contributor License Agreement](https://cla.developers.google.com/about/google-individual) (CLA), which you can do online. The CLA is necessary mainly because you own the copyright to your changes, even after your contribution becomes part of our codebase, so we need your permission to use and distribute your code. We also need to be sure of various other things—for instance that you'll tell us if you know that your code infringes on other people's patents. You don't have to sign the CLA until after you've submitted your code for review and a member has approved it, but you must do it before we can put your code into our codebase.

Before you start working on a larger contribution, you should get in touch with us first through the issue tracker with your idea so that we can help out and possibly guide you. Coordinating up front makes it much easier to avoid frustration later on.

## What you will need

 * A Linux, Mac OS X, or Windows machine (note: to run and compile iOS specific parts you'll need access to a Mac OS X machine)
 * git (used for source version control, installation instruction can be found [here](https://git-scm.com/))
 * The Flutter SDK (installation instructions can be found [here](https://flutter.dev/get-started/install/))
 * A personal GitHub account (you can sign-in [here](https://github.com/))

## Setting up your development environment

 * [Fork](https://github.com/skwcrd/long_life_burning/forks/new) `https://github.com/skwcrd/long_life_burning` into your own GitHub account. If you already have a fork and moving to a new computer, make sure you update you fork.
 * If you haven't configured your machine with an SSH key that's known to github, then follow [GitHub's directions](https://github.com/help/ssh/README) to generate an SSH key.
 * Clone your forked repo on your local development machine: `git clone git@github.com:<your_name_here>/long_life_burning.git`
 * Change into the `flutter_nfc` directory: `cd flutter_nfc`
 * Add an upstream to the original repo, so that fetch from the master repository and not your clone: `git remote add upstream git@github.com:skwcrd/long_life_burning.git`

## Code reviews

All submissions, including submissions by project members, require review.

## Submitting a Merge Requests

 * Write appropriate title.
 * Wrtie a proper description including the issue name and solution.

## Using GitHub Issues

 * Feel free to use GitHub issues for questions, bug reports, and feature requests.
 * Use the search feature to check for an existing issue.
 * Include as much information as possible and provide any relevant resources (eg. screenshots).
 * For bug reports ensure you have a reproducible test case.
    * A merge request with a breaking test would be super preferable here but isn't required.

## Create a new issue

The easiest way to get involved is to create a [new issue](https://github.com/skwcrd/long_life_burning/issues/new) when you spot a bug, if the documentation is incomplete or out of date, or if you identify an implementation problem.

## Running the example project

 * Change into the example directory: `cd example`
 * Run the App: `flutter run`

## Contribute

We really appreciate contributions via GitHub pull requests. To contribute take the following steps:

 * Make sure you are up to date with the latest code on the master:
    * `git fetch upstream`
    * `git checkout upstream/dev -b <name_of_your_branch>`
 * Apply your changes.
 * Verify your changes and fix potential warnings/ errors:
    * Check formatting: `flutter format .`
    * Run static analyses: `flutter analyze`
    * Run unit-tests: `flutter test`
 * Commit your changes: `git commit -am "<your informative commit message>"`
 * Push changes to your fork: `git push -u upstream <name_of_your_branch>`

Please make sure you solved all warnings and errors reported by the static code analyses and that you fill in the full pull request template. Failing to do so will result in us asking you to fix it.
## The small print

Contributions made by corporations are covered by a different agreement than the one above, the [Software Grant and Corporate Contributor License Agreement](https://developers.google.com/open-source/cla/corporate).