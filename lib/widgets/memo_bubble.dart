import 'dart:ui';

import 'package:flutter/material.dart';
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
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xffA5BFCC).withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
                            decoration: (memo.isDone ?? false) ? TextDecoration.lineThrough : null,
                          ),
                        ),
                      ],
                    )
                    : Text(memo.content),
          ),
        ],
      ),
    );
  }
}

String _formatTime(DateTime dt) {
  return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
}
