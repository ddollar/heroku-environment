require "yaml"

class Heroku::Command::Config < Heroku::Command::BaseWithApp

  def pull
    overwrite = extract_option("--overwrite")
    config = merge_config(remote_config, local_config, overwrite)
    write_local_config config
    display "Config for #{app} written to .environment"
  end

  def push
    overwrite = extract_option("--overwrite")
    config = merge_config(local_config, remote_config, overwrite)
    write_remote_config config
    display "Config in .environment written to #{app}"
  end

private ######################################################################

  def local_config
    YAML.load_file(".environment") rescue {}
  end

  def remote_config
    heroku.config_vars(app)
  end

  def write_local_config(config)
    File.open(".environment", "w") do |file|
      file.puts "---"
      file.puts YAML.dump(config).split("\n")[1..-1].sort.join("\n")
    end
  end

  def write_remote_config(config)
    heroku.clear_config_vars(app)
    heroku.add_config_vars(app, config)
  end

  def merge_config(source, target, overwrite=false)
    overwrite ? target.merge(source) : source.merge(target)
  end

end
