#!/bin/bash
set -e

# Parametre olarak sürüm al (örnek: 22.1 veya v22.1.0), verilmezse varsayılan v24.11.1 kullan
RAW_VERSION="${1:-v24.11.1}"
CLEAN_VERSION="${RAW_VERSION#v}"
VERSION="v${CLEAN_VERSION}"

sh /app/lib/message.sh light "NODEJS $VERSION"

FILE="node-${VERSION}-linux-x64"
URL="https://nodejs.org/dist/${VERSION}/${FILE}.tar.xz"
INSTALL_DIR="/app/files/node/${VERSION}"

VERSION_NODE_LINK="/app/node${CLEAN_VERSION}"
ACTIVE_NODE_LINK="/app/node"
ACTIVE_NPM_LINK="/app/npm"

echo "📥 Downloading Node.js ${VERSION}..."
curl -fsSL "$URL" -o node.tar.xz

echo "📦 Extracting to ${INSTALL_DIR}..."
rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
tar -xf node.tar.xz -C "$INSTALL_DIR" --strip-components=1

echo "🧹 Cleaning downloaded file..."
rm -f node.tar.xz

# Kurulan paketten gerçek npm sürümünü al (PATH'e yeni node bin dizinini ekleyerek)
NPM_VERSION="$(PATH="${INSTALL_DIR}/bin:$PATH" "${INSTALL_DIR}/bin/npm" -v)"
VERSION_NPM_LINK="/app/npm${NPM_VERSION}"

echo "🔗 Creating symlinks..."
ln -sf "${INSTALL_DIR}/bin/node" "$VERSION_NODE_LINK"
ln -sf "${INSTALL_DIR}/bin/npm" "$VERSION_NPM_LINK"
ln -sf "${INSTALL_DIR}/bin/node" "$ACTIVE_NODE_LINK"
ln -sf "${INSTALL_DIR}/bin/npm" "$ACTIVE_NPM_LINK"
ln -sf "$ACTIVE_NODE_LINK" /usr/local/bin/node
ln -sf "$ACTIVE_NPM_LINK" /usr/local/bin/npm

echo "✅ Node installation completed!"
echo "Node version : $("$ACTIVE_NODE_LINK" -v)"
echo "NPM version  : ${NPM_VERSION}"
echo "Node link    : ${VERSION_NODE_LINK} -> ${ACTIVE_NODE_LINK}"
echo "NPM link     : ${VERSION_NPM_LINK} -> ${ACTIVE_NPM_LINK}"
