require_relative 'config/__init__.rb'

list_of_files_to_move = Dir[ROOT_PATH + "/" + DOWNLOADS_DIR + "3.csv_r_modified/*.csv"]
FileUtils.cp_r(list_of_files_to_move, ROOT_PATH + "/datapackage/data")
