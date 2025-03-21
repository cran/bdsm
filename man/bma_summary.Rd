% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SEM_bma.R
\name{bma_summary}
\alias{bma_summary}
\title{Summary of a model space}
\usage{
bma_summary(
  df,
  dep_var_col,
  timestamp_col,
  entity_col,
  model_space,
  exact_value = TRUE,
  model_prior = "uniform",
  run_parallel = FALSE
)
}
\arguments{
\item{df}{Data frame with data for the SEM analysis.}

\item{dep_var_col}{Column with the dependent variable}

\item{timestamp_col}{The name of the column with timestamps}

\item{entity_col}{Column with entities (e.g. countries)}

\item{model_space}{A matrix (with named rows) with each column corresponding
to a model. Each column specifies model parameters. Compare with
\link[bdsm]{optimal_model_space}}

\item{exact_value}{Whether the exact value of the likelihood should be
computed (\code{TRUE}) or just the proportional part (\code{FALSE}). Check
\link[bdsm]{SEM_likelihood} for details.}

\item{model_prior}{Which model prior to use. For now there are two options:
\code{'uniform'} and \code{'binomial-beta'}. Default is \code{'uniform'}.}

\item{run_parallel}{If \code{TRUE} the optimization is run in parallel using
the \link[parallel]{parApply} function. If \code{FALSE} (default value) the
base apply function is used. Note that using the parallel computing requires
setting the default cluster. See README.}
}
\value{
List of parameters describing analyzed models
}
\description{
A summary of a given model space is prepared. This include things such as
posterior inclusion probability (PIP), posterior mean and so on. This is the
core function of the package, because it allows to make assessments and
decisions about the parameters and models.
}
\examples{
\donttest{
library(magrittr)

data_prepared <- economic_growth[,1:7] \%>\%
   feature_standardization(timestamp_col = year, entity_col = country) \%>\%
   feature_standardization(timestamp_col = year, entity_col = country,
                           time_effects = TRUE, scale = FALSE)


bma_result <- bma_summary(df = data_prepared, dep_var_col = gdp,
                          timestamp_col = year, entity_col = country,
                          model_space = economic_growth_ms)
}

}
