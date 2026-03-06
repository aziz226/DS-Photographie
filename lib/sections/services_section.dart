import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';
import '../widgets/section_header.dart';

class _ServiceData {
  final IconData icon;
  final String title;
  final String description;

  const _ServiceData({
    required this.icon,
    required this.title,
    required this.description,
  });
}

const _services = [
  _ServiceData(
    icon: Icons.camera_alt_outlined,
    title: 'Photographie Pro',
    description:
        'Portraits, mode, corporate ou produit — nous captons la lumière qui révèle votre identité avec un regard artistique unique.',
  ),
  _ServiceData(
    icon: Icons.event_outlined,
    title: 'Couverture Événements',
    description:
        "Mariages, galas, conférences, soirées — nous immortalisons chaque instant marquant avec discrétion et élégance.",
  ),
  _ServiceData(
    icon: Icons.music_note_outlined,
    title: 'Clips Vidéo Musicaux',
    description:
        'De la direction artistique au montage final, nous créons des clips percutants qui portent votre univers musical.',
  ),
  _ServiceData(
    icon: Icons.videocam_outlined,
    title: 'Vidéos Publicitaires',
    description:
        'Spots corporate, publicités digitales, films de marque — une production sur mesure pour maximiser votre impact.',
  ),
];

class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 900 ? 4 : width > 600 ? 2 : 1;

    return VisibilityDetector(
      key: const Key('services'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.15 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        width: double.infinity,
        color: AppColors.bg,
        padding: EdgeInsets.symmetric(
          horizontal: width < 768 ? 20 : 40,
          vertical: 80,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              children: [
                const SectionHeader(
                  label: 'Nos services',
                  title: 'Ce que nous faisons de mieux',
                  subtitle:
                      'Un savoir-faire complet pour donner vie à vos projets visuels les plus ambitieux.',
                  center: true,
                ),
                const SizedBox(height: 50),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: crossAxisCount == 1 ? 2 : 0.85,
                  ),
                  itemCount: _services.length,
                  itemBuilder: (context, index) {
                    return AnimatedOpacity(
                      opacity: _visible ? 1 : 0,
                      duration: Duration(milliseconds: 600 + index * 150),
                      curve: Curves.easeOut,
                      child: AnimatedSlide(
                        offset: _visible ? Offset.zero : const Offset(0, 0.2),
                        duration: Duration(milliseconds: 600 + index * 150),
                        curve: Curves.easeOutCubic,
                        child: _ServiceCard(data: _services[index]),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final _ServiceData data;
  const _ServiceCard({required this.data});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _hovered ? -8 : 0, 0),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: AppColors.card,
          border: Border.all(
            color: _hovered ? AppColors.goldDark : AppColors.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.gold.withValues(alpha: 0.08),
                    blurRadius: 40,
                    offset: const Offset(0, 15),
                  )
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.data.icon,
              size: 40,
              color: AppColors.gold,
            ),
            const SizedBox(height: 20),
            Text(
              widget.data.title,
              style: AppTheme.cinzel(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              widget.data.description,
              style: AppTheme.dmSans(
                fontSize: 13,
                color: AppColors.whiteDim,
                height: 1.7,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
