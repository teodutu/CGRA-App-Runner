#! /bin/sh

if [ $# -ne 2 ]; then
    echo "Usage: $0 <path_to_input_file> <function_to_map>"
    exit 1
fi

MORPHER=Morpher
VERSAT=Versat

INPUT_FILE=$1
FUNCTION=$2

# Split INPUT_FILE into a list made up of the directiores in the path
MORPHER_INPUT=$(echo $INPUT_FILE | rev | cut -d"/" -f1-3 | rev)
APP_DIR=$(dirname $INPUT_FILE)
FILE_NAME=$(basename $INPUT_FILE)
APP_NAME="${FILE_NAME%.*}"
XML_FILE=$APP_DIR/$FUNCTION"_PartPredDFG.xml"
NUM_FILES=$(ls ${APP_DIR}/memtraces | wc -l)
VERSAT_APP_DIR=$VERSAT/software/pc-emul/morpher_files/$APP_NAME

echo $MORPHER_INPUT
echo $APP_DIR
echo $APP_NAME
echo $XML_FILE
echo $NUM_FILES
echo $DATA_LOCATION
echo $VERSAT_APP_DIR

cd $MORPHER
echo "Running Morpher..."
echo "==========================================="

python3 run_morpher.py $MORPHER_INPUT $FUNCTION &2>1 > /dev/null

cd ..
echo Copying files from Morpher to Versat...
echo "==========================================="
mkdir -p $VERSAT_APP_DIR

cp $XML_FILE $VERSAT_APP_DIR/$APP_NAME.xml

if [ $NUM_FILES -eq 1 ]; then
    cp $APP_DIR/memtraces/$FUNCTION"_trace_0.txt" $VERSAT_APP_DIR/$APP_NAME.csv
else
    mkdir -p $VERSAT_APP_DIR/inputs
    cp $APP_DIR/memtraces/* $VERSAT_APP_DIR/inputs
fi

cd $VERSAT
echo "Running Versat..."
echo "==========================================="

if [ $NUM_FILES -eq 1 ]; then
    make morpher-script-test APP_NAME
else
    make morpher-script-test APP_NAME NESTED_LOOP=1
fi
