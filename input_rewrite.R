# Load necessary package
library(dplyr)
library(openxlsx)
# Read CSV file
# Replace 'your_file.csv' with the actual file name
df <- read.csv("Hof_luetke_input_table.csv", stringsAsFactors = FALSE)

# View the first few rows (optional)
# head(df)

# Apply renaming rules based on distribution column
df <- df %>%
  mutate(variable = case_when(
    grepl("posnorm", distribution, ignore.case = TRUE) ~ paste0(variable, "_p"),
    grepl("tnorm_0_1", distribution, ignore.case = TRUE) ~ paste0(variable, "_t"),
    grepl("const", distribution, ignore.case = TRUE) ~ paste0(variable, "_c"),
    TRUE ~ variable  # leave unchanged if none match
  ))

# View updated dataframe (optional)
# View(df)
write.xlsx(x= df,file="Hof_luetke_input_table.xlsx",rowNames=FALSE)   # equivalent to row.names = FALSE
#write_xlsx(df, "modified_output.xlsx")
# Save modified data to a new CSV file
write.csv(df, "modified_output.csv", row.names = FALSE)
