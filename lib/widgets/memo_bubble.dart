import 'dart:ui';

import 'package:flutter/material.dart';
import '../models/memo.dart';

class MemoBubble extends StatelessWidget {
  final Memo memo;
  final void Function(bool?)? onTodoCheck;
  const MemoBubble({super.key, required this.memo, this.onTodoCheck});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffe3e5e8).withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          // border: Border.all(color: Colors.white),
        ),
        padding: EdgeInsets.fromLTRB(16, 16, 8, 16),
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (memo.type == MemoType.todo)
              Row(
                children: [
                  Checkbox(value: memo.isDone ?? false, onChanged: onTodoCheck),
                  Expanded(
                    child: Text(
                      memo.content,
                      style: TextStyle(
                        decoration: (memo.isDone ?? false) ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                ],
              )
            else
              Text(memo.content),
            if (memo.imageUrl != null && memo.imageUrl!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(memo.imageUrl!, width: 180, height: 180, fit: BoxFit.cover),
                ),
              ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                _formatTime(memo.createdAt),
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _formatTime(DateTime dt) {
  return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
}
