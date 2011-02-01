require "yaml"

class Heroku::Command::Config < Heroku::Command::BaseWithApp

  def pull
    interactive = extract_option("--interactive")
    overwrite   = extract_option("--overwrite")

    config = merge_config(remote_config, local_config, interactive, overwrite)
    write_local_config config
    display "Config for #{app} written to .environment"
  end

  def push
    interactive = extract_option("--interactive")
    overwrite   = extract_option("--overwrite")

    config = merge_config(local_config, remote_config, interactive, overwrite)
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

  def merge_config(source, target, interactive=false, overwrite=false)
    if interactive
      source.keys.sort.inject(target) do |hash, key|
        value = source[key]
        display "%s: %s" % [key, value]
        hash[key] = value if confirm("Overwite? (y/N)")
        hash
      end
    else
      overwrite ? target.merge(source) : source.merge(target)
    end
  end

end
