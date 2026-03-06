import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String label;
  final String title;
  final String? subtitle;
  final bool center;

  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    this.subtitle,
    this.center = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: AppTheme.dmSans(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.gold,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: AppTheme.cinzel(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
          textAlign: center ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 16),
        Container(
          width: 60,
          height: 2,
          color: AppColors.gold,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 20),
          Text(
            subtitle!,
            style: AppTheme.cormorant(
              fontSize: 17,
              color: AppColors.whiteDim,
            ),
            textAlign: center ? TextAlign.center : TextAlign.left,
          ),
        ],
      ],
    );
  }
}
