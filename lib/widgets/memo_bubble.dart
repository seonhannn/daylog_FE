import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:frontend/widgets/custom_checkbox.dart';
import '../models/memo.dart';

class MemoBubble extends StatelessWidget {
  final Memo memo;
  final void Function(bool?)? onTodoCheck;
  const MemoBubble({super.key, required this.memo, this.onTodoCheck});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            _formatTime(memo.createdAt),
            style: const TextStyle(fontSize: 10, color: CupertinoColors.systemGrey),
          ),
          Container(
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey5,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.systemGrey.withOpacity(0.15),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            margin: const EdgeInsets.only(left: 8),
            child:
                memo.type == MemoType.todo
                    ? Row(
                      children: [
                        CustomCheckbox(value: memo.isDone ?? false, onChanged: onTodoCheck),
                        const SizedBox(width: 8),
                        Text(
                          memo.content,
                          style: TextStyle(
                            fontSize: 15,
                            color: CupertinoColors.label,
                            decoration: (memo.isDone ?? false) ? TextDecoration.lineThrough : null,
                          ),
                        ),
                      ],
                    )
                    : Text(
                      memo.content,
                      style: const TextStyle(fontSize: 15, color: CupertinoColors.label),
                    ),
          ),
        ],
      ),
    );
  }
}

String _formatTime(DateTime dt) {
  return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
}
