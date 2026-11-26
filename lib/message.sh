#!/bin/sh

# Kullanım:
# sh /app/lib/message.sh info "CERTBOT SSL"
# sh /app/lib/message.sh success "İşlem Başarıyla Tamamlandı"
# sh /app/lib/message.sh alert "Bir Hata Oluştu"
# sh /app/lib/message.sh light "Dikkat Edilmesi Gereken Bilgi"
# veya tek parametreyle (varsayılan info):
# sh /app/lib/message.sh "Deneme Naber"

if [ $# -eq 1 ]; then
    TUR="info"
    METIN="$1"
else
    TUR="$1"
    shift
    METIN="$*"
fi

if [ -z "$METIN" ]; then
    exit 0
fi

case "$TUR" in
    success)
        RENK="\033[1;32m"
        ;;
    alert|error)
        RENK="\033[1;31m"
        ;;
    warning|warn|light)
        RENK="\033[1;33m"
        ;;
    info|*)
        RENK="\033[1;94m"
        ;;
esac

# Karakter sayısını doğru hesapla (Türkçe karakterler dahil)
UZUNLUK=$(printf "%s" "$METIN" | wc -m | tr -d ' ')

if [ "$UZUNLUK" -lt 43 ]; then
    GENISLIK=43
else
    GENISLIK=$((UZUNLUK + 4))
fi

SOL_BOSLUK=$(( (GENISLIK - UZUNLUK) / 2 ))
SAG_BOSLUK=$(( GENISLIK - UZUNLUK - SOL_BOSLUK ))

# Üst ve alt çizgileri oluştur
CIZGI=$(awk -v n="$GENISLIK" 'BEGIN { for (i=0; i<n; i++) printf "═" }')
SOL=$(awk -v n="$SOL_BOSLUK" 'BEGIN { for (i=0; i<n; i++) printf " " }')
SAG=$(awk -v n="$SAG_BOSLUK" 'BEGIN { for (i=0; i<n; i++) printf " " }')

printf "%b" "$RENK"
printf "╔%s╗\n" "$CIZGI"
printf "║%s%s%s║\n" "$SOL" "$METIN" "$SAG"
printf "╚%s╝\n" "$CIZGI"
printf "\033[0m"
