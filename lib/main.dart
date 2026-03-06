import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'theme/app_theme.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/services_section.dart';
import 'sections/packs_section.dart';
import 'sections/gallery_section.dart';
import 'sections/testimonials_section.dart';
import 'sections/contact_section.dart';

void main() {
  runApp(const DSPhotographieApp());
}

class DSPhotographieApp extends StatelessWidget {
  const DSPhotographieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DS Photographie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.bg,
        brightness: Brightness.dark,
      ),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _navVisible = false;

  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _servicesKey = GlobalKey();
  final _packsKey = GlobalKey();
  final _galleryKey = GlobalKey();
  final _testimonialsKey = GlobalKey();
  final _contactKey = GlobalKey();

  double _cursorX = 0;
  double _cursorY = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final show = _scrollController.offset > 100;
    if (show != _navVisible) {
      setState(() => _navVisible = show);
    }
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Scaffold(
      body: MouseRegion(
        onHover: (event) {
          setState(() {
            _cursorX = event.position.dx;
            _cursorY = event.position.dy;
          });
        },
        cursor: isMobile ? SystemMouseCursors.basic : SystemMouseCursors.none,
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  HeroSection(
                    key: _heroKey,
                    onCtaPressed: () => _scrollTo(_packsKey),
                  ),
                  AboutSection(key: _aboutKey),
                  ServicesSection(key: _servicesKey),
                  PacksSection(
                    key: _packsKey,
                    onContactPressed: () => _scrollTo(_contactKey),
                  ),
                  GallerySection(key: _galleryKey),
                  TestimonialsSection(key: _testimonialsKey),
                  ContactSection(key: _contactKey),
                  _buildFooter(),
                ],
              ),
            ),
            // Navbar
            _Navbar(
              visible: _navVisible,
              isMobile: isMobile,
              onNavTap: (section) {
                final keys = {
                  'hero': _heroKey,
                  'about': _aboutKey,
                  'services': _servicesKey,
                  'packs': _packsKey,
                  'gallery': _galleryKey,
                  'testimonials': _testimonialsKey,
                  'contact': _contactKey,
                };
                _scrollTo(keys[section]!);
              },
            ),
            // Custom cursor
            if (!isMobile)
              Positioned(
                left: _cursorX - 14,
                top: _cursorY - 14,
                child: IgnorePointer(
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.gold, width: 2),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: const BoxDecoration(
        color: Color(0xFF050505),
        border: Border(top: BorderSide(color: Color(0xFF1A1A1A))),
      ),
      child: Center(
        child: RichText(
          text: TextSpan(
            style: AppTheme.dmSans(fontSize: 13, color: const Color(0xFF555555)),
            children: [
              const TextSpan(text: '© 2024 '),
              TextSpan(text: 'DS Photographie', style: AppTheme.dmSans(fontSize: 13, color: AppColors.gold)),
              const TextSpan(text: '. Tous droits réservés.'),
            ],
          ),
        ),
      ),
    );
  }
}

class _Navbar extends StatefulWidget {
  final bool visible;
  final bool isMobile;
  final void Function(String section) onNavTap;

  const _Navbar({required this.visible, required this.isMobile, required this.onNavTap});

  @override
  State<_Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<_Navbar> {
  bool _menuOpen = false;

  static const _links = [
    ('À propos', 'about'),
    ('Services', 'services'),
    ('Packs', 'packs'),
    ('Galerie', 'gallery'),
    ('Avis', 'testimonials'),
    ('Contact', 'contact'),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: widget.visible ? Offset.zero : const Offset(0, -1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.bg.withValues(alpha: 0.85),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 20),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => widget.onNavTap('hero'),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'DS ',
                        style: AppTheme.cinzel(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.gold, letterSpacing: 2),
                      ),
                      TextSpan(
                        text: 'Photographie',
                        style: AppTheme.cinzel(fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.white, letterSpacing: 2),
                      ),
                    ]),
                  ),
                ),
                if (!widget.isMobile)
                  Row(
                    children: _links
                        .map((l) => _NavLink(label: l.$1, onTap: () => widget.onNavTap(l.$2)))
                        .toList(),
                  )
                else
                  GestureDetector(
                    onTap: () => setState(() => _menuOpen = !_menuOpen),
                    child: Icon(
                      _menuOpen ? Icons.close : Icons.menu,
                      color: AppColors.white,
                      size: 24,
                    ),
                  ),
              ],
            ),
            if (widget.isMobile)
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: _links
                        .map((l) => GestureDetector(
                              onTap: () {
                                widget.onNavTap(l.$2);
                                setState(() => _menuOpen = false);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  l.$1.toUpperCase(),
                                  style: AppTheme.dmSans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.whiteDim,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                crossFadeState: _menuOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label.toUpperCase(),
                style: AppTheme.dmSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _hovered ? AppColors.gold : AppColors.whiteDim,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 1,
                width: _hovered ? 30 : 0,
                color: AppColors.gold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
