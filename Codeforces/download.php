<?php
// download.php

// İstek URL'sini al

//$requestedUrl = str_replace("Codeforces", "", $_SERVER['REQUEST_URI']);
$requestedUrl = $_SERVER['REQUEST_URI'];
$baseUrl = "https://codeforces.com";
// Shell script'i çalıştır
$scriptPath = './download.sh'; // Shell script'in tam yolu
$command = "$scriptPath /$requestedUrl/";
exec($command, $output, $return_var);

if ($return_var !== 0) {
    echo $command;
    echo "<br>Shell script'i çalıştırılırken bir hata oluştu. Çıkış kodu: $return_var";
    exit;
}

// Yerel dosya yolunu oluştur
$localDir = __DIR__ . '/' ;
$localFilePath = $localDir . '/index.html';

// Yerel dosyayı kontrol et ve göster
if (file_exists($localFilePath)) {
    header("Location: $requestedUrl");
} else {
    echo "Yerel dosya bulunamadı: $localFilePath";
}
?>
