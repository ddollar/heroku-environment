module Heroku
  module Environment
    VERSION = "0.0.1"

    def self.load
      require "yaml"
      if File.exists?(".environment")
        YAML.load_file(".environment").each do |key, value|
          ENV[key] = value
        end
      end
    end
  end
end

Heroku::Environment.load
