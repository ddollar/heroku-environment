require "yaml"

class Heroku::Command::Config < Heroku::Command::BaseWithApp

  def pull
    existing_config = YAML.load_file(".environment") rescue {}
    existing_keys = existing_config.keys

    File.open(".environment", "w") do |file|
      config = heroku.config_vars(app)
      existing_keys.each { |k| config.delete(k) } if extract_option("--new")
      output = YAML.dump(existing_config.merge(config))
      file.puts "---"
      file.puts output.split("\n")[1..-1].sort.join("\n")
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
