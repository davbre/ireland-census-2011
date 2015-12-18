require_relative 'config/__init__.rb'

dlm = "\t"

column_map = {}

Dir.glob(DOWNLOADS_DIR + "original_tsv/*.tsv").sort.each do |original_file|

  new_file = File.dirname(original_file) + "/with_headers/" + File.basename(original_file)
  column_count = csv_column_count(original_file,dlm)

  column_hash = {}
  column_count.times do |i|
    if i == 0
      colname = "location_code"
    elsif i == 1
      colname = "location_type"
    elsif i == 2
      colname = "location_label"
    elsif i == 3
      colname = "category1"
    elsif i == 4 && column_count == 7
      colname = "category2"
    elsif i == (column_count - 2)
      colname = "count"
    elsif i == (column_count - 1)
      colname = "description"
    # else
    #   if i == 4
    #     if column_count == 6 colname = "category1"
    #     else colname
    else
      puts "WARNING: unexpected number of columns: " + original_file
      colname = "edit_col" + (i + 1).to_s
    end
    column_hash["col" + (i + 1).to_s] = colname
  end
  column_map[File.basename(original_file)] = column_hash

end

write_yaml(column_map,OUTPUT_DIR + "4.skeleton_column_map.yml")
