#!/bin/bash
# Kullanıcı ajanı tanımla
if [[ "$(ping -c 1 8.8.8.8 | grep '100% packet loss' )" != "" ]]; then
    echo "Internet isn't present"
    exit 1
fi

USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"

# İstek URL'sini al
URL=$1
URL=${URL%/}
URL=${URL%?mobile=true}
URL=${URL%/}
URL=$(echo "$URL" | sed 's/Codeforces//g')

# Dosya uzantısını belirle
FILE_EXT="${URL##*.}"
echo $FILE_EXT
# Yerel dosya ve dizin adlarını belirle
if [[ "$FILE_EXT" == "ico" || "$FILE_EXT" == "js" || "$FILE_EXT" == "json" || "$FILE_EXT" == "css" || "$FILE_EXT" == "png" || "$FILE_EXT" == "jpg" ]]; then
    # Eğer dosya bir uzantı içeriyorsa, URL ile aynı adla kaydet
    LOCAL_FILE="/Applications/XAMPP/xamppfiles/htdocs/Codeforces/$URL"
    LOCAL_DIR=$(dirname "$LOCAL_FILE")
else
    # Eğer dosya bir uzantı içermiyorsa, index.html olarak kaydet
    FOLDER_NAME=$(echo "$URL")
    LOCAL_DIR="/Applications/XAMPP/xamppfiles/htdocs/Codeforces/$FOLDER_NAME"
    LOCAL_FILE="$LOCAL_DIR/index.html"
fi

# Dizini kontrol et ve oluştur
if [ ! -d "$LOCAL_DIR" ]; then
    mkdir -p "$LOCAL_DIR"
fi

# Dosyayı indir
echo $URL
/usr/local/bin/wget --quiet --header="User-Agent: $USER_AGENT" --output-document="$LOCAL_FILE" "https://codeforces.com/$URL"

