# Heroku::Environment

Provides a way for you to push/pull your Heroku environment to use locally.

## Installation

Add the heroku gem plugin:

    $ heroku plugins:install git://github.com/ddollar/heroku-environment.git
    heroku-environment installed

Add the gem to your app:

    # Gemfile
    gem "heroku-environment"

Add the following to `.gitignore`:

    .environment

## Usage

    # by default, existing keys will not be overwritten
    $ heroku config:pull
    Config for example written to .environment

    # optional --overwrite allows you to have the push overwrite keys
    $ heroku config:pull --overwrite
    Config in .environment written to example

    # --interactive will cause --overwrite to prompt for each value to be overwritten
    $ heroku config:pull --overwrite --interactive
    BUNDLE_DISABLE_SHARED_GEMS: 1
    Overwite? (y/N)

    $ heroku config:push
    Config in .environment written to example

## How it works

Your environment will be stored locally in a file named `.environment`. This
file will be read and placed into your app's environment on load. Please
make sure not to commit this file to your repository.

## License

MIT License

## Author

David Dollar <ddollar@gmail.com>
