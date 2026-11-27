#!/bin/bash

# Parametre olarak sürüm al, verilmezse varsayılan 1.18 kullan
GO_VERSION="${1:-1.18}"

sh /app/lib/message.sh light "GOLANG $GO_VERSION"

ARCHIVE_NAME="go${GO_VERSION}.linux-amd64.tar.gz"
DOWNLOAD_URL="https://go.dev/dl/${ARCHIVE_NAME}"

# Değişkenler
INSTALL_DIR="/app/files/go/${GO_VERSION}"
LINK_PATH="/app/go${GO_VERSION}"
PROFILE="$HOME/.profile"

# Gerekli paketleri kur
apt update
apt install -y git wget

# Klasörleri oluştur
mkdir -p "/app/files/go"

# İndirme ve Ayıklama
echo "Downloading Go ${GO_VERSION}..."
wget -q --show-progress "${DOWNLOAD_URL}"
if [ $? -ne 0 ]; then
    echo "HATA: Go ${GO_VERSION} indirilemedi. Sürüm numarasını ve bağlantıyı kontrol edin."
    exit 1
fi

echo "Installing to ${INSTALL_DIR}..."
rm -rf "${INSTALL_DIR}"
mkdir -p "${INSTALL_DIR}"
# Tar dosyasının içindeki 'go' klasörünü doğrudan INSTALL_DIR içine çıkarır
tar -xzf "${ARCHIVE_NAME}" --strip-components=1 -C "${INSTALL_DIR}"

# Kısa yol (Symlink) oluşturma
echo "Creating symlink at ${LINK_PATH}..."
rm -f "${LINK_PATH}"
ln -s "${INSTALL_DIR}/bin/go" "${LINK_PATH}"

ln -s "${INSTALL_DIR}/bin/go" "/app/go"

# Geçici dosyayı temizle
rm -f "${ARCHIVE_NAME}"

chmod +x "${LINK_PATH}"
chmod +x "/app/go"

echo "==========================================="
sh /app/lib/message.sh success "Kurulum Tamamlandı go $GO_VERSION"
echo "Sürüm:   ${GO_VERSION}"
echo "Hedef:   ${INSTALL_DIR}"
echo "Kısayol: ${LINK_PATH}"
echo "==========================================="
