# This module provides various classes for building the content of page templates.
module PageGenerator
  # Initializes the PageGenerator module, including an instance of the `Database` constant.
  # FIXME: Currently unable to create and use a module-wide variable, currently substituting with a direct constant call.
  def initialize
    @db = Piezo::DATABASE
  end

  # This class manages all thread-related actions.
  class ThreadGenerator
    # Get all threads from the posts table.
    def self.getAllThreads
      posts = Piezo::DATABASE.queryAllDb("select id, subject, content, time from posts where parent is null order by time desc", {id: Number, subject: String?, content: String?, time: String?})

      posts.each { |post| }

      formatted_posts = posts.compact_map do |post|
        next if post[:content].nil?

        time = post[:time] || "Unknown Date"
        content = HTML.escape(post[:content].not_nil!)

        if content.size > 100
          abridged_content = HTML.escape(content[0, 100]) + "..."
        else
          abridged_content = HTML.escape(content)
        end

        {id: post[:id], subject: post[:subject], content: abridged_content, time: time}
      end

      formatted_posts
    end

    # Get the data of the thread/root post.
    def self.getThread(id : Int)
      # Fetch the thread data from the database.
      post_data = Piezo::DATABASE.queryOneDb(
        "select parent, time, ip, name, email, subject, content, replies, frozen
        from posts
        where id = ?",
        id,
        fields: {
          parent:  Int64?,
          time:    Time,
          ip:      String,
          name:    String?,
          email:   String?,
          subject: String?,
          content: String,
          replies: Int64,
          frozen:  Int64,
        }
      ) rescue nil

      # Create a new Post instance and populate it with the retrieved data.
      thread_data = Post.new(id)
      if post_data == nil
        raise Exception.new("Thread data is not valid")
      end
      
      # FIXME: "Vibe coded" nonsense that should be cleaned up if not ideal.
      # I only did this because I was completely stumped with null checking
      thread_data.parent = post_data.try(&.[](:parent))
      thread_data.time = post_data.try(&.[](:time)).not_nil!
      thread_data.ip = post_data.try(&.[](:ip)).not_nil!
      thread_data.name = post_data.try(&.[](:name))
      thread_data.email = post_data.try(&.[](:email))
      thread_data.subject = post_data.try(&.[](:subject))
      thread_data.content = post_data.try(&.[](:content)).not_nil!
      thread_data.replies = post_data.try(&.[](:replies)).not_nil!
      thread_data.frozen = post_data.try(&.[](:frozen)) != 0

      return thread_data
    end
  end
end
