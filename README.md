# Posisi App - Nearby Spot Finder

Aplikasi Flutter sederhana untuk menemukan tempat menarik terdekat (kafe, taman, tempat ibadah, dll.) berdasarkan lokasi pengguna saat ini. Aplikasi ini mendukung mode tema terang dan gelap serta menampilkan lokasi di peta interaktif.

Proyek ini dikembangkan sebagai bagian dari [Nama Mata Kuliah/Tugas, jika relevan] di [Nama Institusi Anda, jika relevan].

## Daftar Isi
- [Fitur Utama](#fitur-utama)
- [Teknologi yang Digunakan](#teknologi-yang-digunakan)
- [Setup Proyek](#setup-proyek)
- [Prasyarat](#prasyarat)
- [Konfigurasi API Key](#konfigurasi-api-key)
- [Langkah Instalasi](#langkah-instalasi)
- [Struktur Proyek](#struktur-proyek)
- [Tantangan dan Pembelajaran](#tantangan-dan-pembelajaran)
- [Pengembangan Selanjutnya)](#pengembangan-selanjutnya)
- [Kontributor](#kontributor)

## Fitur Utama

* **Loading Screen Animasi:** Tampilan awal aplikasi dengan animasi logo yang menarik dan efek cipratan.
* **Desain Tematik:**
    * Dukungan mode tema **Terang** dan **Gelap**.
    * Preferensi tema disimpan menggunakan `shared_preferences`.
    * Konsistensi gaya visual antar halaman.
* **Layanan Berbasis Lokasi (LBS):**
    * Deteksi lokasi pengguna secara real-time menggunakan plugin `geolocator`.
    * Menampilkan koordinat (lintang dan bujur) pengguna.
    * Mengambil daftar tempat terdekat menggunakan **Google Places API** (Nearby Search).
    * Menghitung dan menampilkan jarak ke setiap tempat.
    * Mengurutkan daftar tempat berdasarkan jarak terdekat.
* **Tampilan Peta Interaktif:**
    * Integrasi `google_maps_flutter` untuk menampilkan peta.
    * Marker untuk lokasi pengguna dan tempat-tempat yang ditemukan.
    * InfoWindow pada marker untuk detail singkat dan navigasi.
    * Peta menyesuaikan zoom dan posisi untuk menampilkan semua marker relevan.
* **Navigasi Halaman:**
    * Navigasi dari daftar tempat ke halaman detail informasi tempat.
* **User Interface (UI) yang Jelas:**
    * Layout yang intuitif dengan indikator loading dan pesan status.

## Teknologi yang Digunakan

* **Flutter SDK** (Versi: [Sebutkan versi Flutter Anda, misal 3.19.x])
* **Dart** (Versi: [Sebutkan versi Dart Anda, misal 3.x.x])
* **Plugin Flutter Utama:**
    * `provider` (untuk manajemen state tema)
    * `shared_preferences` (untuk menyimpan preferensi tema)
    * `geolocator` (untuk LBS)
    * `google_maps_flutter` (untuk integrasi peta)
    * `http` (untuk membuat permintaan ke Google Places API)
* **API Eksternal:**
    * Google Places API (Nearby Search)
* **Font Kustom:**
    * Bebas Neue
    * Roboto

## Setup Proyek

Berikut adalah langkah-langkah untuk menjalankan proyek ini di lingkungan lokal Anda.

### Prasyarat

* Flutter SDK (Versi [Sebutkan versi Flutter Anda]) terinstal.
* Emulator Android atau iOS, atau perangkat fisik.
* Konfigurasi lingkungan pengembangan Flutter yang valid (cek dengan `flutter doctor`).

### Konfigurasi API Key

Aplikasi ini menggunakan Google Maps Platform (Maps SDK for Android, Maps SDK for iOS, dan Places API). Anda **WAJIB** memiliki API Key Google Maps yang valid.

1.  Buka [Google Cloud Console](https://console.cloud.google.com/).
2.  Buat atau pilih proyek.
3.  Aktifkan API berikut untuk proyek Anda:
    * **Maps SDK for Android**
    * **Maps SDK for iOS**
    * **Places API**
4.  Buat API Key baru di bagian "Credentials".
5.  **PENTING:** Batasi API Key Anda untuk API yang disebutkan di atas dan (jika untuk produksi) untuk aplikasi spesifik Anda.
6.  Masukkan API Key Anda ke dalam file konfigurasi berikut:
    * **Android:** `android/app/src/main/AndroidManifest.xml`
        ```xml
        <application ...>
            <meta-data android:name="com.google.android.geo.API_KEY"
                       android:value="MASUKKAN_API_KEY_ANDROID_ANDA_DI_SINI"/>
            ...
        </application>
        ```
    * **iOS:** `ios/Runner/AppDelegate.swift` (atau `AppDelegate.m`)
        ```swift
        // Di dalam application(_:didFinishLaunchingWithOptions:)
        GMSServices.provideAPIKey("MASUKKAN_API_KEY_IOS_ANDA_DI_SINI")
        ```
    * **Di kode Dart (untuk Places API):**
        Di file `lib/services/places_service.dart` (atau di `home_screen.dart` jika Anda meletakkannya di sana), ganti placeholder API Key:
        ```dart
        // Ganti dengan API Key Anda yang valid
        final String _googleApiKey = "MASUKKAN_API_KEY_PLACES_ANDA_DI_SINI";
        ```
        *(Catatan: Untuk keamanan yang lebih baik di aplikasi produksi, API Key sebaiknya tidak di-hardcode di Dart.)*

### Langkah Instalasi

1.  **Clone repositori ini:**
    ```bash
    git clone [https://github.com/EskelandLab/ANDA](https://github.com/EskelandLab/ANDA)
    cd [nama-folder-repositori]
    ```
2.  **Pastikan semua aset ada:**
    * Logo di `assets/images/Logo_posisi.png` (atau sesuai path di `pubspec.yaml`).
    * File font (`.ttf`) di `assets/fonts/`.
3.  **Ambil dependensi Flutter:**
    ```bash
    flutter pub get
    ```
4.  **Jalankan aplikasi:**
    ```bash
    flutter run
    ```
    Pastikan emulator atau perangkat fisik sudah berjalan dan terdeteksi oleh Flutter.

## Struktur Proyek

* `lib/main.dart`: Titik masuk utama aplikasi.
* `lib/models/`: Berisi model data (misalnya, `spot_model.dart`).
* `lib/screens/`: Berisi widget untuk setiap halaman (misalnya, `loading_screen.dart`, `home_screen.dart`, `detail_screen.dart`).
* `lib/services/`: Berisi logika untuk layanan eksternal (misalnya, `places_service.dart`, `location_service.dart` jika dibuat terpisah).
* `lib/theme/`: Berisi konfigurasi tema aplikasi (`app_themes.dart`, `theme_provider.dart`).
* `lib/widgets/`: Berisi widget kustom yang bisa digunakan ulang.

## Tantangan dan Pembelajaran

* Mengintegrasikan beberapa plugin Flutter seperti `geolocator` dan `google_maps_flutter` memerlukan konfigurasi native yang teliti untuk izin dan API Key.
* Manajemen state untuk tema dinamis dan data asinkron dari API diimplementasikan menggunakan `Provider` dan `setState`.
* Membuat animasi loading screen yang menarik di Flutter menggunakan `AnimationController` dan `TweenSequence`.
* Parsing data JSON dari Google Places API dan mengubahnya menjadi model data Dart yang terstruktur.
* Menangani berbagai status dan error dari layanan lokasi dan permintaan API untuk memberikan pengalaman pengguna yang lebih baik.

## Pengembangan Selanjutnya

* Filter tempat berdasarkan kategori yang lebih banyak.
* Fitur pencarian manual berdasarkan nama tempat.
* Implementasi peta detail di halaman detail spot dengan marker spesifik.
* Menambahkan ulasan atau rating tempat (jika API mendukung).
* Caching data untuk penggunaan offline atau mengurangi panggilan API.

## Kontributor

* [Ramdani - Bagus]
* [Fakultas Ilmu Komputer - Jurusan Teknik Informatika]

---
