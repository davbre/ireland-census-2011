def write_yaml(what,where)
  File.open(where, "w") do |file|
    file.write what.to_yaml
  end
end

def get_download_pages(ds_page)
  download_link_pages = []
  number_of_downloads = 0
  ds_page.xpath('//article/ul/li/a').each do |a|
    download_link_pages << { "page" => a.attributes["href"].value, "label" => a.children.to_s }
    number_of_downloads += 1
  end
  puts number_of_downloads.to_s + " download pages detected"
  download_link_pages
end

def get_download_links(download_link_pages)
  download_links = { "tsv" => []}
  download_link_pages.each do |dl_link|
    dl_page = Nokogiri::HTML(open(CSO_CENSUS_2011_LINK_PAGE + dl_link["page"]))
    tsv_anchor = dl_page.xpath("//h4/a")
    tsv_anchor.first.attributes["href"].value
    raise "Aborting! Expecting only a single TSV file!" if tsv_anchor.length != 1
    download_links["tsv"] << { "url" => tsv_anchor.first.attributes["href"].value, "label" => dl_link["label"] }
  end
  download_links
end

def csv_column_count(file,dlm)
  # read first line to determine number of columns
  column_count = 0
  CSV.foreach(file,{:col_sep => dlm}) do |row|
    column_count = row.length
    break
  end
  column_count
end
