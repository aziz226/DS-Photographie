import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/section_header.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool _sent = false;
  String _selectedService = '';

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _loading = false;
          _sent = true;
        });
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() => _sent = false);
            _formKey.currentState?.reset();
            _selectedService = '';
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Container(
      width: double.infinity,
      color: AppColors.dark,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isMobile
              ? Column(children: [_buildInfo(), const SizedBox(height: 50), _buildForm()])
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildInfo()),
                    const SizedBox(width: 60),
                    Expanded(child: _buildForm()),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          label: 'Contact',
          title: 'Parlons de votre projet',
        ),
        const SizedBox(height: 24),
        Text(
          "Chaque projet commence par une conversation. Décrivez-nous votre vision et nous vous proposerons une solution sur mesure, à la hauteur de vos ambitions.",
          style: AppTheme.dmSans(fontSize: 15, color: AppColors.whiteDim, height: 1.8),
        ),
        const SizedBox(height: 32),
        _contactItem(Icons.phone_outlined, '+33 6 12 34 56 78'),
        const SizedBox(height: 16),
        _contactItem(Icons.email_outlined, 'contact@ds-photographie.fr'),
        const SizedBox(height: 16),
        _contactItem(Icons.location_on_outlined, 'Paris, Île-de-France'),
        const SizedBox(height: 28),
        // Social icons
        Row(
          children: [
            _socialIcon(Icons.camera_alt_outlined), // Instagram
            const SizedBox(width: 12),
            _socialIcon(Icons.play_circle_outline), // YouTube
            const SizedBox(width: 12),
            _socialIcon(Icons.facebook_outlined), // Facebook
            const SizedBox(width: 12),
            _socialIcon(Icons.music_note_outlined), // TikTok
          ],
        ),
      ],
    );
  }

  Widget _contactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.gold),
        const SizedBox(width: 12),
        Text(
          text,
          style: AppTheme.dmSans(fontSize: 14, color: AppColors.whiteDim),
        ),
      ],
    );
  }

  Widget _socialIcon(IconData icon) {
    return _SocialButton(icon: icon);
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildInput(hint: 'Votre nom'),
          const SizedBox(height: 16),
          _buildInput(hint: 'Votre email', keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 16),
          _buildDropdown(),
          const SizedBox(height: 16),
          _buildInput(hint: 'Décrivez votre projet...', maxLines: 5),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _loading ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: _sent ? const Color(0xFF2E7D32) : AppColors.gold,
                foregroundColor: AppColors.bg,
                shape: const RoundedRectangleBorder(),
                elevation: 0,
              ),
              child: _loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.bg,
                      ),
                    )
                  : Text(
                      _sent ? 'MESSAGE ENVOYÉ !' : 'ENVOYER LE MESSAGE',
                      style: AppTheme.cinzel(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.bg,
                        letterSpacing: 2,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput({
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: AppTheme.dmSans(fontSize: 14, color: AppColors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTheme.dmSans(fontSize: 14, color: const Color(0xFF555555)),
        filled: true,
        fillColor: AppColors.card,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.gold),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      validator: (v) => (v == null || v.trim().isEmpty) ? 'Champ requis' : null,
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _selectedService.isEmpty ? null : _selectedService,
      hint: Text(
        'Service souhaité',
        style: AppTheme.dmSans(fontSize: 14, color: const Color(0xFF555555)),
      ),
      dropdownColor: AppColors.card,
      style: AppTheme.dmSans(fontSize: 14, color: AppColors.white),
      decoration: const InputDecoration(
        filled: true,
        fillColor: AppColors.card,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: AppColors.gold),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      items: const [
        DropdownMenuItem(value: 'photo', child: Text('Photographie professionnelle')),
        DropdownMenuItem(value: 'event', child: Text("Couverture d'événement")),
        DropdownMenuItem(value: 'clip', child: Text('Clip vidéo musical')),
        DropdownMenuItem(value: 'pub', child: Text('Vidéo publicitaire / corporate')),
        DropdownMenuItem(value: 'essentiel', child: Text('Pack Essentiel')),
        DropdownMenuItem(value: 'premium', child: Text('Pack Premium')),
        DropdownMenuItem(value: 'prestige', child: Text('Pack Prestige')),
        DropdownMenuItem(value: 'autre', child: Text('Autre')),
      ],
      onChanged: (v) => setState(() => _selectedService = v ?? ''),
      validator: (v) => (v == null || v.isEmpty) ? 'Veuillez sélectionner un service' : null,
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  const _SocialButton({required this.icon});

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          border: Border.all(
            color: _hovered ? AppColors.gold : const Color(0xFF2A2A2A),
          ),
          color: _hovered ? AppColors.gold.withValues(alpha: 0.08) : Colors.transparent,
        ),
        child: Icon(
          widget.icon,
          size: 18,
          color: _hovered ? AppColors.gold : AppColors.whiteDim,
        ),
      ),
    );
  }
}
