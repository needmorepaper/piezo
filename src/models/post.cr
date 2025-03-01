# The `Post` class is a representation of a post or comment.
class Post 
    # The `id` property is the post's unique ID.
    getter id : Int64
    # The `parent` property is a reply's parent thread.
    property parent : Int64?
    # The `time` property is the time that the post was created at.
    property time : Time
    # The `ip` property is the post's originating IP.
    # FIXME: If behind a reverse proxy, IPs can be useless for moderation purposes. Implement CSRF checks.
    property ip : String
    # The `name` property represents the post's username.
    property name : String?
    # The `email` property represents the post's linked email.
    property email : String?
    # The `subject` property represents the post's subject.
    property subject : String?
    # The `content` property represents the post's content.
    property content : String
    # The `replies` property represents the number of replies that a post contains.
    property replies : Int64
    # The `frozen` property represents whether a post has been locked for further replies.
    property frozen : Bool

    # Initializes a new `Post` instance.
    def initialize(id)
        @id = id
        @time = Time.utc
        @ip = ""
        @content = ""
        @replies = 0
        @frozen = false
    end
end