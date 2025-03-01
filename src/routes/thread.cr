require "kemal"

require "../models/post.cr"

board_name = Piezo::CONFIG.getBoardName
board_description = Piezo::CONFIG.getBoardDescription
version = Piezo::VERSION
response = ""
response_detail = ""

get "/thread" do |env|
  env.redirect "/"
end

get "/thread/:id" do |env|
  # thread_data = PageGenerator::ThreadGenerator.getThread(:id.to_i)
  render "src/views/thread.ecr", "src/views/base.ecr"
end

get "/thread/create" do |env|
  env.redirect "/"
end

post "/thread/create" do |env|
  ip = env.request.remote_address.to_s
  name = HTML.escape(env.params.body["name"].to_s.strip)
  email = HTML.escape(env.params.body["email"].to_s.strip)
  subject = HTML.escape(env.params.body["subject"].to_s.strip)
  message = HTML.escape(env.params.body["message"].to_s.strip)

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
  # TODO: Add maximum thread limit based on max_threads
  Piezo::DATABASE.execOnDb "insert into posts (
      ip,name,email,subject,content) values (
      ?,?,?,?,?)", [ip, name, email, subject, message] of DB::Any
  response = "Success"
  response_detail = "thread successfully created!"
  env.redirect "/"
end
