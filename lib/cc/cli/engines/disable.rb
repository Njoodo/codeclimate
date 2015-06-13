require "cc/analyzer"

module CC
  module CLI
    module Engines
      class Disable < EngineCommand
        def run
          if !filesystem.exist?(CODECLIMATE_YAML)
            say "No .codeclimate.yml file found. Run 'codeclimate init' to generate a config file."
          elsif !engine_exists?
            say "Engine not found. Run 'codeclimate engines:list for a list of valid engines."
          elsif !engine_present_in_yaml?
            say "Engine not found in .codeclimate.yml."
          elsif !engine_enabled?
            say "Engine already disabled."
          else
            disable_engine
            update_yaml
            say "Engine disabled."
          end
        end

        private

        def disable_engine
          parsed_yaml.disable_engine(engine_name)
        end
      end
    end
  end
end
