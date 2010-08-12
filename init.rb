require 'heroku/command/config'

Heroku::Command::Help.group("Configuration Sync") do |group|
  group.command "config:pull", "pull remote config from the app"
  group.command "config:push", "push local config to the app"
end
