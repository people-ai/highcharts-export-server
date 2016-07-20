#!/bin/sh

echo "Start phantomjs"
cd phantomjs && phantomjs highcharts-convert.js -host 0.0.0.0 -port 3003

