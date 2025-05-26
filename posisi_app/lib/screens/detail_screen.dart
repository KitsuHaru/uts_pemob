import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Untuk tombol tema
import '../models/spot_model.dart'; // Impor model Spot
import '../theme/theme_provider.dart'; // Untuk tombol tema

class DetailScreen extends StatelessWidget {
  final Spot spot; // Menerima objek Spot sebagai argumen

  const DetailScreen({
    super.key,
    required this.spot, // spot wajib diisi saat membuat DetailScreen
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        // Tombol kembali ('back button') akan otomatis ditambahkan oleh Flutter
        // karena kita menggunakan Navigator.push() untuk sampai ke halaman ini.
        // Namun, kita bisa menambahkannya secara eksplisit jika mau:
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        title: Text(spot.name), // Judul AppBar adalah nama tempat
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            ),
            onPressed: () {
              themeProvider.switchTheme();
            },
            tooltip:
                isDarkMode ? 'Aktifkan Mode Terang' : 'Aktifkan Mode Gelap',
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Agar konten bisa di-scroll jika deskripsinya panjang
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Semua teks rata kiri
          children: [
            // Nama Tempat sebagai Judul Utama Halaman
            Text(
              spot.name,
              style: textTheme.headlineSmall?.copyWith(
                fontSize: 28, // Ukuran lebih besar untuk judul utama
                fontWeight: FontWeight.bold,
                color: colorScheme.primary, // Menggunakan warna primer tema
              ),
            ),
            const SizedBox(height: 16),

            // Di sini bisa ditambahkan peta kecil spesifik untuk lokasi spot (Fitur Google Maps nanti)
            // Container(
            //   height: 200,
            //   decoration: BoxDecoration(
            //     color: Theme.of(context).colorScheme.surfaceVariant, // Warna placeholder
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   alignment: Alignment.center,
            //   margin: const EdgeInsets.only(bottom: 16),
            //   child: Text('Peta untuk ${spot.name} akan di sini', style: textTheme.bodySmall),
            // ),

            _buildDetailRow(context, "Jenis Tempat:", spot.type),
            if (spot.distanceDisplay != null && spot.distanceDisplay != "~")
              _buildDetailRow(
                  context, "Perkiraan Jarak:", spot.distanceDisplay!),

            const SizedBox(height: 12),
            Text(
              'Deskripsi:',
              style: textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                // color: textTheme.bodyMedium?.color?.withOpacity(0.8) // Disesuaikan dengan textTheme
              ),
            ),
            const SizedBox(height: 6),
            Text(
              spot.description,
              style: textTheme.bodyLarge?.copyWith(
                height: 1.5, // Spasi antar baris untuk keterbacaan
              ),
              textAlign: TextAlign.justify, // Deskripsi rata kiri-kanan
            ),
            const SizedBox(height: 24),

            // Contoh tombol aksi lain jika ada
            // Center( // Agar tombol di tengah jika hanya satu
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Misalnya, buka di aplikasi peta eksternal
            //       // Anda perlu plugin seperti url_launcher untuk ini
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(content: Text('Membuka di peta eksternal (belum diimplementasikan)')),
            //       );
            //     },
            //     style: ElevatedButton.styleFrom(
            //       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            //     ),
            //     child: const Text('Lihat di Peta Eksternal'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // Widget helper untuk membuat baris detail (Label: Value)
  Widget _buildDetailRow(BuildContext context, String label, String value) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textTheme.titleMedium?.copyWith(
                // Menggunakan titleMedium untuk label
                fontWeight: FontWeight.bold,
                color: textTheme.bodyMedium?.color?.withOpacity(0.7)),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: textTheme.bodyLarge?.copyWith(fontSize: 17),
          ),
          const Divider(height: 16, thickness: 0.5), // Garis pemisah tipis
        ],
      ),
    );
  }
}
