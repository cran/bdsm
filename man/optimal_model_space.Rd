% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model_space.R
\name{optimal_model_space}
\alias{optimal_model_space}
\title{Finds MLE parameters for each model in the given model space}
\usage{
optimal_model_space(
  df,
  timestamp_col,
  entity_col,
  dep_var_col,
  init_value,
  exact_value = TRUE,
  run_parallel = FALSE,
  control = list(trace = 2, maxit = 10000, fnscale = -1, REPORT = 100, scale = 0.05)
)
}
\arguments{
\item{df}{Data frame with data for the SEM analysis.}

\item{timestamp_col}{The name of the column with time stamps}

\item{entity_col}{Column with entities (e.g. countries)}

\item{dep_var_col}{Column with the dependent variable}

\item{init_value}{The value with which the model space will be initialized.
This will be the starting point for the numerical optimization.}

\item{exact_value}{Whether the exact value of the likelihood should be
computed (\code{TRUE}) or just the proportional part (\code{FALSE}). Check
\link[bdsm]{SEM_likelihood} for details.}

\item{run_parallel}{If \code{TRUE} the optimization is run in parallel using
the \link[parallel]{parApply} function. If \code{FALSE} (default value) the
base apply function is used. Note that using the parallel computing requires
setting the default cluster. See README.}

\item{control}{a list of control parameters for the optimization which are
passed to \link[stats]{optim}. Default is
\code{list(trace = 2, maxit = 10000, fnscale = -1, REPORT = 100, scale = 0.05)}, but note
that \code{scale} is used only for adjusting the \code{parscale} element added later in the function code.}
}
\value{
List of parameters describing analyzed models
}
\description{
Given a dataset and an initial value for parameters, initializes a model
space with parameters equal to initial value for each model. Then for each
model performs a numerical optimization and finds parameters which maximize
the likelihood.
}
\examples{
\donttest{
library(magrittr)

data_prepared <- economic_growth[,1:7] \%>\%
   feature_standardization(timestamp_col = year, entity_col = country) \%>\%
   feature_standardization(timestamp_col = year, entity_col = country,
                           time_effects = TRUE, scale = FALSE)

model_space <- optimal_model_space(df = data_prepared, dep_var_col = gdp,
                                   timestamp_col = year, entity_col = country,
                                   init_value = 0.5)
}

}
