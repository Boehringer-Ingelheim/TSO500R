% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wrangle.R
\name{read_dna_qc_metrics_snvtmb}
\alias{read_dna_qc_metrics_snvtmb}
\title{Read in a list of combined.quality.metrics.output objects
and return a data frame of dna qc metrics (small variants/tmb) per timepoint}
\usage{
read_dna_qc_metrics_snvtmb(qmo_list)
}
\arguments{
\item{qmo_list}{a list of combined.quality.metrics.output objects}
}
\value{
A data frame of dna qc metrics (small variants/tmb) extracted from
each combined.quality.metrics.output object, per timepoint
}
\description{
Read in a list of combined.quality.metrics.output objects
and return a data frame of dna qc metrics (small variants/tmb) per timepoint
}
