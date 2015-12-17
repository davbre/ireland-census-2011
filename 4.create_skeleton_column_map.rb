require_relative 'helpers/__init__.rb'

dlm = "\t"

column_map = {}

Dir.glob(DOWNLOADS_DIR + "original_tsv/*.tsv") do |original_file|

  new_file = File.dirname(original_file) + "/with_headers/" + File.basename(original_file)
  column_count = csv_column_count(original_file,dlm)

  column_hash = {}
  column_count.times do |i|
    column_hash["col" + i.to_s] = "**EDIT**"
  end
  column_map[File.basename(original_file)] = column_hash

  # header_string = (1..column_count).to_a.map { |e| "col" + e.to_s}.join("\t")

  # File.open(OUTPUT_DIR + "4.skeleton_column_map.yml", 'w') do |f|
  #
  #   f.puts header_string
  #
  #   File.foreach(original_file) do |l|
  #     f.puts l
  #   end
  # end

end

write_yaml(column_map,OUTPUT_DIR + "4.skeleton_column_map.yml")
