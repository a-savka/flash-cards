import 'package:flash_cards_1/features/card_categories/providers/reverse_mode.provider.dart';
import 'package:flash_cards_1/features/card_items/models/card_item.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class FlashCard extends StatefulHookConsumerWidget {
  final CardItem cardItem;

  const FlashCard({super.key, required this.cardItem});

  @override
  FlashCardState createState() => FlashCardState();
}

class FlashCardState extends ConsumerState<FlashCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showFrontSide = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_showFrontSide) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _showFrontSide = !_showFrontSide;
  }

  @override
  Widget build(BuildContext context) {
    final reverseMode = ref.watch(reverseModeProvider);
    return GestureDetector(
      onTap: _flipCard,
      child: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final angle = _animation.value * pi;
            final isFront = angle <= pi / 2;

            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle),
              child: isFront
                  ? _buildFront(reverseMode)
                  : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(pi),
                      child: _buildBack(reverseMode),
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFront(bool reverseMode) {
    return _cardTemplate(
      color: Colors.blue[300],
      text: reverseMode ? widget.cardItem.answer : widget.cardItem.question,
    );
  }

  Widget _buildBack(bool reverseMode) {
    return _cardTemplate(
      color: Colors.blue[900],
      text: reverseMode ? widget.cardItem.question : widget.cardItem.answer,
    );
  }

  Widget _cardTemplate({required Color? color, required String text}) {
    return Container(
      width: 280,
      height: 230,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
