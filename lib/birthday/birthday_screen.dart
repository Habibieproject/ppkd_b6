import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

/// Layar ucapan ulang tahun untuk Bapak E. Suzukiana, AP., M.Si.
///
/// Self-contained: cukup arahkan navigasi ke `BirthdayScreen()` atau jadikan
/// `home`. Menggunakan package `confetti` yang sudah ada di project.
class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen>
    with TickerProviderStateMixin {
  late final ConfettiController _confetti;
  late final AnimationController _flameCtrl; // kedip lilin
  late final AnimationController _balloonCtrl; // balon naik

  bool _candleLit = true;

  // Palet tema (nuansa merah PPKD).
  static const Color _merah = Color(0xffB10C0C);
  static const Color _merahMuda = Color(0xffE23B3B);
  static const Color _emas = Color(0xffF5B301);

  final List<_Balloon> _balloons = List.generate(8, (i) {
    final rnd = Random(i * 7 + 3);
    const colors = [
      Color(0xffF5B301),
      Color(0xffE23B3B),
      Colors.white,
      Color(0xffFFD9D9),
      Color(0xffFF7A00),
    ];
    return _Balloon(
      startX: rnd.nextDouble(),
      drift: (rnd.nextDouble() - 0.5) * 0.15,
      scale: 0.7 + rnd.nextDouble() * 0.6,
      phase: rnd.nextDouble(),
      color: colors[i % colors.length],
    );
  });

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 3));
    _flameCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    )..repeat(reverse: true);
    _balloonCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    // Confetti otomatis saat layar dibuka.
    WidgetsBinding.instance.addPostFrameCallback((_) => _confetti.play());
  }

  @override
  void dispose() {
    _confetti.dispose();
    _flameCtrl.dispose();
    _balloonCtrl.dispose();
    super.dispose();
  }

  void _celebrate() {
    setState(() => _candleLit = !_candleLit);
    _confetti.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(-0.6, -0.7),
            radius: 1.2,
            colors: [Color(0xff7A0808), _merah, Color(0xff5E0404)],
            stops: [0.0, 0.45, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Balon mengambang di belakang.
            AnimatedBuilder(
              animation: _balloonCtrl,
              builder: (context, _) {
                return CustomPaint(
                  size: Size.infinite,
                  painter: _BalloonPainter(_balloons, _balloonCtrl.value),
                );
              },
            ),

            // Confetti dari atas tengah.
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confetti,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                numberOfParticles: 24,
                maxBlastForce: 22,
                minBlastForce: 8,
                gravity: 0.25,
                colors: const [
                  _emas,
                  _merahMuda,
                  Colors.white,
                  Color(0xffFF7A00),
                ],
              ),
            ),

            // Kartu ucapan.
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: _Card(
                  candleLit: _candleLit,
                  flameCtrl: _flameCtrl,
                  onCelebrate: _celebrate,
                  onBlowCandle: () {
                    setState(() => _candleLit = false);
                    _confetti.play();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.candleLit,
    required this.flameCtrl,
    required this.onCelebrate,
    required this.onBlowCandle,
  });

  final bool candleLit;
  final AnimationController flameCtrl;
  final VoidCallback onCelebrate;
  final VoidCallback onBlowCandle;

  static const Color _merah = Color(0xffB10C0C);
  static const Color _merahMuda = Color(0xffE23B3B);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 480),
      child: Container(
        padding: const EdgeInsets.fromLTRB(28, 36, 28, 32),
        decoration: BoxDecoration(
          color: const Color(0xfffFF7EF).withValues(alpha: 0.97),
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 40,
              offset: Offset(0, 18),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '🎉 HARI ISTIMEWA 🎉',
              style: TextStyle(
                letterSpacing: 3,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: _merah,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Selamat Ulang Tahun',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: _merah,
              ),
            ),
            const SizedBox(height: 8),
            // Nama dengan gradasi.
            ShaderMask(
              shaderCallback: (rect) => const LinearGradient(
                colors: [_merah, _merahMuda, Color(0xffF5B301)],
              ).createShader(rect),
              child: const Text(
                'Bapak E. Suzukiana, AP., M.Si',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Kepala PPKD Jakarta Pusat',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Color(0xff666666),
              ),
            ),
            const SizedBox(height: 24),

            // Kue (klik untuk meniup lilin).
            GestureDetector(
              onTap: onBlowCandle,
              child: _Cake(candleLit: candleLit, flameCtrl: flameCtrl),
            ),
            const SizedBox(height: 26),

            const Text(
              'Di hari yang penuh berkah ini, kami segenap keluarga besar '
              'PPKD Jakarta Pusat mengucapkan selamat ulang tahun. Semoga Bapak '
              'senantiasa diberikan kesehatan, kebahagiaan, dan keberkahan dalam '
              'memimpin serta membimbing kami semua. Terima kasih atas dedikasi '
              'dan teladannya. 🙏',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.6,
                color: Color(0xff444444),
              ),
            ),
            const SizedBox(height: 24),

            // Tombol rayakan.
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  BoxShadow(
                    color: _merah.withValues(alpha: 0.4),
                    blurRadius: 22,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: onCelebrate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _merah,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 26,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('🎂  Tiup Lilin & Rayakan!'),
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Dengan hormat & doa terbaik — Keluarga Besar PPKD JP',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Color(0xff888888)),
            ),
          ],
        ),
      ),
    );
  }
}

