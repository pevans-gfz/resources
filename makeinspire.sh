#!/bin/sh
#
# Convert all DataCite XML files to ISO19139.

# Requires xsltproc and a suitable XSLT.
# The XSLT was developed by ....
# and is used under the Apache License, v 2.0, January 2004.
#

set -u

inputdir=datacite
outputdir=iso19139

[ ! -d "$inputdir" ] && echo "No datacite directory ${inputdir}" && exit 1
[ ! -d "$outputdir" ] && echo "No output directory ${outputdir}" && exit 1

make_inspire_xml() {
for x in $(cd ${inputdir}; ls *DataCite3.xml) ; do
	echo "File $x"
	outfile=${outputdir}/$(basename $x DataCite3.xml)19139.xml
	#echo $outfile
	xsltproc dataciteToISO19139v3.xslt ${inputdir}/$x >$outfile
done
}

lint_inspire_xml() {
for x in $(cd ${outputdir}; ls *19139.xml) ; do
	xmllint --noout ${outputdir}/$x
done
}

#make_inspire_xml
lint_inspire_xml
