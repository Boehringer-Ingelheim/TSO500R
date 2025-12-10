#' Read Excel spreadsheet into a list of data frames, per sheet
#'
#' @param annotation_data_path Path to annotation .xlsx
#' @param sheet_names List of names of the sheets in the Excel spreadsheet
#'
#' @return list of data.frame
#' @export
#'
#' @importFrom purrr map
#' @importFrom readxl read_excel
#' @importFrom janitor clean_names
read_annotation_data <- function(annotation_data_path, sheet_names) {
  annotations <- map(sheet_names, ~ read_excel(annotation_data_path, sheet = .x) |> clean_names())
  names(annotations) <- sheet_names
  return(annotations)
}
