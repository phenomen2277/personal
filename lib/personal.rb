require "personal/version"
require 'etc'
require 'sqlite3'


module Personal

  class AppConf

  	def create_db_if_does_not_exist
		user_home = Etc.getpwuid.dir
		personal_dir = "#{user_home}/.personal/"
		database_file = db_path()

		return false if Dir.exist?(personal_dir) && File.file?(database_file)

		Dir.mkdir personal_dir unless Dir.exist?(personal_dir)
		db = db_handle(database_file)
		db.execute("CREATE TABLE personal (id integer NOT NULL PRIMARY KEY AUTOINCREMENT, created_at datetime, data TEXT);")
		db.close
  	end

  	def db_path
		user_home = Etc.getpwuid.dir
		personal_dir = "#{user_home}/.personal/"
		personal_dir + "personal.data"
  	end


  	def db_handle(database_path)
  		SQLite3::Database.new(database_path)
  	end 

  end

    class DbPersistence
      attr_reader :db

      def initialize(db_handle)
        @db = db_handle
      end

      def close_db
        @db.close unless @db.closed?
      end

      def create_entry(data)
        @db.execute("insert into personal(created_at, data) values(CURRENT_TIMESTAMP, ?)", data)
      end

      def latest_entry
        @db.execute('select * from personal order by created_at DESC limit 1')
      end

      def delete_entry(id)
        @db.execute("delete from personal where id = ?", id)
      end

      def latest_entries(limit = 10)
        @db.execute("select * from (select * from personal order by created_at desc limit ?) order by created_at ASC", limit)
      end

      def entries_by_year_and_month(year, month, limit = 31)
        @db.execute("select * from (select * from personal where cast(strftime('%Y', created_at) as integer) = ? and cast(strftime('%m', created_at) as integer) = ? order by created_at DESC limit ?) order by created_at ASC", year, month, limit)
      end
      
      def entries_by_year_month_day(year, month, day)
        @db.execute("select * from (select * from personal where cast(strftime('%Y', created_at) as integer) = ? and cast(strftime('%m', created_at) as integer) = ? and cast(strftime('%d', created_at) as integer) = ? order by created_at DESC) order by created_at ASC", year, month, day)
      end
      
    end

end
