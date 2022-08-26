#!/bin/bash
for i in {26..50}
do

echo "---------第 $i 次" >> output_file.txt;
./level4_optim3 >> output_file.txt

done
echo "!"