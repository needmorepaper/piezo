require "kemal"

board_name = Piezo::CONFIG.getBoardName
board_description = Piezo::CONFIG.getBoardDescription
version = Piezo::VERSION

get "/" do
  render "src/views/index.ecr"
end

get "/index.html" do |env|
  env.redirect "/"
end

get "/admin" do |env|
  env.redirect "/"
end

post "/thread/create" do |env|
end
