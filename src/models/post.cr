# The `Post` class is a representation of a post or comment.
class Post 
    # Initializes a new `Post` instance with only the post ID.
    # TODO: Replace this stub template with a proper constructor (parse from DB?)
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