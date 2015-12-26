require_relative 'config/__init__.rb'

inferred_datapackage = File.read(DOWNLOADS_DIR + "3.csv_r_modified/datapackage.json")
inferred_dp_hash = JSON.parse(inferred_datapackage)
tsv_link_pages = YAML.load(File.read(OUTPUT_DIR + "1.download_links.yml"))

inferred_dp_hash["resources"].each_with_index do |res,ndx|
  resource_description = tsv_link_pages["tsv"].select { |p| p["url"].split("/").last.split(".").first == res["path"].split(".").first }.first["label"]
  res["description"] = resource_description
end

# write new datapackage.json with description
File.open(DOWNLOADS_DIR + "3.csv_r_modified/datapackage-with-description.json","w") do |f|
  f.write(JSON.pretty_generate(inferred_dp_hash))
end
