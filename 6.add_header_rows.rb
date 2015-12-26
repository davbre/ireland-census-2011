require_relative 'config/__init__.rb'

dlm = "\t"

new_csv_column_name_hash = YAML.load(File.read(CONFIG_DIR + "column_map.yml"))

Dir.glob(DOWNLOADS_DIR + "1.tsv_original/" + "*.tsv") do |original_file|

  new_filename = File.basename(original_file).split(".").first
  new_file = DOWNLOADS_DIR + "2.csv_with_headers/" + new_filename + ".csv"
  new_column_names = new_csv_column_name_hash[File.basename(original_file)]

  header_string = new_column_names.map {|k,v| v }.join(dlm)

  File.open(new_file, 'w') do |f|

    f.puts header_string

    File.foreach(original_file) do |l|
      f.puts l
    end
  end

end
