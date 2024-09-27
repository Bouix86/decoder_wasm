echo "Beginning Build:"
rm -r ffmpeg
mkdir -p ffmpeg
cd ../ffmpeg_wasm
make clean
emconfigure ./configure --cc="emcc" --cxx="em++" --ar="emar" --prefix=$(pwd)/../decoder_wasm/ffmpeg --enable-cross-compile --target-os=none --arch=x86_32 --cpu=generic \
    --enable-gpl --enable-version3 --disable-avdevice --disable-avformat --disable-swresample --disable-postproc --disable-avfilter \
    --disable-programs --disable-logging --disable-everything \
    --disable-ffplay --disable-ffprobe --disable-asm --disable-doc --disable-devices --disable-network \
    --disable-hwaccels --disable-parsers --disable-bsfs --disable-debug --disable-protocols --disable-indevs --disable-outdevs \
    --enable-decoder=h264  --enable-parser=h264
make -j${THREAD}
make install
cd ../decoder_wasm
cp -r include_wasm_for_h2645/* ffmpeg/include/
./build_decoder_wasm.sh 264
