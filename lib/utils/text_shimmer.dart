import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TextFeedbackShimmer extends StatelessWidget {
  const TextFeedbackShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey[400],
              ),
              SizedBox(width: 12),
              Container(
                width: 100,
                height: 16,
                color: Colors.grey[400],
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 14,
            color: Colors.grey[400],
          ),
          SizedBox(height: 8),
          Container(
            width: 200,
            height: 14,
            color: Colors.grey[400],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                color: Colors.grey[400],
              ),
              SizedBox(width: 8),
              Container(
                width: 30,
                height: 16,
                color: Colors.grey[400],
              ),
              SizedBox(width: 16),
              Container(
                width: 1,
                height: 20,
                color: Colors.grey[400],
              ),
              SizedBox(width: 16),
              Container(
                width: 50,
                height: 16,
                color: Colors.grey[400],
              ),
              SizedBox(width: 16),
              Container(
                width: 1,
                height: 20,
                color: Colors.grey[400],
              ),
              SizedBox(width: 16),
              Container(
                width: 80,
                height: 16,
                color: Colors.grey[400],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileImageWithShimmer extends StatelessWidget {
  final String? imageUrl;
  final double radius;

  const ProfileImageWithShimmer({
    super.key,
    required this.imageUrl,
    this.radius = 18,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: radius,
        backgroundImage: imageProvider,
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: Colors.grey[400],
        ),
      ),
      errorWidget: (context, url, error) => CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey[400],
        child: Icon(Icons.person, size: radius),
      ),
    );
  }
}
