# tflite-c-lib

## How to build

```bash
# Optional
chown -R $USER:$USER /path/to/tflite-c-lib
cd tensorflow
git checkout #tag
git submodule update --init --recursive
```

Follow [this guide](https://github.com/tensorflow/tensorflow/blob/master/tensorflow/lite/g3doc/guide/build_cmake.md) to build the tensorflow c library.

If building the tflite lib for armv7l add the following flags to the cmake command:

```bash
-DTFLITE_ENABLE_XNNPACK=OFF
```

Full commands:

```bash
mkdir tflite_build
cd tflite_build
cmake ../tensorflow/tensorflow/lite/c -DCMAKE_BUILD_TYPE=Release -DTFLITE_ENABLE_XNNPACK=OFF
cmake --build . --config Release -j 4
```

> Note: The headers that need to be included are in a little different path than mentioned in the guide.

Use the script `package-tflite.sh` to package the tflite library and headers.

```bash
./package-tflite.sh
```
