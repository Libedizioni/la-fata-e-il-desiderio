#!/bin/bash

# measure script timing
time_start() {
    START=$(date +%s%3N)
}
time_end() {
    END=$(( $(date +%s%3N) - $START ))
}

# setup script variables
LATEX_ENGINE='xelatex'
#LATEX_ENGINE='lualatex'
#LATEX_ENGINE='pdflatex'
PDF="$BUILD/pdf/$BOOKNAME.pdf"

# remove previous build version
clean() {
    rm -f "$PDF"
}

# build pdf with pandoc
build_pdf() {
    echo "[+] now building pdf..."
    mkdir -p "$BUILD/pdf"
    # --variable mainfont='Raleway-Regular' \
    # --variable documentclass="$LATEX_CLASS" \
    pandoc --toc --toc-depth="$TOC_DEPTH" --latex-engine=$LATEX_ENGINE \
    --template="$TEMPLATE_PDF" \
    -o "$PDF" "$TITLE" $SOURCE
}

# report script info and execution time
report() {
    sec_diff=$(($END / 1000))
    ms_hrs=$(printf "%02d" $(($sec_diff / 3600)))
    ms_min=$(printf "%02d" $((($sec_diff / 60) % 60)))
    ms_sec=$(printf "%02d" $(($sec_diff % 60)))
    ms_msec=$(printf "%03d" $(($END % 1000)))
    TOT_TIME="$ms_hrs:$ms_min:$ms_sec:$ms_msec"

    echo "Script $( basename $0 ) execution time: " "$TOT_TIME"
}

# get it done!
time_start
clean
build_pdf
time_end
report
