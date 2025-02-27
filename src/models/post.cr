# The `Post` class is a representation of a post or comment.
class Post 
    # Initializes a new `Post` instance with only .
    def initialize(id : Integer)
        @id = id
        @parent = Integer?
        @time = Time.utc
        @ip = String
        @name = String?
        @email = String?
        @subject = String?
        @content = String
        @replies = Integer
        @frozen = Boolean
    end
end