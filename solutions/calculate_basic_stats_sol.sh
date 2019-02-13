#!/bin/bash
# this script calculates the MAX, MIN and MEAN of the word frequencies in the
# file http://www.gutenberg.org/files/58785/58785-0.txt using liux commands

if [ $# -ne 1 ]
   then
       echo "Please provide a txt file url"
       echo "usage ./calculate_basic_stats.sh  url"
       #exit with error
       exit 1
fi   

echo  "############### Statistics for file  ############### "
echo $1
# http://www.gutenberg.org/files/58785/58785-0.txt
total_freq=0
count=0
sorted_words=`curl -s $1|tr [A-Z] [a-z]|grep -oE "\w+"|sort|uniq -c|sort  -k1,1n -k2,2r`
total_uniq_words=`echo "$sorted_words"|wc -l`

echo "Total number of words = $total_uniq_words"
#check do we need to take middle two counts(even scenario) or just middle(odd scenario)
if [ $(( $total_uniq_words % 2 )) -eq 0  ]
then
      echo "Even number of words"
      median_words=`echo "$sorted_words"|awk '{print $1}'|head -n $(( $total_uniq_words/2 + 1 ))| tail -n 2`
      median_val=0
      for freq_val in $median_words
        do              
        median_val=$(( $freq_val + $median_val ))
        done
      echo "Median value = $(( $median_val / 2 ))"
 else
     echo "odd numbef of counts"
     echo  "median value is `echo "$sorted_words"|awk '{print $1}'|head -n $(( $total_uniq_words/2 + 1 ))| tail -n 1`"
fi

echo "Min frequency and word  `echo "$sorted_words"|head -1`"
echo "Max frequency and word  `echo "$sorted_words"|tail -1`"
for freq in `echo "$sorted_words"|awk '{print $1}'`
do
    total_freq=$(( $total_freq + $freq ))
    count=$(( $count + 1))
done

mean=$(( $total_freq / $count ))

echo "Sum of frequencies = $total_freq"
echo "Total unique words = $count"
echo "Mean frequency using integer arithmetics = $mean"

echo "Mean frequency using floating point arithemetics = `echo "1.0 * $total_freq / $count"|bc -l`"


function lazy_commit(){
    echo "data science"

    }
