import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' as math;

import '../theme/theme_provider.dart';
import '../models/spot_model.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Data dummy awal spots
  final List<Spot> _allSpots = [
    Spot(
        id: 1,
        name: "Starbucks Coffee",
        type: "Kafe",
        lat: -6.200000,
        lon: 106.810000,
        description:
            "Kafe populer dengan kopi berkualitas tinggi dan suasana nyaman untuk bekerja atau bersantai."),
    Spot(
        id: 2,
        name: "Rumah Sakit Atma Jaya",
        type: "Rumah Sakit",
        lat: -6.210000,
        lon: 106.820000,
        description:
            "Rumah sakit terkemuka dengan layanan medis lengkap dan profesional yang berpengalaman."),
    Spot(
        id: 3,
        name: "Masjid Agung Al-Muhajirin",
        type: "Tempat Ibadah",
        lat: -6.195000,
        lon: 106.825000,
        description:
            "Masjid yang menyatu dengan sekolah, tempat ibadah yang tenang dan nyaman untuk berdoa."),
    Spot(
        id: 4,
        name: "SEDERHANA Restoran",
        type: "Restoran",
        lat: -6.205000,
        lon: 106.815000,
        description:
            "Restoran khas Indonesia dengan menu masakan Padang yang lezat dan harga terjangkau."),
    Spot(
        id: 5,
        name: "Gramedia Bookstore",
        type: "Toko Buku",
        lat: -6.190000,
        lon: 106.800000,
        description:
            "Toko buku terbesar di Indonesia dengan koleksi buku lengkap dari berbagai genre."),
  ];

  List<Spot> _displayedSpots = [];
  String _userCoordinates = "- Belum Diketahui -";
  String _locationStatus = "- Klik tombol untuk mencari -";
  bool _isLoadingLocation = false;
  Position? _currentUserPosition;

  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  LatLng _initialCameraPosition =
      const LatLng(-6.2088, 106.8456); // Default posisi Jakarta

  @override
  void initState() {
    super.initState();
    _displayedSpots = [];
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  // Format jarak ke string yang mudah dibaca
  String _formatDistance(double distanceKm) {
    if (distanceKm < 1) {
      return "${(distanceKm * 1000).round()}m";
    }
    return "${distanceKm.toStringAsFixed(1)} km";
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_currentUserPosition != null) {
      _animateCameraToPosition(
          LatLng(
              _currentUserPosition!.latitude, _currentUserPosition!.longitude),
          15);
    }
  }

  void _animateCameraToPosition(LatLng position, double zoom) {
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(position, zoom),
    );
  }

  void _clearMarkers() {
    if (!mounted) return;
    setState(() {
      _markers.clear();
    });
  }

  void _addMarkersToMap(Position userPosition, List<Spot> spots) {
    if (!mounted) return;
    _clearMarkers();

    // Marker lokasi pengguna
    final userLatLng = LatLng(userPosition.latitude, userPosition.longitude);
    _markers.add(
      Marker(
        markerId: const MarkerId('userLocation'),
        position: userLatLng,
        infoWindow: const InfoWindow(title: 'Lokasi Anda'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    );

    // Marker spot
    for (var spot in spots) {
      final spotLatLng = LatLng(spot.lat, spot.lon);
      _markers.add(
        Marker(
          markerId: MarkerId(spot.id.toString()),
          position: spotLatLng,
          infoWindow: InfoWindow(
            title: spot.name,
            snippet: '${spot.type} - ${spot.distanceDisplay ?? ""}',
            onTap: () => _navigateToDetail(spot, context),
          ),
          onTap: () {
            // Optional debug print
            print("Marker ${spot.name} di peta diklik.");
            _animateCameraToPosition(spotLatLng, 16);
          },
        ),
      );
    }

    setState(() {}); // Refresh UI untuk marker baru
  }

  void _fitMapToMarkers() {
    if (_markers.isEmpty || _mapController == null) return;

    if (_markers.length == 1) {
      _animateCameraToPosition(_markers.first.position, 16);
      return;
    }

    double minLat = _markers.first.position.latitude;
    double maxLat = _markers.first.position.latitude;
    double minLng = _markers.first.position.longitude;
    double maxLng = _markers.first.position.longitude;

    for (var marker in _markers) {
      minLat = math.min(minLat, marker.position.latitude);
      maxLat = math.max(maxLat, marker.position.latitude);
      minLng = math.min(minLng, marker.position.longitude);
      maxLng = math.max(maxLng, marker.position.longitude);
    }

    final bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 60.0));
  }

  Future<void> _determinePositionAndFindSpots() async {
    bool serviceEnabled;
    LocationPermission permission;

    setState(() {
      _isLoadingLocation = true;
      _locationStatus = "Memeriksa layanan lokasi...";
      _userCoordinates = "- Mencari... -";
      _displayedSpots = [];
      _clearMarkers();
    });

    // Cek layanan lokasi aktif
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!mounted) return;
      setState(() {
        _locationStatus = 'Layanan lokasi tidak aktif. Harap aktifkan.';
        _isLoadingLocation = false;
      });
      return;
    }

    // Cek permission lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (!mounted) return;
        setState(() {
          _locationStatus = 'Izin lokasi ditolak oleh pengguna.';
          _isLoadingLocation = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (!mounted) return;
      setState(() {
        _locationStatus =
            'Izin lokasi ditolak permanen. Harap aktifkan dari pengaturan aplikasi.';
        _isLoadingLocation = false;
      });
      return;
    }

    if (!mounted) return;
    setState(() {
      _locationStatus = "Mendapatkan lokasi Anda...";
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      _currentUserPosition = position;

      if (!mounted) return;
      setState(() {
        _userCoordinates =
            "Lat: ${position.latitude.toStringAsFixed(6)}, Lon: ${position.longitude.toStringAsFixed(6)}";
        _locationStatus = "Lokasi berhasil ditemukan!";
        _initialCameraPosition = LatLng(position.latitude, position.longitude);

        // Hitung jarak setiap spot dari lokasi user
        _displayedSpots = _allSpots.map((spot) {
          double distanceInKm = Geolocator.distanceBetween(
                  position.latitude, position.longitude, spot.lat, spot.lon) /
              1000;
          return Spot(
            id: spot.id,
            name: spot.name,
            type: spot.type,
            lat: spot.lat,
            lon: spot.lon,
            description: spot.description,
            distanceDisplay: _formatDistance(distanceInKm),
          );
        }).toList();

        // Urutkan spot berdasarkan jarak terdekat
        _displayedSpots.sort((a, b) {
          double extractNumericDistance(String? distStr) {
            if (distStr == null || distStr == "~") return double.infinity;
            double val =
                double.tryParse(distStr.replaceAll(RegExp(r'[^0-9.]'), '')) ??
                    double.infinity;
            if (distStr.contains('m')) val /= 1000;
            return val;
          }

          return extractNumericDistance(a.distanceDisplay)
              .compareTo(extractNumericDistance(b.distanceDisplay));
        });

        // Tambah marker dan sesuaikan kamera peta
        _addMarkersToMap(position, _displayedSpots);
        _fitMapToMarkers();

        _isLoadingLocation = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _locationStatus = "Gagal mendapatkan lokasi.";
        _userCoordinates = "- Error -";
        _isLoadingLocation = false;
        _displayedSpots = [];
        _clearMarkers();
      });
    }
  }

  void _navigateToDetail(Spot spot, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailScreen(spot: spot)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Found YA!!"),
        actions: [
          IconButton(
            icon: Icon(
                theme.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () {
              theme.toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Text("Koordinat Anda: $_userCoordinates"),
                ),
                ElevatedButton(
                  onPressed: _isLoadingLocation
                      ? null
                      : _determinePositionAndFindSpots,
                  child: _isLoadingLocation
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Cari Lokasi"),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.centerLeft,
            child: Text("Status: $_locationStatus"),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition:
                  CameraPosition(target: _initialCameraPosition, zoom: 13),
              markers: _markers,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
            ),
          ),
          Container(
            height: 180,
            padding: const EdgeInsets.all(8),
            child: _displayedSpots.isEmpty
                ? const Center(
                    child: Text("Tidak ada tempat yang ditampilkan."))
                : ListView.builder(
                    itemCount: _displayedSpots.length,
                    itemBuilder: (context, index) {
                      final spot = _displayedSpots[index];
                      return Card(
                        child: ListTile(
                          title: Text(spot.name),
                          subtitle: Text(
                              "${spot.type} • ${spot.distanceDisplay ?? '~'}"),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () => _navigateToDetail(spot, context),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
