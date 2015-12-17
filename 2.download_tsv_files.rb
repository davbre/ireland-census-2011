require_relative 'helpers/__init__.rb'

tsv_links = YAML.load(File.read(OUTPUT_DIR + "1.download_links.yml"))[:tsv]
sleep_time = 2

tsv_links.each do |link|
  tsv_file_name = link.split("/").last
  download_url = CSO_CENSUS_2011_HOME + link
  open(DOWNLOADS_DIR + "original_tsv/" + tsv_file_name, 'wb') do |tsv|
    puts "Downloading " + download_url
    tsv << open(download_url).read
    sleep(sleep_time)
  end
end
