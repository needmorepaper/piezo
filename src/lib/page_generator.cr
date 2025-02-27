# This module provides various classes for building the content of page templates.
module PageGenerator
  # Initializes the PageGenerator module, generating an instance to the `Database` class.
  def initialize
    @db = Piezo::DATABASE
  end

  # This class generates a thread list from the database.
  class ThreadListGenerator
    # Get all threads from the posts table
    # FIXME: Unable to use module variable, substituting with a direct constant call
    def self.getAllThreads
      posts = Piezo::DATABASE.queryAllDb("select subject, content, time from posts where parent is null order by time desc", {subject: String?, content: String?, time: String?})
      
      posts.each { |post| }

      formatted_posts = posts.compact_map do |post|
        next if post[:content].nil?

        time = post[:time] || "Unknown Date"
        content = HTML.escape(post[:content].not_nil!)

        if content.size > 100
          abridged_content = HTML.escape(content[0,100]) + "..."
        else
          abridged_content = HTML.escape(content)
        end

        { subject: post[:subject], content: abridged_content, time: time }
      end

      formatted_posts
    end
  end
end