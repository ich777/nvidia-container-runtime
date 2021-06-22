# Create necessary directories and clone repository
mkdir -p ${DATA_DIR}/go/src/github.com/NVIDIA
cd ${DATA_DIR}/go/src/github.com/NVIDIA
git clone https://github.com/NVIDIA/nvidia-container-runtime.git
cd ${DATA_DIR}/go/src/github.com/NVIDIA/nvidia-container-runtime
git checkout v$LAT_V
export GOPATH=${DATA_DIR}/go

# Compile nvidia-container-runtime
if make build ; then
	:
else
	echo "---Can't compile nvidia-container-runtime---"
	rm -R ${DATA_DIR}/go
	exit 0
fi
unset GOPATH

# Move nvidia-container-runtime to destination
mkdir -p ${DATA_DIR}/nvidia-container-runtime-$LAT_V/usr/bin
cp ${DATA_DIR}/go/src/github.com/NVIDIA/nvidia-container-runtime/nvidia-container-runtime ${DATA_DIR}/nvidia-container-runtime-$LAT_V/usr/bin/
cd ${DATA_DIR}/nvidia-container-runtime-$LAT_V
mkdir ${DATA_DIR}/v$LAT_V

# Create archive
tar cfvz ${DATA_DIR}/v$LAT_V/nvidia-container-runtime-v$LAT_V.tar.gz *
