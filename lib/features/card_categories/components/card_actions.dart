import 'package:flutter/material.dart';

class CardActions extends StatefulWidget {
  final void Function() onAdd;
  final void Function() onEdit;
  final void Function() onDelete;
  final bool canEdit;

  const CardActions({
    super.key,
    required this.canEdit,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  CardActionsState createState() => CardActionsState();
}

class CardActionsState extends State<CardActions> {
  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy < -7) {
          _toggleExpansion(); // Swipe up
        } else if (details.delta.dy > 7) {
          _toggleExpansion(); // Swipe down
        }
      },
      onTap: _toggleExpansion,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _isExpanded ? 100.0 : 25.0,
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.01),
          //     blurRadius: 1, // Spread the shadow
          //     offset: const Offset(-1, -1), // Offset for x and y axis
          //   ),
          // ],
          color: Theme.of(context).colorScheme.primary,
          // color: Colors.black87,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Center(
          child: _isExpanded
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: widget.onAdd,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(12),
                        elevation: 4,
                        shape:
                            const CircleBorder(), // Makes the button circular
                      ),
                      child: Icon(Icons.add, color: Colors.green[600]),
                    ),
                    ElevatedButton(
                      onPressed: widget.onEdit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(12),
                        elevation: 4,
                        shape: const CircleBorder(),
                      ),
                      child: Icon(Icons.edit, color: Colors.green[600]),
                    ),
                    ElevatedButton(
                      onPressed: widget.onDelete,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[600],
                        padding: const EdgeInsets.all(12),
                        elevation: 4,
                        shape: const CircleBorder(),
                      ),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                  ],
                )
              : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.white,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
