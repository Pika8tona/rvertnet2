#' Search for records using keywords/terms to control how your query is interpreted.
#'
#' Returns only those records in which the targeted input is found in
#' association with the specified search terms.  Not a global search.
#' 
#' @import plyr jsonlite httr data.table
#' @details \code{searchbyterm} builds a query from input parameters based on 
#'    Darwin Core (dwc) terms (for the full list of terms, see
#'    https://code.google.com/p/darwincore/wiki/DarwinCoreTerms).
#'    The query string is appended to the base URL for VertNet 
#'    search requests. View the query string for specification of 
#'    dwc terms used in the search.
#' @param specificepithet Taxonomic species (character)
#' @param genus Taxonomic genus (character)
#' @param family Taxonomic family (character)
#' @param order Taxonomic order (character)
#' @param class Taxonomic class (character)
#' @param lim Limit on the number of records returned (numeric)
#' @param compact Return a compact data frame (boolean)
#' @param year Year (numeric) or range of years designated by comparison
#'  operators "<", ">", "<=" or ">=" (character)
#' @param date Event date associated with this occurrence record; yyyy-mm-dd
#'  or the range yyyy-mm-dd/yyyy-mm-dd (character)
#' @param mappable Record includes valid coordinates in decimal latitude and
#'  decimal longitude; 1 = yes, 0 = no (boolean)
#' @param error Coordinate uncertainty in meters (numeric) or range of uncertainty
#'  values designated by comparison operators "<", ">", "<=" or ">=" (character)
#' @param continent Continent to search for occurrence (character)
#' @param cntry Country to search for occurrence (character)
#' @param stateprovince State or province to search for occurrence (character)
#' @param county County to search for occurrence (character)
#' @param island Island to search for occurrence (character)
#' @param igroup Island group to search for occurrence (character)
#' @param inst Code name for the provider/institution of record (character)
#' @param id Provider's unique identifier for this occurrence record (character)
#' @param catalognumber Provider's catalog number or other ID for this record (character)
#' @param collector Collector name (character)
#' @param type Type of record; "specimen" or "observation" (character)
#' @param hastypestatus Specimen associated with this record is identified as a
#'    holotype, paratype, neotype, etc. (character)
#' @param media Record also references associated media, such as a film or video;
#'    1 = yes, 0 = no (boolean)
#' @param rank TBD (numeric)
#' @param tissue Record is likely to reference tissues; 1 = yes, 0 = no (boolean)
#' @param resource Identifier for the resource/dataset from which the record was
#'  indexed (character)
#' @return A data frame of search results
#' @export
#' @examples \dontrun{
#'
#' # Find multiple species
#' out <- searchbyterm(gen = "ochotona", sp = "(princeps OR collaris)")
#'
#' # Find records in multiple locations
#' out <- searchbyterm(sp = "mustela nigripes", st = "(wyoming OR south dakota)")
#'
#' # Limit the number of records returned to <1000; use bigsearch() for >1000 records
#' out <- searchbyterm(cl = "aves", st = "california", lim = 10)
#'
#' # Specifying a single year (no quotes) or range of years (use quotes)
#' out <- searchbyterm(cl = "aves", st = "california", y = 1976)
#' out <- searchbyterm(cl = "aves", st = "california", y = ">=1976")
#'
#' # Specifying a range (in meters) for uncertainty in spatial location (use quotes)
#' out <- searchbyterm(cl = "aves", st = "nevada", err = "<25")
#' out <- searchbyterm(cl = "aves", st = "california", y = 1976, err = "<=1000")
#'
#' # Specifying records by event date (use quotes)
#' out <- searchbyterm(cl = "aves", st = "california", date = "2009-03-25")
#' # ...but specifying a date range may not work
#' out <- searchbyterm(sp = "mustela nigripes", date = "1935-09-01/1935-09-30")
#' }

searchbyterm <- function(specificepithet = NULL, genus = NULL, family = NULL, order = NULL,
                  class = NULL, lim = 1000, compact = TRUE, year = NULL, date = NULL,
                  mappable = NULL, error = NULL, continent = NULL, cntry = NULL,
                  stateprovince = NULL, county = NULL, island = NULL, igroup = NULL,
                  inst = NULL, id = NULL, catalognumber = NULL, collector = NULL, type = NULL,
                  hastypestatus = NULL, media = NULL, rank = NULL, tissue = NULL, resource = NULL)

{

  args <- compact(list(specificepithet = specificepithet, genus = genus, family = family,
                       order = order, class = class, year = year, eventdate = date,
                       mappable = mappable, coordinateuncertaintyinmeters = error,
                       continent = continent, country = cntry, stateprovince = stateprovince,
                       county = county, island = island, islandgroup = igroup,
                       institutioncode = inst, occurrenceid = id, catalognumber = catalognumber,
                       recordedby = collector, type = type, hastypestatus = hastypestatus,
                       media = media, rank = rank, tissue = tissue, resource = resource))

  r <- vertwrapper(fxn = "searchbyterm", args = args, lim = lim, compact = compact)

}


