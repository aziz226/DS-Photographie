import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';
import '../widgets/section_header.dart';

class _PackData {
  final String name;
  final String price;
  final String priceSuffix;
  final String description;
  final List<String> features;
  final bool featured;
  final String cta;

  const _PackData({
    required this.name,
    required this.price,
    this.priceSuffix = '/ projet',
    required this.description,
    required this.features,
    this.featured = false,
    this.cta = 'Choisir ce pack',
  });
}

const _packs = [
  _PackData(
    name: 'Essentiel',
    price: '490€',
    description: 'Idéal pour un premier projet ou un besoin ponctuel.',
    features: [
      'Séance photo 1h ou vidéo courte',
      '30 photos retouchées HD',
      '1 vidéo montée (jusqu\'à 1 min)',
      'Livraison sous 7 jours',
    ],
  ),
  _PackData(
    name: 'Premium',
    price: '990€',
    description: 'Notre formule la plus populaire, pour des résultats professionnels.',
    features: [
      'Séance photo 3h ou couverture événement',
      '100 photos retouchées HD',
      '1 clip ou vidéo (jusqu\'à 3 min)',
      'Direction artistique incluse',
      'Livraison sous 5 jours',
    ],
    featured: true,
  ),
  _PackData(
    name: 'Prestige',
    price: 'Sur mesure',
    priceSuffix: '',
    description: "L'offre ultime pour les projets d'envergure et les clients exigeants.",
    features: [
      'Couverture complète multi-jours',
      'Photos & vidéos illimitées',
      'Équipe dédiée (photo + vidéo)',
      'Post-production premium',
      'Accompagnement personnalisé A à Z',
    ],
    cta: 'Nous contacter',
  ),
];

class PacksSection extends StatefulWidget {
  final VoidCallback onContactPressed;
  const PacksSection({super.key, required this.onContactPressed});

  @override
  State<PacksSection> createState() => _PacksSectionState();
}

class _PacksSectionState extends State<PacksSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 900 ? 3 : width > 600 ? 2 : 1;

    return VisibilityDetector(
      key: const Key('packs'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: width < 768 ? 20 : 40,
          vertical: 80,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.bg, Color(0xFF0E0D0A), AppColors.bg],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              children: [
                const SectionHeader(
                  label: 'Nos packs',
                  title: 'Des formules adaptées à vos ambitions',
                  center: true,
                ),
                const SizedBox(height: 50),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 24,
                    childAspectRatio: crossAxisCount == 1 ? 0.72 : 0.58,
                  ),
                  itemCount: _packs.length,
                  itemBuilder: (context, index) {
                    return AnimatedOpacity(
                      opacity: _visible ? 1 : 0,
                      duration: Duration(milliseconds: 600 + index * 150),
                      curve: Curves.easeOut,
                      child: AnimatedSlide(
                        offset: _visible ? Offset.zero : const Offset(0, 0.15),
                        duration: Duration(milliseconds: 600 + index * 150),
                        curve: Curves.easeOutCubic,
                        child: _PackCard(
                          data: _packs[index],
                          onCtaPressed: widget.onContactPressed,
                        ),
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

class _PackCard extends StatefulWidget {
  final _PackData data;
  final VoidCallback onCtaPressed;
  const _PackCard({required this.data, required this.onCtaPressed});

  @override
  State<_PackCard> createState() => _PackCardState();
}

class _PackCardState extends State<_PackCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: d.featured ? const Color(0xFF151210) : AppColors.card,
          border: Border.all(
            color: d.featured ? AppColors.gold : AppColors.border,
          ),
          boxShadow: _hovered
              ? [BoxShadow(color: Colors.black.withValues(alpha: 0.4), blurRadius: 30, offset: const Offset(0, 10))]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (d.featured)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                color: AppColors.gold,
                child: Text(
                  'RECOMMANDÉ',
                  style: AppTheme.dmSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.bg,
                    letterSpacing: 2,
                  ),
                ),
              ),
            if (d.featured) const SizedBox(height: 16),
            Text(
              d.name,
              style: AppTheme.cinzel(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  d.price,
                  style: AppTheme.cinzel(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.gold,
                  ),
                ),
                if (d.priceSuffix.isNotEmpty) ...[
                  const SizedBox(width: 6),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      d.priceSuffix,
                      style: AppTheme.dmSans(
                        fontSize: 13,
                        color: AppColors.whiteDim,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            Text(
              d.description,
              style: AppTheme.dmSans(fontSize: 13, color: AppColors.whiteDim),
            ),
            const SizedBox(height: 16),
            Container(height: 1, color: AppColors.border),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: d.features
                    .map((f) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              const Icon(Icons.check, size: 16, color: AppColors.gold),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  f,
                                  style: AppTheme.dmSans(
                                    fontSize: 13,
                                    color: AppColors.whiteDim,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: _PackButton(
                text: d.cta,
                filled: d.featured,
                onPressed: widget.onCtaPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PackButton extends StatefulWidget {
  final String text;
  final bool filled;
  final VoidCallback onPressed;
  const _PackButton({required this.text, this.filled = false, required this.onPressed});

  @override
  State<_PackButton> createState() => _PackButtonState();
}

class _PackButtonState extends State<_PackButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: (widget.filled || _hovered) ? AppColors.gold : Colors.transparent,
            border: Border.all(
              color: (widget.filled || _hovered) ? AppColors.gold : const Color(0xFF333333),
            ),
          ),
          child: Text(
            widget.text.toUpperCase(),
            style: AppTheme.cinzel(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: (widget.filled || _hovered) ? AppColors.bg : AppColors.white,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
