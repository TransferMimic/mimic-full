#!/bin/sh

SOURCE_DIR="$PWD/"
BUILD_DIR="$PWD/build/"
INSTALL_DIR="$PWD/install/"

build_component() {
  COMPONENT="$1"
  shift
  echo "${COMPONENT}"
  if [ ! -e "${BUILD_DIR}/${COMPONENT}/meson-private/coredata.dat" ]; then
    mkdir -p "${BUILD_DIR}/${COMPONENT}" && \
    meson "${BUILD_DIR}/${COMPONENT}" "${SOURCE_DIR}/${COMPONENT}" --prefix="${INSTALL_DIR}" "$@" || exit 1
  fi
  ninja -C "${BUILD_DIR}/${COMPONENT}" test install || exit 1
}

# Set pkg-config path:
which dpkg-architecture >/dev/null 2>&1 && export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:${INSTALL_DIR}/lib/"`dpkg-architecture -qDEB_HOST_MULTIARCH`"/pkgconfig"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:${INSTALL_DIR}/lib/pkgconfig"

# Build dependencies: (libpcre2-8)
export WORKDIR="${BUILD_DIR}"
"${SOURCE_DIR}/mimic-core/dependencies.sh" --prefix="${INSTALL_DIR}" || exit 1

# Build mimic components:
build_component "mimic-core" 
build_component "mimic-english" 
build_component "mimic-cmu_us_slt" 
build_component "mimic-full"

