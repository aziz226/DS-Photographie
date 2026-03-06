import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/gold_button.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onCtaPressed;
  const HeroSection({super.key, required this.onCtaPressed});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _bgController;
  late AnimationController _wordController;
  late AnimationController _fadeController;

  final List<String> _words = ['NOUS', 'CAPTURONS', "L'EXTRAORDINAIRE"];

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _wordController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..forward();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _bgController.dispose();
    _wordController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        children: [
          // Animated background
          AnimatedBuilder(
            animation: _bgController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(
                      -0.6 + _bgController.value * 0.4,
                      -0.2 + _bgController.value * 0.3,
                    ),
                    radius: 1.2,
                    colors: [
                      AppColors.bordeaux.withValues(alpha: 0.6),
                      AppColors.bg,
                    ],
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment(
                        0.5 - _bgController.value * 0.3,
                        0.3 - _bgController.value * 0.2,
                      ),
                      radius: 0.8,
                      colors: [
                        AppColors.gold.withValues(alpha: 0.08 + _bgController.value * 0.06),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          // Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated title
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: List.generate(_words.length, (i) {
                      final start = i * 0.25 / _words.length + 0.1;
                      final end = start + 0.35;
                      final animation = CurvedAnimation(
                        parent: _wordController,
                        curve: Interval(start.clamp(0, 1), end.clamp(0, 1),
                            curve: Curves.easeOutCubic),
                      );
                      return AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, 40 * (1 - animation.value)),
                            child: Opacity(
                              opacity: animation.value,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Text(
                                  _words[i],
                                  style: AppTheme.cinzel(
                                    fontSize: size.width < 600
                                        ? 28
                                        : size.width < 900
                                            ? 42
                                            : 60,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 4,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 24),
                  // Subtitle
                  FadeTransition(
                    opacity: _fadeController,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.3),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: _fadeController,
                        curve: Curves.easeOut,
                      )),
                      child: Text(
                        'Photographie · Clips Vidéo · Publicité · Événements',
                        style: AppTheme.cormorant(
                          fontSize: size.width < 600 ? 14 : 18,
                          color: AppColors.whiteDim,
                          letterSpacing: 4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // CTA
                  FadeTransition(
                    opacity: CurvedAnimation(
                      parent: _fadeController,
                      curve: const Interval(0.3, 1),
                    ),
                    child: GoldButton(
                      text: 'Découvrir nos packs',
                      onPressed: widget.onCtaPressed,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Scroll indicator
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: _fadeController,
                curve: const Interval(0.5, 1),
              ),
              child: Column(
                children: [
                  Text(
                    'SCROLL',
                    style: AppTheme.dmSans(
                      fontSize: 10,
                      letterSpacing: 3,
                      color: AppColors.whiteDim,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _ScrollLine(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScrollLine extends StatefulWidget {
  @override
  State<_ScrollLine> createState() => _ScrollLineState();
}

class _ScrollLineState extends State<_ScrollLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: 0.3 + _controller.value * 0.7,
          child: Container(
            width: 1,
            height: 25 + _controller.value * 15,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.gold, Colors.transparent],
              ),
            ),
          ),
        );
      },
    );
  }
}
