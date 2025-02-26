require "sqlite3"

# The `Database` class contains various operations for interacting with the SQLite database.
class Database
  # Creates a new `Database` instance.
  def initialize(@path : String)
    DB.open @path do |db|
      table_status = db.query_one?("SELECT name FROM sqlite_master WHERE type='table' AND name=?", "posts", &.read(String))
      if table_status
        puts "Database already exists"
      else
        puts "Database tables missing, rebuilding"  
        createSchema(@path)
      end
    end
  end

  # Creates the database schema when called.
  def createSchema(@path : String)
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
      puts "Built posts table"
      db.exec "create table if not exists bans (
        ip text not null,
        why text)"
      puts "Built bans table"
    end
  end
end
