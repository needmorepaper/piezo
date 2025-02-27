require "kemal"

require "../models/post.cr"

board_name = Piezo::CONFIG.getBoardName
board_description = Piezo::CONFIG.getBoardDescription
version = Piezo::VERSION
response = ""
response_detail = ""

get "/" do
  threads_list = PageGenerator::ThreadListGenerator.getAllThreads

  render "src/views/index.ecr"
end

get "/index.html" do |env|
  env.redirect "/"
end

get "/admin" do |env|
  env.redirect "/"
end

get "/thread/create" do |env|
  env.redirect "/"
end

post "/thread/create" do |env|
  ip = env.request.remote_address.to_s
  name = env.params.body["name"].to_s.strip
  email = env.params.body["email"].to_s.strip
  subject = env.params.body["subject"].to_s.strip
  message = env.params.body["message"].to_s.strip

  response = ""
  response_detail = ""

  # Validation logic
  if name.empty?
    name = "Anonymous"
  end
  if email.empty?
    email = nil
  end
  if subject.empty?
    subject = nil
  end
  if message.empty?
    response = "Failure"
    response_detail = "message cannot be empty"
    halt env, 400, env.redirect "/"
    next
  else
    message = env.params.body["message"].as(String).strip
  end

  # Push to database
  Piezo::DATABASE.execOnDb "insert into posts (
    ip,name,email,subject,content) values (
    ?,?,?,?,?)", [ip, name, email, subject, message] of DB::Any
  response = "Success"
  response_detail = "thread successfully created!"
  env.redirect "/"
end
