require "sqlite3"

# The `Database` class contains various operations for interacting with the SQLite database.
class Database
  # Creates a new `Database` instance.
  def initialize(path : String)
    @path = path
    DB.open @path do |db|
      table_status = db.query_one?("select name from sqlite_master where type='table' and name=?", "posts", &.read(String))
      if table_status
        Log.debug { "Valid database already exists" }
      else
        Log.warn { "Database tables missing, rebuilding" }  
        createSchema(@path)
      end
    end
  end

  # Creates the database schema when called.
  private def createSchema(@path : String)
    DB.open @path do |db|
      db.exec "create table if not exists posts (
        id integer not null primary key autoincrement,
        parent integer,
        time datetime default current_timestamp,
        ip text,
        name text,
        email text,
        subject text,
        content text,
        replies integer default 0,
        frozen integer default 0)"
      Log.info { "Built posts table" }
      db.exec "create table if not exists bans (
        ip text not null,
        why text)"
      Log.info { "Built bans table" }
    end
  end

  # Sends a query to the database.
  def queryDb(query : String)
    DB.open @path do |db|
      db.query(query)
    end
  end

  # Sends a query to the database that returns all matching rows.
  def queryAllDb(query : String, args : NamedTuple)
    DB.open @path do |db|
      db.query_all query, as: args
    end
  end

  # Execute a query on the database.
  def execOnDb(query : String, args : Array)
    DB.open @path do |db|
      db.exec query, args: args
    end
  end
end
