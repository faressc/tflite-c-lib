# tflite-c-lib

## How to build

Follow [this guide](https://github.com/tensorflow/tensorflow/blob/master/tensorflow/lite/g3doc/guide/build_cmake.md) to build the tensorflow c library.

If building the tflite lib for armv7l add the following flags to the cmake command:

```bash
-DTFLITE_ENABLE_XNNPACK=OFF
```

> Note: The headers that need to be included are in a little different path than mentioned in the guide. Have a look at the github workflow file to see how to include the headers.