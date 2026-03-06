import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/section_header.dart';
import '../widgets/animated_counter.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
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
          child: isMobile
              ? Column(
                  children: [_buildText(isMobile), const SizedBox(height: 40), _buildImage()],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: _buildText(isMobile)),
                    const SizedBox(width: 60),
                    Expanded(child: _buildImage()),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildText(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          label: 'À propos',
          title: "L'excellence au service de votre image",
        ),
        const SizedBox(height: 24),
        Text(
          "DS Photographie est un studio de production créative spécialisé dans la captation d'images d'exception. Nous mettons notre expertise au service de ceux qui refusent l'ordinaire — entrepreneurs, artistes, marques et organisateurs d'événements. Chaque projet est une nouvelle histoire à sublimer, chaque cliché une émotion à immortaliser.",
          style: AppTheme.dmSans(
            fontSize: 15,
            color: AppColors.whiteDim,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 40,
          runSpacing: 24,
          children: const [
            AnimatedCounter(target: 500, suffix: '+', label: 'Événements couverts'),
            AnimatedCounter(target: 200, suffix: '+', label: 'Clips réalisés'),
            AnimatedCounter(target: 98, suffix: '%', label: 'Clients satisfaits'),
          ],
        ),
      ],
    );
  }

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 0.85,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1A1A1A), Color(0xFF111111)],
                ),
                border: Border.all(color: AppColors.gold.withValues(alpha: 0.4)),
              ),
              child: Center(
                child: Text(
                  'DS',
                  style: AppTheme.cinzel(
                    fontSize: 80,
                    fontWeight: FontWeight.w900,
                    color: AppColors.gold.withValues(alpha: 0.06),
                    letterSpacing: 10,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
