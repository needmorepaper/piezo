require "kemal"

require "./lib/config.cr"
require "./lib/db.cr"
require "./routes/routes.cr"

module Piezo
  CONFIG  = Config.new
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}

  db = Database.new(CONFIG.getDbPath)

  Kemal.run
end
