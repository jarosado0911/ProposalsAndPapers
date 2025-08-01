#!/bin/bash
## Split the main xsede.pdf into the required three pieces for XSEDE submission:
## 1) Proposal
## 2) Performance
## 3) References
## For convenience the concatenated main document xsede.pdf is also archived

OS=$(uname -s)
PDFJOIN=pdfjoin
PDFSTR="--outfile"
# Darwin needs special treatment
if [ "$OS" = "Linux" ]; then
  PDFJOIN=pdftk
  PDFSTR="cat output"
fi

# document files
main=xsede.pdf
numPages=$(pdfinfo $main | grep Pages | awk '{print $2}')
mainPages=()
refPages=()
# page limit
maxPages=10

if [ ! -z "$1" ]; then
  maxPages=$1
else
  maxPages=$((numPages-2))
fi

# split proposal pages
for i in $(seq 1 $maxPages); do
  mainPages+=( xsede-$i.pdf )
done

# split references pages
for i in $(seq $((maxPages+1)) $numPages); do
  refPages+=( xsede-$i.pdf )
done

# separate now document accordingly
pdfseparate -f 1 xsede.pdf xsede-%d.pdf

# join selected pages
$(${PDFJOIN} ${mainPages[@]} ${PDFSTR} proposal.pdf)
$(${PDFJOIN} ${refPages[@]} ${PDFSTR} references.pdf)

# remove temporary files
# rm ${mainPages[@]}
# rm ${refPages[@]}
