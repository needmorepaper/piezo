require "kemal"

require "./config.cr"
require "./db.cr"

VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}

config = Config.new

db = Database.new(config.getDbPath)
board_name = config.getBoardName
board_description = config.getBoardDescription

get "/" do
  render "public/index.ecr"
end

get "/index.html" do |env|
	env.redirect "/"
end

get "/admin" do |env|
  env.redirect "/"
end

Kemal.run
