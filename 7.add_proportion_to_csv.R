# set working directory to be equal to this script's path
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

download_dir = paste(getwd(), "/downloads/2.csv_with_headers", sep="")
new_csv_dir = paste(getwd(), "/downloads/3.csv_r_modified",sep="")

original_files = list.files(path = download_dir, pattern = "*.csv")

#original_files = c("ability_to_speak_irish__popula.csv","gender_number_of_unpaid_hours_.csv")
#,"children_over_15_in_family__fa.csv")

for(csv_file in original_files) {

  cat("\n\nProcessing",csv_file);

  # Read csv
  cat("\nStep 1");
  original_file = paste(download_dir,csv_file,sep="/")
  cso1 = read.csv(file=original_file,head=TRUE,sep="\t")
  
  if("category2" %in% colnames(cso1)) {
    last_cat_var = "category2"
    add_to_formula= " + category1"
  } else {
    last_cat_var = "category1"
    add_to_formula = ""
  }
  cat("\nUsing",last_cat_var)
  # As the "all" rows are not in every spreadsheet, we remove them if they're present and re-derive them
  cso2 = cso1[cso1[,last_cat_var] != "all",]
  
  # Derive "all" counts
  by_formula_string = paste0("count ~ location_code + location_type + location_label",add_to_formula,"+ description")
  agg_formula = formula(by_formula_string)
  cat("\nAggregate formula string:",by_formula_string)
  
  all_counts = aggregate(agg_formula, cso2, sum)
  # add "all" column before binding two data frames
  all_counts[, last_cat_var] <- "all"
  
  # bind "all" rows. If the "all" rows were already present then this new
  # data frame should be the same as the old one
  cso3 <-rbind(cso2, all_counts)
  
  # merge the "all" values so percentages can be added
  cat("\nMerging 'all' values")
  all_keep_vars <- c("location_code","count")
  all_merge_by = c("location_code")
  if(last_cat_var == "category2") {
    all_keep_vars = append(all_keep_vars, "category1")
    all_merge_by = append(all_merge_by, "category1")
  }
  abbrev_all_df <- all_counts[all_keep_vars]
  names(abbrev_all_df)[names(abbrev_all_df) == 'count'] <- 'all_count' # rename count variable
  cso4 = merge(cso3, abbrev_all_df)[, union(names(cso3), names(abbrev_all_df))] # square brackets portion is for maintaining column order (http://stackoverflow.com/a/17579145/1002140)

  # With "all" values can now add percentages
  cat("\nAdd percentages")
  cso4$percent <- round(cso4$count / cso4$all_count*100, digits = 2)

  # Sort dataframe
  csv_order = with(cso4, order(location_code,location_type,category1))
  if(last_cat_var == "category2") {
    cso5 <- cso4[with(cso4, order(location_code,location_type,category1,category2)),]
  } else {
    cso5 <- cso4[with(cso4, order(location_code,location_type,category1)),]
  }

  # Write out new csv file
  cat("\nWrite out new csv file")
  new_csv_file = paste(new_csv_dir,csv_file,sep="/")
  write.table(cso5, file = new_csv_file, row.names = FALSE, col.names = TRUE, sep="\t")
  
  #all_merge_by = c("location_code")
  #if(last_cat_var == "category2") {
  #  all_merge_by = append(all_merge_by, "category1")
  #}
  #cso4 = merge(cso3, all_counts,by=all_merge_by)
  
  # Extract 'all' rows
#  print("Step 2")
#  cso2 = cso1[cso1$category1 == "all",c("location_code","count")]
  
  # Rename count column
#  print("Step 3")
#  names(cso2)[names(cso2) == 'count'] <- 'all_count'
  
  # Merge 'all' rows
#  print("Step 4")
#  cso3 = merge(cso1, cso2, by = "location_code")
  
  # Derive proportion
#  print("Step 5")
#  cso3$percent <- cso3$count / cso3$all_count*100
  
  # Write out new csv file
#  print("Step 6")
#  new_csv_file = paste(new_csv_dir,csv_file,sep="/")
#  write.table(cso3, file = new_csv_file, col.names = TRUE, sep="\t")
}