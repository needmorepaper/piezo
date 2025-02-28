require "kemal"
require "log"

require "./lib/*"
require "./models/*"
require "./routes/*"

# The `Piezo` module initializes the application.
module Piezo
  # An instance of the `Config` class, to be used by other classes.
  CONFIG = Config.new
  # An instance of the `Database` class, to be used by other classes.
  DATABASE = Database.new(CONFIG.getDbPath)
  # The version number of the software as defined by the shards manifest.
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}

  Kemal.run
end
