import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tasteclip/modules/explore/components/shimmer_widget.dart';

class ProfileImageWithShimmer extends StatelessWidget {
  final String? imageUrl;
  final double size;

  const ProfileImageWithShimmer({
    super.key,
    this.imageUrl,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: CachedNetworkImage(
          imageUrl: imageUrl ?? '',
          fit: BoxFit.cover,
          placeholder: (context, url) => ShimmerWidget.circular(
            width: size,
            height: size,
          ),
          errorWidget: (context, url, error) => Icon(
            Icons.person,
            size: size * 0.6,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
