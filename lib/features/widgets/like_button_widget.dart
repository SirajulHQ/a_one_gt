import 'package:a_one_gt/dummy_data/dummy_model.dart';
import 'package:a_one_gt/features/wishlist/controller/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LikeButtonWidget extends ConsumerStatefulWidget {
  final Product product;
  final double iconSize;
  final double padding;

  const LikeButtonWidget({
    super.key,
    required this.product,
    this.iconSize = 16,
    this.padding = 5,
  });

  @override
  ConsumerState<LikeButtonWidget> createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends ConsumerState<LikeButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _likeController;
  late Animation<double> _likeAnimation;

  @override
  void initState() {
    super.initState();

    _likeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _likeAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 1.35,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.35,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_likeController);
  }

  @override
  void dispose() {
    _likeController.dispose();
    super.dispose();
  }

  void _handleLikeTap() {
    final notifier = ref.read(wishlistProvider.notifier);
    notifier.toggle(widget.product);

    final isNowLiked = ref
        .read(wishlistProvider)
        .any((p) => p.id == widget.product.id);

    if (isNowLiked) {
      HapticFeedback.mediumImpact();
      _likeController.forward(from: 0);
    } else {
      HapticFeedback.lightImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWishlisted = ref.watch(
      wishlistProvider.select(
        (list) => list.any((p) => p.id == widget.product.id),
      ),
    );

    return GestureDetector(
      onTap: _handleLikeTap,
      child: Container(
        padding: EdgeInsets.all(widget.padding),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          shape: BoxShape.circle,
        ),
        child: ScaleTransition(
          scale: _likeAnimation,
          child: Icon(
            isWishlisted
                ? Icons.favorite_rounded
                : Icons.favorite_border_rounded,
            size: widget.iconSize,
            color: isWishlisted ? Colors.redAccent : Colors.grey,
          ),
        ),
      ),
    );
  }
}