/// Kue dua lapis dengan lilin dan nyala api yang berkedip.
class _Cake extends StatelessWidget {
  const _Cake({required this.candleLit, required this.flameCtrl});

  final bool candleLit;
  final AnimationController flameCtrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 170,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Nyala api (berkedip).
          if (candleLit)
            Positioned(
              top: 0,
              child: AnimatedBuilder(
                animation: flameCtrl,
                builder: (context, _) {
                  final t = flameCtrl.value;
                  return Transform.scale(
                    scale: 1 + t * 0.15,
                    child: Opacity(
                      opacity: 0.85 + t * 0.15,
                      child: Container(
                        width: 16,
                        height: 24,
                        decoration: const BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment(0, 0.4),
                            colors: [
                              Colors.white,
                              Color(0xffF5B301),
                              Color(0xffFF7A00),
                              Colors.transparent,
                            ],
                            stops: [0.0, 0.35, 0.75, 1.0],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.elliptical(8, 12),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          // Lilin.
          Positioned(
            top: 22,
            child: Container(
              width: 12,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Color(0xffE23B3B)],
                  stops: [0.5, 0.5],
                  tileMode: TileMode.repeated,
                ),
              ),
            ),
          ),

          // Lapisan atas.
          Positioned(
            top: 64,
            child: Container(
              width: 150,
              height: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffFFD9D9), Color(0xffE23B3B)],
                ),
              ),
            ),
          ),

          // Lapisan bawah.
          Positioned(
            top: 108,
            child: Container(
              width: 190,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffE23B3B), Color(0xffB10C0C)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Data satu balon.
class _Balloon {
  _Balloon({
    required this.startX,
    required this.drift,
    required this.scale,
    required this.phase,
    required this.color,
  });

  final double startX; // 0..1 posisi horizontal awal
  final double drift; // pergeseran horizontal
  final double scale;
  final double phase; // 0..1 offset waktu
  final Color color;
}

/// Menggambar balon yang naik dari bawah ke atas secara berulang.
class _BalloonPainter extends CustomPainter {
  _BalloonPainter(this.balloons, this.t);

  final List<_Balloon> balloons;
  final double t; // 0..1

  @override
  void paint(Canvas canvas, Size size) {
    final stringPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.5)
      ..strokeWidth = 1.2;

    for (final b in balloons) {
      final progress = (t + b.phase) % 1.0;
      final y = size.height * (1.15 - progress * 1.3);
      final x = size.width * b.startX + size.width * b.drift * progress;

      final w = 46 * b.scale;
      final h = 58 * b.scale;

      final paint = Paint()..color = b.color.withValues(alpha: 0.85);
      final rect = Rect.fromCenter(center: Offset(x, y), width: w, height: h);
      canvas.drawOval(rect, paint);

      // Tali balon.
      canvas.drawLine(
        Offset(x, y + h / 2),
        Offset(x, y + h / 2 + 14 * b.scale),
        stringPaint,
      );

      // Kilau kecil.
      final shine = Paint()..color = Colors.white.withValues(alpha: 0.35);
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(x - w * 0.18, y - h * 0.18),
          width: w * 0.25,
          height: h * 0.18,
        ),
        shine,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BalloonPainter oldDelegate) =>
      oldDelegate.t != t;
}
