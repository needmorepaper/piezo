# The `Ban` class is a representation of a ban.
class Ban
    # The `IP` property represents a banned user's IP.
    property ip : String
    # The `why` property represents a ban reason.
    property why : String?

    # Creates a new `Ban` instance with no ban reason.
    def initialize(ip : String)
        @ip = ip
        @why = nil
    end

    # Creates a new `Ban` instance with a ban reason.
    def initialize(ip : String, why : String)
        @ip = ip
        @why = why
    end

    # Write a ban to the database.
    # WARNING: Incomplete method.
    def createBan()
        db = new Database()
        db.execOnDb("")
    end
    
    # Remove a ban from the database.
    # WARNING: Incomplete method.
    def removeBan()
        db = Piezo::DATABASE
        # TODO: Check if user is banned
        banStatus = ""
        db.execOnDb()
    end
end