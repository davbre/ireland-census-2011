require_relative 'config/__init__.rb'

ds_page = Nokogiri::HTML(open(CSO_CENSUS_2011_LINK_PAGE))

download_link_pages = get_download_pages(ds_page)
write_yaml(download_link_pages,OUTPUT_DIR + "1.download_link_pages.yml")

# download_pages = download_link_pages.map{ |e| e["page"]}
download_links = get_download_links(download_link_pages)
write_yaml(download_links,OUTPUT_DIR + "1.download_links.yml")
