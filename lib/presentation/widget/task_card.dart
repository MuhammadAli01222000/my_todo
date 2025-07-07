import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final Widget icon;
  final Color color;
  final String text;
  final int count;

  const TaskCard({
    super.key,
    required this.icon,
    required this.text,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CircleAvatar(backgroundColor: Colors.white, child: icon),
              ),
              // const SizedBox(height: 8),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: Text(
                  '$count Tasks',
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
