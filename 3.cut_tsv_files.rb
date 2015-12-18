require_relative 'config/__init__.rb'

# keep n observations from each tsv file. The reason for this is to create
# a small file which can be opened quickly to get an idea of the contents
max_lines = 50

Dir.glob(DOWNLOADS_DIR + "original_tsv/*.tsv") do |orig_tsv|

  cut_file = DOWNLOADS_DIR + "cut_tsv/" + File.basename(orig_tsv)
  puts "Creating cut version of " + orig_tsv
  File.open(cut_file, 'w') do |f|
    line_count = 0
    File.foreach(orig_tsv) do |l|
      line_count += 1
      break if line_count > max_lines
      f.puts l
    end
  end
end
