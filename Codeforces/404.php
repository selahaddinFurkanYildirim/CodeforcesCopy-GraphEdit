<?php
// İstenen URL'yi al
$request_uri = $_SERVER['REQUEST_URI'];
// Dosya adını ayıkla
$request_uri = str_replace("/Codeforces/", "/", $request_uri);
$requested_file = $_SERVER['DOCUMENT_ROOT'] ."/Codeforces/".  $request_uri;

// Eğer dosya varsa, onu göster
if (file_exists($requested_file)) {
    // Dosya mevcutsa, onu normal şekilde sun
    $mime_type = mime_content_type($requested_file."/index.html");
    header("Content-Type: $mime_type");
    
    // Dosyayı göster
    include $requested_file."/index.html";
    exit; // İşlem tamam, devam etmeye gerek yok
}
echo $requested_file;
echo "<br>";
$requestedUrl = $_SERVER['REQUEST_URI'];
$baseUrl = "https://codeforces.com";
// Shell script'i çalıştır
$scriptPath = './download.sh'; // Shell script'in tam yolu
$command = "$scriptPath \"/$requestedUrl/\"";
exec($command, $output, $return_var);
if ($return_var !== 0) {
    echo $command;
    echo "<br>Shell script'i çalıştırılırken bir hata oluştu. Çıkış kodu: $return_var";
    exit;
}

// Yerel dosya yolunu oluştur
$localDir = __DIR__ . '/' ;
$localFilePath = $localDir . '/index.html';
header("Refresh:0");
?>
