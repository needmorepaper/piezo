require "kemal"
require "yaml"

VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}

config = YAML.parse(File.read("config.yml"))
board_name = config["name"].as_s
board_description = config["description"].as_s

get "/" do
  render "public/index.ecr"
end

get "/index.html" do |env|
	env.redirect "/"
end

Kemal.run
