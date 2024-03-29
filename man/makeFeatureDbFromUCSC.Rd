\name{makeFeatureDbFromUCSC}

\alias{supportedUCSCFeatureDbTracks}
\alias{supportedUCSCFeatureDbTables} 
\alias{UCSCFeatureDbTableSchema}
\alias{makeFeatureDbFromUCSC}

\title{
  Making a FeatureDb object from annotations available at the
  UCSC Genome Browser
}
\description{
  The \code{makeFeatureDbFromUCSC} function allows the user
  to make a \link{FeatureDb} object from simple annotation tracks at
  UCSC.  The tracks in question must (at a minimum) have a start, end and
  a chromosome affiliation in order to be made into a \link{FeatureDb}.
  This function requires a precise declaration of its first three
  arguments to indicate which genome, track and table wish to be
  imported.  There are discovery functions provided to make this process
  go smoothly.
}
\usage{
supportedUCSCFeatureDbTracks(genome)

supportedUCSCFeatureDbTables(genome, track)
 
UCSCFeatureDbTableSchema(genome,
                         track,
                         tablename)

makeFeatureDbFromUCSC(
        genome,
        track,
        tablename,
        columns = UCSCFeatureDbTableSchema(genome,track,tablename),
        url="http://genome.ucsc.edu/cgi-bin/",
        goldenPath_url="http://hgdownload.cse.ucsc.edu/goldenPath",
        chromCol, 
        chromStartCol, 
        chromEndCol)
}
\arguments{
  \item{genome}{genome abbreviation used by UCSC and obtained by
    \code{\link[rtracklayer]{ucscGenomes}()[ , "db"]}.
        For example: \code{"hg18"}.}
  \item{track}{name of the UCSC track.  Use
    \code{supportedUCSCFeatureDbTracks} to get the list of available
        tracks for a particular genome}
  \item{tablename}{name of the UCSC table containing the annotations to
        retrieve. Use the \code{supportedUCSCFeatureDbTables} utility
        function to get the list of supported tables for a track.}
  \item{columns}{a named character vector to list out the names and
        types of the other columns that the downloaded track should
        have.  Use \code{UCSCFeatureDbTableSchema} to retrieve this
        information for a particular table.}
  \item{url,goldenPath_url}{use to specify the location of an
        alternate UCSC Genome Browser.}
  \item{chromCol}{If the schema comes back and the 'chrom' column has been 
        labeled something other than 'chrom', use this argument to indicate 
        what that column has been labeled as so we can properly designate it.
        This could happen (for example) with the knownGene track tables, which
        has no 'chromStart' or 'chromEnd' columns, but which DOES have columns
        that could reasonably substitute for these columns under particular 
        circumstances.  Therefore we allow these three columns to have arguments
        so that their definition can be re-specified}
  \item{chromStartCol}{Same thing as chromCol, but for renames of 'chromStart'}
  \item{chromEndCol}{Same thing as chromCol, but for renames of 'chromEnd'}
}
\details{
  \code{makeFeatureDbFromUCSC} {is a convenience function that builds a
        tiny database from one of the UCSC track tables.}
  \code{supportedUCSCFeatureDbTracks} {a convenience function that
        returns potential track names that could be used to make
        FeatureDb objects}
  \code{supportedUCSCFeatureDbTables} {a convenience function that
        returns potential table names for FeatureDb objects (table names
        go with a track name)}
  \code{UCSCFeatureDbTableSchema} {A convenience function that creates a
        named vector of types for all the fields that can potentially be
        supported for a given track.  By default, this will be called on
        your specified tablename to include all of the fields in a track.}
  
  % \code{\link{makeFeatureDb}}
  % function.
  % See \code{?\link{makeFeatureDbFromBiomart}} for a similar function
  % that feeds data from a BioMart database.
}

\value{A \link{FeatureDb} object for \code{makeFeatureDbFromUCSC}.  Or in
  the case of \code{supportedUCSCFeatureDbTracks} and
  \code{UCSCFeatureDbTableSchema} a named character vector}

\author{
  M. Carlson and H. Pages
}

\seealso{
  \code{\link[rtracklayer]{ucscGenomes}},
  % \code{\link{makeFeatureDbFromBiomart}},
  % \code{\link{makeFeatureDb}}
}

\examples{
## Display the list of genomes available at UCSC:
library(GenomicFeatures)
library(rtracklayer)
ucscGenomes()[ , "db"]

## Display the list of Tracks supported by makeFeatureDbFromUCSC():
# supportedUCSCFeatureDbTracks("mm9")

## Display the list of tables supported by your track:
supportedUCSCFeatureDbTables(genome="mm9",
                             track="oreganno")

## Display fields that could be passed in to colnames:
UCSCFeatureDbTableSchema(genome="mm9",
                         track="oreganno",
                         tablename="oreganno")

## Retrieving a full transcript dataset for Yeast from UCSC:
fdb <- makeFeatureDbFromUCSC(genome="mm9",
                              track="oreganno",
                              tablename="oreganno")
fdb

}
