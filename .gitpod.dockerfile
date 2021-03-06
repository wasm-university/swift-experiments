FROM gitpod/workspace-full

RUN sudo apt-get update && \
    sudo apt-get install gettext libncurses5 libxkbcommon0 libtinfo5 -y

# Ubuntu 20.04 (Swift)
# https://book.swiftwasm.org/getting-started/setup.html
RUN sudo apt-get install gnupg2 libpython2.7 libz3-dev -y


USER gitpod

RUN brew tap suborbital/subo && \
    brew install subo && \
    brew install swift && \
    brew install swiftwasm/tap/carton

# ------------------------------------
# Install Swift Wasm support
# ------------------------------------
ARG SWIFT_WASM_VERSION="5.6.0"
ARG SWIFT_WASM_PLATFORM="ubuntu20.04_x86_64"
ARG SWIFT_WASM_HOME="swift-wasm-5.6.0-RELEASE"

RUN wget https://github.com/swiftwasm/swift/releases/download/swift-wasm-${SWIFT_WASM_VERSION}-RELEASE/swift-wasm-${SWIFT_WASM_VERSION}-RELEASE-${SWIFT_WASM_PLATFORM}.tar.gz && \
    tar xzf swift-wasm-${SWIFT_WASM_VERSION}-RELEASE-${SWIFT_WASM_PLATFORM}.tar.gz && \
    rm swift-wasm-${SWIFT_WASM_VERSION}-RELEASE-${SWIFT_WASM_PLATFORM}.tar.gz

ENV PATH="$PATH:/home/gitpod/${SWIFT_WASM_HOME}/usr/bin"


# ------------------------------------
# Install Wasi Runtimes
# ------------------------------------
RUN curl -sSf https://raw.githubusercontent.com/WasmEdge/WasmEdge/master/utils/install.sh | bash -s -- -v 0.10.0 && \
    curl https://get.wasmer.io -sSfL | sh && \
    curl https://wasmtime.dev/install.sh -sSf | bash
