FROM gitpod/workspace-full

RUN sudo apt-get update && \
    sudo apt-get install gettext libncurses5 libxkbcommon0 libtinfo5 -y

# Ubuntu 20.04 (Swift)
# https://book.swiftwasm.org/getting-started/setup.html
RUN sudo apt-get install gnupg2 libpython2.7 libz3-dev -y


USER gitpod

# ------------------------------------
# Install swift support
# ------------------------------------
ARG SWIFT_WASM_VERSION="5.6.0"
ARG SWIFT_WASM_PLATFORM="ubuntu20.04_x86_64"

RUN wget https://github.com/swiftwasm/swift/releases/download/swift-wasm-${SWIFT_WASM_VERSION}-RELEASE/swift-wasm-${SWIFT_WASM_VERSION}-RELEASE-${SWIFT_WASM_PLATFORM}.tar.gz && \
    tar xzf swift-wasm-${SWIFT_WASM_VERSION}-RELEASE-${SWIFT_WASM_PLATFORM}.tar.gz

#sudo cp -R swift-wasm-${SWIFT_WASM_VERSION}-RELEASE /usr/local/bin/swift
# export PATH=$(pwd)/usr/bin:"${PATH}"

# ------------------------------------
# Install Wasi Runtimes
# ------------------------------------
RUN curl -sSf https://raw.githubusercontent.com/WasmEdge/WasmEdge/master/utils/install.sh | bash -s -- -v 0.10.0 && \
    curl https://get.wasmer.io -sSfL | sh && \
    curl https://wasmtime.dev/install.sh -sSf | bash
