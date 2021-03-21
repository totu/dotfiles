#!/bin/bash
# needs fd (fd-find)
# npm install -g @node-minify/cli
# npm install -g @node-minify/html-minifier
# npm install -g @node-minify/cssnano
# npm install -g @node-minify/terser

fd css -x node-minify --compressor clean-css --input '{}' --output '{}'
fd js -x node-minify --compressor terser --input '{}' --output '{}'
# fd html -x node-minify --compressor html-minifier --input '{}' --output '{}'

