# The `Ban` class is a representation of a ban.
class Ban
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

    # Ban an user from accessing the board.
    def createBan()
        db = new Database()
        db.execOnDb("")
    end
    
    # Unban a previously banned user 
    def removeBan()
        db = Piezo::DATABASE
        # TODO: Check if user is banned
        banStatus = ""
        db.execOnDb()
    end
end