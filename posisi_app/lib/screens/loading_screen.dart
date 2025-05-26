import 'package:flutter/material.dart';
import 'dart:async';
// Untuk rotasi dan efek
import 'home_screen.dart'; // Pastikan file ini ada atau buat placeholder

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  // Ganti ke TickerProviderStateMixin
  late AnimationController _logoController;
  late Animation<double> _logoJumpAnimation;
  late Animation<double> _logoScaleXAnimation; // Untuk squash/stretch X
  late Animation<double> _logoScaleYAnimation; // Untuk squash/stretch Y

  late AnimationController _rippleController;
  late Animation<double> _rippleOpacityAnimation;
  late Animation<double> _rippleWidthAnimation;
  late Animation<double> _rippleHeightAnimation;

  // Durasi dari prototipe HTML
  static const logoAnimationDurationMs = 1400;
  static const rippleAnimationDurationMs = 900;
  static const rippleAnimationDelayMs = 1080;
  static const totalLoadingScreenUIDurationMs = 2200;

  @override
  void initState() {
    super.initState();

    // --- Logo Animation Controller ---
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: logoAnimationDurationMs),
    );

    // Animasi untuk Y-Offset (lompatan)
    _logoJumpAnimation = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 30.0, end: 0.0),
          weight: 20), // 0-20% (muncul)
      TweenSequenceItem(
          tween: ConstantTween<double>(0.0), weight: 10), // 20-30% (diam)
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: -80.0),
          weight: 25), // 30-55% (lompat)
      TweenSequenceItem(
          tween: Tween<double>(begin: -80.0, end: 0.0),
          weight: 25), // 55-80% (jatuh)
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: -10.0),
          weight: 10), // 80-90% (bounce kecil)
      TweenSequenceItem(
          tween: Tween<double>(begin: -10.0, end: 0.0),
          weight: 10), // 90-100% (stabil)
    ]).animate(
        CurvedAnimation(parent: _logoController, curve: Curves.easeInOutSine));

    // Animasi untuk Scale X (Squash & Stretch Horizontal)
    _logoScaleXAnimation = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.7, end: 1.0), weight: 20), // Muncul
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 1.1),
          weight: 5), // Anticipation squash (lebar)
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.1, end: 1.0),
          weight: 5), // Kembali normal
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 0.9),
          weight: 25), // Stretch saat lompat (sempit)
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.9, end: 1.2),
          weight: 12.5), // Landing squash (lebar)
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.2, end: 1.0),
          weight: 12.5), // Kembali normal
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 1.05),
          weight: 5), // Bounce squash
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.05, end: 1.0), weight: 5), // Kembali
      TweenSequenceItem(
          tween: ConstantTween<double>(1.0), weight: 10), // Stabil
    ]).animate(
        CurvedAnimation(parent: _logoController, curve: Curves.easeInOut));

    // Animasi untuk Scale Y (Squash & Stretch Vertikal)
    _logoScaleYAnimation = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.7, end: 1.0), weight: 20), // Muncul
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 0.9),
          weight: 5), // Anticipation squash (pendek)
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.9, end: 1.0),
          weight: 5), // Kembali normal
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 1.1),
          weight: 25), // Stretch saat lompat (tinggi)
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.1, end: 0.8),
          weight: 12.5), // Landing squash (pendek)
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.8, end: 1.0),
          weight: 12.5), // Kembali normal
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 0.95),
          weight: 5), // Bounce squash
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.95, end: 1.0), weight: 5), // Kembali
      TweenSequenceItem(
          tween: ConstantTween<double>(1.0), weight: 10), // Stabil
    ]).animate(
        CurvedAnimation(parent: _logoController, curve: Curves.easeInOut));

    // --- Ripple Animation Controller ---
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: rippleAnimationDurationMs),
    );

    _rippleOpacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
          tween: ConstantTween<double>(0.0), weight: 5), // 0-5% (delay)
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: 0.9),
          weight: 15), // 5-20% (muncul)
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.9, end: 0.75),
          weight: 40), // 20-60% (puncak)
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.75, end: 0.0),
          weight: 40), // 60-100% (memudar)
    ]).animate(
        CurvedAnimation(parent: _rippleController, curve: Curves.easeOut));

    _rippleWidthAnimation = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 15.0, end: 60.0), weight: 20), // 0-20%
      TweenSequenceItem(
          tween: Tween<double>(begin: 60.0, end: 120.0), weight: 40), // 20-60%
      TweenSequenceItem(
          tween: Tween<double>(begin: 120.0, end: 150.0),
          weight: 40), // 60-100%
    ]).animate(
        CurvedAnimation(parent: _rippleController, curve: Curves.easeOutCubic));

    _rippleHeightAnimation = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 3.0, end: 10.0), weight: 20),
      TweenSequenceItem(
          tween: Tween<double>(begin: 10.0, end: 15.0), weight: 40),
      TweenSequenceItem(
          tween: Tween<double>(begin: 15.0, end: 10.0), weight: 40),
    ]).animate(
        CurvedAnimation(parent: _rippleController, curve: Curves.easeOutCubic));

    _logoController.forward();
    Timer(const Duration(milliseconds: rippleAnimationDelayMs), () {
      if (mounted) _rippleController.forward();
    });

    Timer(const Duration(milliseconds: totalLoadingScreenUIDurationMs), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2979FF),
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([_logoController, _rippleController]),
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(0, _logoJumpAnimation.value),
                  child: Transform(
                    // Menggunakan Transform widget untuk scale X dan Y terpisah
                    alignment: Alignment
                        .center, // Pastikan origin scale di tengah logo
                    transform: Matrix4.identity()
                      ..scale(_logoScaleXAnimation.value,
                          _logoScaleYAnimation.value),
                    child: Image.asset(
                      'assets/images/Logo_posisi.png',
                      width: 80,
                    ),
                  ),
                ),
                // Memberi jarak antara logo dan ripple.
                // Posisi ripple akan di bawah logo karena Column.
                const SizedBox(
                    height:
                        5), // Jarak kecil, sesuaikan jika ripple terlalu jauh/dekat
                Opacity(
                  opacity: _rippleOpacityAnimation.value,
                  child: Container(
                    width: _rippleWidthAnimation.value,
                    height: _rippleHeightAnimation.value,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(
                          _rippleHeightAnimation.value / 2), // Membuat elips
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
