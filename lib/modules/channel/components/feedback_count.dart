import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class FeedbackCountItem extends StatelessWidget {
  final String icon;
  final String label;
  final int count;

  const FeedbackCountItem({
    super.key,
    required this.icon,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 16),
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
          const Spacer(),
          Text(
            count.toString(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
