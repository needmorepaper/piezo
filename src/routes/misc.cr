require "kemal"

require "../models/post.cr"

board_name = Piezo::CONFIG.getBoardName
board_description = Piezo::CONFIG.getBoardDescription
version = Piezo::VERSION
response = ""
response_detail = ""

get "/" do
  # TODO: Paginate to threads_per_page
  threads_list = PageGenerator::ThreadGenerator.getAllThreads

  render "src/views/index.ecr", "src/views/base.ecr"
end

get "/index.html" do |env|
  env.redirect "/"
end