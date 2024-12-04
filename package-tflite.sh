#!/bin/bash

# Check if PACKAGE_DIR is provided
if [ -z "$1" ]; then
    echo "Usage: $0 PACKAGE_DIR"
    exit 1
fi

PACKAGE_DIR=$1

# Detect the operating system
OS_TYPE=$(uname)

if [[ "$OS_TYPE" == "MINGW32_NT" ]] || [[ "$OS_TYPE" == "MINGW64_NT" ]]; then
    OS_TYPE="Windows"
    if [ -z "$2" ]; then
        echo "Usage: $0 PACKAGE_DIR BUILD_TYPE"
        exit 1
    fi

    BUILD_TYPE=$2
fi

# Your packaging logic here
echo "Packaging TensorFlow Lite in directory: $PACKAGE_DIR"

mkdir -p $PACKAGE_DIR
mkdir -p $PACKAGE_DIR/include
mkdir -p $PACKAGE_DIR/include/tensorflow/lite
mkdir -p $PACKAGE_DIR/include/tensorflow/lite/core/c
mkdir -p $PACKAGE_DIR/include/tensorflow/lite/core/async/c
mkdir -p $PACKAGE_DIR/lib

cp "tensorflow/tensorflow/lite/c/c_api.h" $PACKAGE_DIR/include/tensorflow/lite;
cp "tensorflow/tensorflow/lite/c/c_api_experimental.h" $PACKAGE_DIR/include/tensorflow/lite;
cp "tensorflow/tensorflow/lite/c/c_api_types.h" $PACKAGE_DIR/include/tensorflow/lite;
cp "tensorflow/tensorflow/lite/c/common.h" $PACKAGE_DIR/include/tensorflow/lite;
cp "tensorflow/tensorflow/lite/builtin_ops.h" $PACKAGE_DIR/include/tensorflow/lite;
# When using wildcards with bash, we cannot use quotes
cp tensorflow/tensorflow/lite/core/c/*.h $PACKAGE_DIR/include/tensorflow/lite/core/c;
cp tensorflow/tensorflow/lite/core/async/c/*.h $PACKAGE_DIR/include/tensorflow/lite/core/async/c;

if [[ "$OS_TYPE" == "Linux" ]]; then
    cp "tflite_build/libtensorflowlite_c.so" $PACKAGE_DIR/lib;
elif [[ "$OS_TYPE" == "Darwin" ]]; then
    cp "tflite_build/libtensorflowlite_c.dylib" $PACKAGE_DIR/lib;
elif [[ "$OS_TYPE" == "Windows" ]]; then
    cp "tflite_build/$BUILD_TYPE/tensorflowlite_c.dll" $PACKAGE_DIR/lib;
    cp "tflite_build/$BUILD_TYPE/tensorflowlite_c.exp" $PACKAGE_DIR/lib;
    cp "tflite_build/$BUILD_TYPE/tensorflowlite_c.lib" $PACKAGE_DIR/lib;
else
    echo "Unknown OS: $OS_TYPE"
    exit 1
fi