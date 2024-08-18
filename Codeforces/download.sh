#!/bin/bash
# Kullanıcı ajanı tanımla
USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"

# İstek URL'sini al
URL=$1
URL=$(echo "$URL" | sed 's/Codeforces//g')
# Klasör adı oluştur ve yerel dosya yolunu belirle
FOLDER_NAME=$(echo "$URL")  # URL'deki geçersiz karakterleri değiştirir
LOCAL_DIR="/Applications/XAMPP/xamppfiles/htdocs/Codeforces/$FOLDER_NAME"
LOCAL_FILE="/$LOCAL_DIR/index.html"

# Dizini kontrol et ve oluştur
if [ ! -d "$LOCAL_DIR" ]; then
    mkdir -p "$LOCAL_DIR"
fi

# Dosyayı indir
echo $URL
/usr/local/bin/wget --quiet --header="User-Agent: $USER_AGENT" --output-document="$LOCAL_FILE" "https://codeforces.com/$URL"
