#' Read in a TMB_trace.tsv file and store as an object
#'
#' @description Read in a TMB_trace.tsv file
#'
#' @param tmb_file_path a file path to a TMB_trace.tsv file
#'
#' @return A tmb.variant.output object
#'
#' @export
tmb <- function(tmb_file_path) {
  new_tmb_variant_output(tmb_file_path)
}

#' Constructor function for tmb.variant.output objects
#' Not to be called directly
#'
#' @param tmb_file_path a file path to a TMB_trace.tsv file
#'
#' @return A tmb.variant.output object
#'
#' @importFrom readr read_tsv
new_tmb_variant_output <- function(tmb_file_path) {
  tmb_data <- read_tsv(tmb_file_path)
  return(structure(tmb_data, class = "tmb.variant.output"))
}

#' Extract TMB data from tmb.variant.output object
#'
#' @param tmb_obj A tmb.variant.output object
#' @param ... Additional arguments (not used)
#'
#' @return A data frame with TMB data
#'
#' @export
get_tmb_data <- function(tmb_obj, ...) {
  UseMethod("get_tmb_data", tmb_obj)
}

#' Extract TMB data from tmb.variant.output object
#'
#' @param tmb_obj A tmb.variant.output object
#' @param ... Additional arguments (not used)
#'
#' @return A data frame with TMB data
#' @method get_tmb_data tmb.variant.output
#'
#' @export
get_tmb_data.tmb.variant.output <- function(tmb_obj, ...) {
  return(as.data.frame(tmb_obj))
}

#' Read in a batch of TMB_trace.tsv files into a list
#'
#' @param tmb_directory a file path to a directory containing one of more
#' TMB_trace.tsv files
#'
#' @return A named list of data frame objects
#'
#' @export
#'
#' @importFrom readr read_tsv
#' @importFrom tidyr unnest
#' @importFrom dplyr mutate relocate select
#' @importFrom stringr str_replace
#' @importFrom tibble tibble
#' @importFrom rlang .data
read_tmb_trace_data <- function(tmb_directory) {
  tmb_files <- list.files(
    path = tmb_directory,
    pattern = "*TMB_Trace\\.tsv$|tmb.trace\\.tsv$",
    recursive = TRUE,
    full.names = TRUE
  )

  if (length(tmb_files) == 0) {
    warning("No TMB trace files found in directory: ", tmb_directory)
    return(tibble())
  }

  tmb_data <- tibble(file = tmb_files) |>
    mutate(data = lapply(.data$file, read_tsv)) |>
    unnest(.data$data) |>
    mutate(sample_id = str_replace(basename(.data$file), "_TMB_Trace\\.tsv|.tmb.trace\\.tsv", "")) |>
    select(-.data$file) |>
    relocate(.data$sample_id)

  tmb_data
}

#' Read in a batch of *tmb.json files into a list
#'
#' @param tmb_directory a file path to a directory containing one of more
#' *tmb.json files
#'
#' @return A named list of data frame objects
#'
#' @export
#'
#' @importFrom jsonlite read_json
#' @importFrom tidyr unnest_wider
#' @importFrom dplyr mutate relocate select
#' @importFrom stringr str_replace
#' @importFrom tibble tibble
#' @importFrom rlang .data
read_tmb_details_data <- function(tmb_directory) {
  tmb_files <- list.files(
    path = tmb_directory,
    pattern = "*tmb.json",
    full.names = TRUE
  )

  if (length(tmb_files) == 0) {
    warning("No TMB JSON files found in directory: ", tmb_directory)
    return(data.frame())
  }

  tmb_data <- tibble(file = tmb_files) |>
    mutate(data = lapply(tmb_files, read_json)) |>
    unnest_wider(.data$data) |>
    unnest_wider(.data$Settings) |>
    mutate(sample_id = str_replace(basename(.data$file), "\\.tmb\\.json", "")) |>
    select(-.data$file) |>
    relocate(.data$sample_id)

  tmb_data
}

#' Read in a batch of *tmb.metrics.csv files into a list
#'
#' @param tmb_directory a file path to a directory containing one of more
#' *tmb.metrics.csv files
#'
#' @return A data frame with TMB metrics data
#'
#' @export
#'
#' @importFrom dplyr mutate select relocate
#' @importFrom tidyr unnest_longer unnest pivot_wider
#' @importFrom tibble tibble
#' @importFrom stringr str_replace
#' @importFrom rlang .data
read_tmb_details_data_csv <- function(tmb_directory) {
  tmb_files <- list.files(
    path = tmb_directory,
    pattern = "*tmb.metrics.csv",
    full.names = TRUE
  )

  if (length(tmb_files) == 0) {
    warning("No TMB metrics CSV files found in directory: ", tmb_directory)
    return(data.frame())
  }

  tmb_data <- tibble(file = tmb_files) |>
    mutate(data = lapply(tmb_files, read.table, header = FALSE, sep = ",")) |>
    unnest_longer(.data$data) |>
    unnest(.data$data) |>
    select(-c(.data$V1, .data$V2)) |>
    pivot_wider(names_from = .data$V3, values_from = .data$V4) |>
    mutate(sample_id = str_replace(basename(.data$file), "\\.tmb\\.metrics\\.csv", "")) |>
    select(-.data$file) |>
    relocate(.data$sample_id)

  tmb_data
}
