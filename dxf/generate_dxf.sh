#!/bin/bash

for line in `cat parts.txt`;
do
  echo "Exporting $line..."
  openscad -D '$line=true' ../scad/dxf.scad -o $line.dxf
done
