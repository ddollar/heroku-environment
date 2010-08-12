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

    $ heroku config:pull
    Config for example written to .environment
    
    $ heroku config:pull --app example2
    Config for example2 written to .environment
    
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
