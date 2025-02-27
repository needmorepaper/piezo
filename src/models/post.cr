# The `Post` class is a representation of a post or comment.
class Post 
    # Initializes a new `Post` instance with only .
    def initialize(id : Integer)
        @id = id
        @parent = 0
        @time = Time.utc
        @ip = ""
        @name = ""
        @email = ""
        @subject = ""
        @content = ""
        @replies = [0]
        @frozen = false
    end
end