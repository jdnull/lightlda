#!/bin/bash

root=`pwd`
echo $root
bin=$root/../bin
dir=$root/data/nytimes

cd $dir


# 2. UCI format to libsvm format
python $root/example/text2libsvm.py $dir/docword.nytimes.txt $dir/vocab.nytimes.txt $dir/nytimes.libsvm $dir/nytimes.word_id.dict

# 3. libsvm format to binary format
$bin/dump_binary $dir/nytimes.libsvm $dir/nytimes.word_id.dict $dir 0

# 4. Run LightLDA
$bin/lightlda -num_vocabs 111400 -num_topics 1000 -num_iterations 100 -alpha 0.1 -beta 0.01 -mh_steps 2 -num_local_workers 1 -num_blocks 1 -max_num_document 300000 -input_dir $dir -data_capacity 800
