import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/section_header.dart';

class _TestimonialData {
  final String text;
  final String author;
  final String role;

  const _TestimonialData({
    required this.text,
    required this.author,
    required this.role,
  });
}

const _testimonials = [
  _TestimonialData(
    text:
        "DS Photographie a sublimé notre mariage. Chaque photo raconte une émotion, chaque instant a été capturé avec une sensibilité rare. Un travail d'exception.",
    author: 'Amina & Karim B.',
    role: 'Mariage — Juin 2024',
  ),
  _TestimonialData(
    text:
        "Le clip vidéo réalisé pour notre single a dépassé toutes nos attentes. Vision artistique, qualité cinéma, et une écoute irréprochable du début à la fin.",
    author: 'Yassine M.',
    role: 'Artiste musical — Mars 2024',
  ),
  _TestimonialData(
    text:
        "Nous faisons appel à DS Photographie pour tous nos événements corporate. Professionnalisme, réactivité et un rendu toujours impeccable. Partenaire de confiance.",
    author: 'Sophie L.',
    role: 'Directrice Communication — NovaTech',
  ),
  _TestimonialData(
    text:
        "Notre spot publicitaire a généré un engagement record sur les réseaux. L'équipe DS a compris notre vision dès le premier brief. Résultat magistral.",
    author: 'Marc D.',
    role: 'Fondateur — Maison Élara',
  ),
];

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  late PageController _pageController;
  int _current = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          _current = (_current + 1) % _testimonials.length;
        });
        _pageController.animateToPage(
          _current,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: width < 768 ? 20 : 40,
        vertical: 80,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.bg, Color(0xFF0E0E0E)],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const SectionHeader(
                label: 'Témoignages',
                title: 'Ce que disent nos clients',
                center: true,
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 280,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (i) {
                    setState(() => _current = i);
                    _timer?.cancel();
                    _startAutoSlide();
                  },
                  itemCount: _testimonials.length,
                  itemBuilder: (context, index) {
                    return _TestimonialCard(data: _testimonials[index]);
                  },
                ),
              ),
              const SizedBox(height: 24),
              // Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_testimonials.length, (i) {
                  return GestureDetector(
                    onTap: () {
                      setState(() => _current = i);
                      _pageController.animateToPage(i,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOut);
                      _timer?.cancel();
                      _startAutoSlide();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _current == i ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _current == i ? AppColors.gold : const Color(0xFF333333),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final _TestimonialData data;
  const _TestimonialCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Stars
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (_) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: Icon(Icons.star, size: 18, color: AppColors.gold),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '« ${data.text} »',
            style: AppTheme.cormorant(
              fontSize: 17,
              fontStyle: FontStyle.italic,
              color: AppColors.whiteDim,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            data.author,
            style: AppTheme.cinzel(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            data.role,
            style: AppTheme.dmSans(
              fontSize: 13,
              color: AppColors.gold,
            ),
          ),
        ],
      ),
    );
  }
}
