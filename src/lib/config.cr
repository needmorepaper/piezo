require "yaml"

# The Config class reads the config from a given YAML file and creates appropriate getters for the expected fields.
class Config
    # Creates a new `Config` instance.
    def initialize()
        if File.exists?("config.yml")
            @config = YAML.parse(File.read("config.yml"))
            Log.info { "Config file loaded" }
        else
            Log.fatal { "Missing configuration file, please clone 'config.default.yml' to config.yml" }
            exit
        end
    end

    # Reloads the YAML config.
    def reload()
        initialize()
    end

    # Gets the database path from the config.
    def getDbPath()
        @config["db_path"].as_s
    end

    # Gets the secret key from the config.
    def getSecretKey()
        @config["secret_key"].as_s
    end

    # Gets the sysop name from the config.
    protected def getSysopName()
        @config["sysop_name"].as_s
    end

    # Gets the sysop password from the config. 
    protected def getSysopPass()
        @config["sysop_pass"].as_s
    end

    # Gets the board name from the config.
    def getBoardName()
        @config["name"].as_s
    end

    # Gets the board description from the config.
    def getBoardDescription()
        @config["description"].as_s
    end

    # Get the maximum amount of threads from the config.
    def getMaxThreads()
        @config["max_threads"].as_i
    end

    # Gets the maximum amount of replies from the config.
    def getMaxReplies()
        @config["max_replies"].as_i
    end

    # Gets the maximum amount of threads per page from the config.
    def getThreadsPerPage()
        @config["threads_per_page"].as_i
    end
end