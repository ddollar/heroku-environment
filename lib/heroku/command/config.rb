require "yaml"

class Heroku::Command::Config < Heroku::Command::BaseWithApp

  def pull
    File.open(".environment", "w") do |file|
      file.puts YAML.dump(heroku.config_vars(app))
    end
    display "Config for #{app} written to .environment"
  end

  def push
    error "No .environment file" unless File.exists?(".environment")
    config = YAML.load_file(".environment")
    heroku.clear_config_vars(app)
    heroku.add_config_vars(app, config)
    display "Config in .environment written to #{app}"
  end

end
