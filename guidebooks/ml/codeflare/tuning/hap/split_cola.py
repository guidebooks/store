#!/usr/bin/env python

#HAP -> GLUE filtering code by Rong Zhang (zhangr@us.ibm.com)
#Updates by Sara Kokkila-Schumacher (saraks@ibm.com)

import sys
import  csv

score_file = sys.argv[1]
data_file = sys.argv[2]
good_file = sys.argv[3]
bad_file = sys.argv[4]

scores = dict()

print("processing score file")
with open(score_file) as SF:
    csv_reader = csv.reader(SF, delimiter=',')
    line_count = 0
    for row in csv_reader:
        if line_count == 0:
            line_count += 1
            continue
        else:
            if len(row) != 6:
                print(line_count)
            line_count += 1
            #Error here, row[1] != row[0] for sentences that include time formats 
            #scores[row[1]] = float(row[5])
            scores[row[0]] = float(row[5])
            continue    
    print(f'Processed {line_count} lines.')

GF = open(good_file, mode='w')
BF = open(bad_file, mode='w')

GF_writer = csv.writer(GF, delimiter='\t')
BF_writer = csv.writer(BF, delimiter='\t')

print("processing data file")
with open(data_file) as DF:
    csv_reader = csv.reader(DF, delimiter='\t')
    line_count = 0
    count_good = 0
    count_bad = 0
    for row in csv_reader:
        if len(row) != 4:
            print(line_count)
        if scores[row[3]] < 0.5:
            count_good += 1
            GF_writer.writerow(row)
        else:
            count_bad += 1
            BF_writer.writerow(row)
        line_count += 1
        continue    
    print(f'Processed {line_count} lines.')
    print("good:", count_good, round(float(count_good) / float(line_count), 3))
    print("bad:", count_bad, round(float(count_bad) / float(line_count), 3))
