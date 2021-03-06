#' Find records using a global full-text search of VertNet archives.
#' 
#' Returns any record containing the text you input.
#'
#' @import plyr jsonlite httr data.table
#' @details \code{vertsearch} performs a nonspecific search for your input within
#'    every record and field of the VertNet archives. For a more specific
#'    search, try searchbyterm().
#' @param taxon Taxonomic identifier or other text to search for (character)
#' @param ... Additional search terms (character)
#' @param lim Limit on the number of records returned; up to 1000 (numeric)
#' @param compact Return a compact data frame (boolean)
#' @return A data frame of search results
#' @export
#' @examples \dontrun{
#'
#' out <- vertsearch(tax = "aves", "california")
#'
#' # Limit the number of records returned; use bigsearch() for >1000 records
#' out <- vertsearch("(kansas state OR KSU)", lim = 200)
#'
#' # Find multiple species using searchbyterm():
#'
#' # a) returns a specific result
#' out <- searchbyterm(gen = "mustela", sp = "(nivalis OR erminea)")
#' vertmap(out)
#'
#' # b) returns a non-specific result
#' out <- vertsearch(tax = "(mustela nivalis OR mustela erminea)")
#' vertmap(out)
#'
#' # c) returns a non-specific result
#' splist <- c("mustela nivalis", "mustela erminea")
#' out <- lapply(splist, function(x) vertsearch(t=x, lim=500))
#' vertmap(out)
#' }

vertsearch <- function(taxon = NULL, ..., lim = 1000, compact = TRUE)

{

  args <- compact(list(taxon, ...))

  r <- vertwrapper(fxn = "vertsearch", args = args, lim = lim, compact = compact)

}

