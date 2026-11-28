package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"
)

func main() {
	
	port := argument("port","0")
	if(port=="0"){
		log.Fatalf("[X] port=80 şeklinde port ataması yapınız!")	
		return
	}
	
	// Aktif çalışma klasörünü al
	currentDir, err := os.Getwd()
	if err != nil {
		log.Fatalf("[X] Klasör yolu alınamadı: %v", err)
	}

	// Dosya sunucusu handler'ı oluştur
	fileServer := http.FileServer(http.Dir(currentDir))

	// İstekleri loglayan ve ön bellekleme (caching) header'larını engelleyen middleware
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		// Ön bellekleme yapılmasın (No-Cache header'ları)
		w.Header().Set("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0")
		w.Header().Set("Pragma", "no-cache")
		w.Header().Set("Expires", "0")

		// İsteği konsola logla (Method, URL ve İstemci IP)
		fmt.Printf("[%s] %s - %s\n", r.Method, r.RemoteAddr, r.URL.Path)

		// Dosyayı sun (net/http içeride otomatik olarak MIME türlerini belirler)
		fileServer.ServeHTTP(w, r)
	})

	addr := ":" + port
	fmt.Printf("[+] Sunucu başlatıldı: http://localhost:%s\n", addr)
	fmt.Printf("[+] Sunulan klasör: %s\n", currentDir)
	fmt.Printf("[+] Çıkış için CTRL+C tuşlarına basın.\n")

	// Sunucuyu başlat
	if err := http.ListenAndServe(addr, nil); err != nil {
		log.Fatalf("[X] Sunucu başlatılamadı: %v", err)
	}
}



func argument(key string, defaults ...string) string {
	response := ""
	for _, arg := range os.Args {
		if strings.HasPrefix(arg, key+"=") {
			response = strings.SplitN(arg, "=", 2)[1]
			response = strings.Trim(response, "\"")
			return response
		}
	}
	if len(defaults) > 0 {
		return defaults[0]
	}
	return ""
}
