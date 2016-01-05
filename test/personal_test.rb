require 'test_helper'

class PersonalTest < Minitest::Test

	def setup
		@app_conf = Personal::AppConf.new
		@db_persistence = Personal::DbPersistence.new(@app_conf.db_handle(@app_conf.db_path))
	end

	def test_db_file_is_created
		@app_conf.create_db_if_does_not_exist()
		assert File.exist?(@app_conf.db_path)
	end

	def test_insert_entry
		data = "Testing"
		@db_persistence.create_entry(data)
		latest_entry = @db_persistence.latest_entry()[0]
		assert latest_entry[2] == data

		@db_persistence.delete_entry(latest_entry[0])
		assert @db_persistence.db.changes == 1
	end

end
