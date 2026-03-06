import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';
import '../widgets/section_header.dart';

class _GalleryItem {
  final String title;
  final String category;
  final String filter;
  final Color color1;
  final Color color2;

  const _GalleryItem({
    required this.title,
    required this.category,
    required this.filter,
    required this.color1,
    required this.color2,
  });
}

const _items = [
  _GalleryItem(title: 'Portrait Studio', category: 'Photo', filter: 'photo', color1: Color(0xFF1A1520), color2: Color(0xFF2A1A28)),
  _GalleryItem(title: 'Gala Annuel 2024', category: 'Événement', filter: 'event', color1: Color(0xFF151A1F), color2: Color(0xFF1A252D)),
  _GalleryItem(title: 'Nuit Éternelle — Clip', category: 'Clip Vidéo', filter: 'clip', color1: Color(0xFF1A1810), color2: Color(0xFF252015)),
  _GalleryItem(title: 'Campagne Luxe', category: 'Publicité', filter: 'pub', color1: Color(0xFF101518), color2: Color(0xFF182028)),
  _GalleryItem(title: 'Mariage S & L', category: 'Événement', filter: 'event', color1: Color(0xFF1C1515), color2: Color(0xFF281A1A)),
  _GalleryItem(title: 'Shooting Mode', category: 'Photo', filter: 'photo', color1: Color(0xFF12160F), color2: Color(0xFF1A2015)),
  _GalleryItem(title: 'Onde Sonore — Clip', category: 'Clip Vidéo', filter: 'clip', color1: Color(0xFF181518), color2: Color(0xFF221A22)),
  _GalleryItem(title: 'Spot Digital Fintech', category: 'Publicité', filter: 'pub', color1: Color(0xFF15181A), color2: Color(0xFF1E2428)),
  _GalleryItem(title: 'Corporate Headshots', category: 'Photo', filter: 'photo', color1: Color(0xFF1A1712), color2: Color(0xFF25201A)),
  _GalleryItem(title: 'Conférence Tech', category: 'Événement', filter: 'event', color1: Color(0xFF141A18), color2: Color(0xFF1A2520)),
  _GalleryItem(title: 'Éclipse — Clip', category: 'Clip Vidéo', filter: 'clip', color1: Color(0xFF1A1318), color2: Color(0xFF281A25)),
  _GalleryItem(title: 'Film de Marque Bio', category: 'Publicité', filter: 'pub', color1: Color(0xFF131518), color2: Color(0xFF1A2028)),
];

class GallerySection extends StatefulWidget {
  const GallerySection({super.key});

  @override
  State<GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<GallerySection> {
  String _activeFilter = 'all';
  bool _visible = false;

  List<_GalleryItem> get _filtered =>
      _activeFilter == 'all' ? _items : _items.where((i) => i.filter == _activeFilter).toList();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 900 ? 4 : width > 600 ? 3 : 2;

    return VisibilityDetector(
      key: const Key('gallery'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
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
                  label: 'Portfolio',
                  title: 'Nos réalisations',
                  center: true,
                ),
                const SizedBox(height: 30),
                // Filters
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    _FilterButton(label: 'Tous', filter: 'all', active: _activeFilter == 'all', onTap: () => setState(() => _activeFilter = 'all')),
                    _FilterButton(label: 'Photo', filter: 'photo', active: _activeFilter == 'photo', onTap: () => setState(() => _activeFilter = 'photo')),
                    _FilterButton(label: 'Événements', filter: 'event', active: _activeFilter == 'event', onTap: () => setState(() => _activeFilter = 'event')),
                    _FilterButton(label: 'Clips', filter: 'clip', active: _activeFilter == 'clip', onTap: () => setState(() => _activeFilter = 'clip')),
                    _FilterButton(label: 'Publicité', filter: 'pub', active: _activeFilter == 'pub', onTap: () => setState(() => _activeFilter = 'pub')),
                  ],
                ),
                const SizedBox(height: 30),
                // Grid
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: GridView.builder(
                    key: ValueKey(_activeFilter),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: _filtered.length,
                    itemBuilder: (context, index) {
                      return _GalleryTile(item: _filtered[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterButton extends StatefulWidget {
  final String label;
  final String filter;
  final bool active;
  final VoidCallback onTap;
  const _FilterButton({required this.label, required this.filter, required this.active, required this.onTap});

  @override
  State<_FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<_FilterButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: (widget.active || _hovered) ? AppColors.goldDark : Colors.transparent,
            ),
          ),
          child: Text(
            widget.label.toUpperCase(),
            style: AppTheme.dmSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: (widget.active || _hovered) ? AppColors.gold : AppColors.whiteDim,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

class _GalleryTile extends StatefulWidget {
  final _GalleryItem item;
  const _GalleryTile({required this.item});

  @override
  State<_GalleryTile> createState() => _GalleryTileState();
}

class _GalleryTileState extends State<_GalleryTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [widget.item.color1, widget.item.color2],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedScale(
              scale: _hovered ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [widget.item.color1, widget.item.color2],
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: _hovered ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                color: AppColors.bg.withValues(alpha: 0.75),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.item.title,
                        style: AppTheme.cinzel(
                          fontSize: 13,
                          letterSpacing: 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.item.category.toUpperCase(),
                        style: AppTheme.dmSans(
                          fontSize: 10,
                          color: AppColors.gold,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
