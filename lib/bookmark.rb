require "pg"

class Bookmark
  def self.view
    if ENV["ENVIRONMENT"] == "test"
      connection = PG.connect(dbname: "bookmark_manager_test")
    else
      connection = PG.connect(dbname: "bookmark_manager")
    end

    result = connection.exec("SELECT * FROM bookmarks")
    result.map { |bookmark| bookmark["url"] }
  end

  def self.create(new_bookmark:)
    if ENV["ENVIRONMENT"] == "test"
      connection = PG.connect(dbname: "bookmark_manager_test")
    else
      connection = PG.connect(dbname: "bookmark_manager")
    end 
    
    connection.exec("INSERT INTO bookmarks (url) VALUES('#{new_bookmark}')")
  end
end
