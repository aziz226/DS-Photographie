import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';

class AnimatedCounter extends StatefulWidget {
  final int target;
  final String suffix;
  final String label;

  const AnimatedCounter({
    super.key,
    required this.target,
    required this.suffix,
    required this.label,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('counter_${widget.label}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5 && !_started) {
          _started = true;
          _controller.forward();
        }
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final value = (_animation.value * widget.target).toInt();
          return Column(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$value',
                      style: AppTheme.cinzel(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: AppColors.gold,
                      ),
                    ),
                    TextSpan(
                      text: widget.suffix,
                      style: AppTheme.cinzel(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.label,
                style: AppTheme.dmSans(
                  fontSize: 13,
                  color: AppColors.whiteDim,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
