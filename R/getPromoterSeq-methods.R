setGeneric("getPromoterSeq", signature="query",
    function(query, subject, upstream, downstream, ...)
        standardGeneric("getPromoterSeq"))

setMethod("getPromoterSeq", "GRanges",
  function(query, subject, upstream, downstream, ...) {
    promoter.granges <- promoters(query, upstream, downstream)
    result <- getSeq(subject, promoter.granges)
    md <- mcols(query)
    geneIDs <- names(query)   # often NULL
    if (is.null(geneIDs))
      geneIDs <- rep(NA_character_, length(query))
    md$geneID <- geneIDs
    mcols(result) <- md
    result
    })

setMethod("getPromoterSeq", "GRangesList",
  function(query, subject, upstream, downstream, ...) {
    promoter.granges <- promoters(unlist(query), upstream, downstream)
    result <- getSeq(subject, promoter.granges)
    md <- mcols(unlist(query))
    geneIDs <- names(query)
    geneID.counts <- elementLengths(query)
    geneIDs <- rep(geneIDs, geneID.counts)
    md$geneID <- geneIDs
    mcols(result) <- md
    relist(result, query)
    })

