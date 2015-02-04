#!/bin/sh
#Created by Kevin A. Dorfer
#February 3rd 2015

OUT_DIR=out
BEFORE_DIR=before
AFTER_DIR=after

if [ ! -d "$OUT_DIR" ]; then
	echo "$OUT_DIR doesn't exist"
	exit 2
fi

if [ ! -d "$BEFORE_DIR" ]; then
	echo "$BEFORE_DIR doesn't exist"
	exit 2  
fi

if [ ! -d "$AFTER_DIR" ]; then
	echo "$AFTER_DIR doesn't exist"
	exit 2
fi


echo "- start part 1 ..."

cd $BEFORE_DIR

for f in *.war; do
	echo "Processing $f file...";
	filename="${f%.*}"
	
	if [ ! -d "$filename" ]; then
        	echo "create dir $filename"
		mkdir $filename
	else 
		echo "clean dir $filename"
		rm -rf $filename
		mkdir $filename
	fi
	
	echo "unzip $f..."
	unzip $f -d $filename
done
echo "Done part 1"
cd ..

echo "- start part 2 ..."

cd $AFTER_DIR

for f in *.war; do
        echo "Processing $f file...";
        filename="${f%.*}"

        if [ ! -d "$filename" ]; then
                echo "create dir $filename"
                mkdir $filename
        else
                echo "clean dir $filename"
                rm -rf $filename
                mkdir $filename
        fi

        echo "unzip $f..."
        unzip $f -d $filename
done
echo "Done part 2"
cd ..

echo "Start Diff"

for f in $BEFORE_DIR/*.war; do
        filename=$(basename "$f")
	filename="${filename%.*}"
	
	echo "compare $BEFORE_DIR/$filename and $AFTER_DIR/$filename" 
	diff -arq $BEFORE_DIR/$filename $AFTER_DIR/$filename >> $OUT_DIR/$filename.report
done

echo "Done Diff"
