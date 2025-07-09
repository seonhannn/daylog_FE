import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/memo.dart';
import '../providers/date_provider.dart';
import '../providers/memo_provider.dart';

class MemoInput extends ConsumerStatefulWidget {
  const MemoInput({super.key});

  @override
  ConsumerState<MemoInput> createState() => _MemoInputState();
}

class _MemoInputState extends ConsumerState<MemoInput> {
  MemoType _selectedType = MemoType.memo;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          DropdownButton<MemoType>(
            value: _selectedType,
            items: const [
              DropdownMenuItem(value: MemoType.memo, child: Text('메모')),
              DropdownMenuItem(value: MemoType.notice, child: Text('공지')),
              DropdownMenuItem(value: MemoType.todo, child: Text('할일')),
            ],
            onChanged: (v) {
              if (v != null) setState(() => _selectedType = v);
            },
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: '메모를 입력하세요',
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: () {
              // TODO: 이미지 첨부 기능 (UI만)
            },
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              final text = _controller.text.trim();
              if (text.isEmpty) return;
              final newMemo = Memo(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                userId: 'user1',
                content: text,
                type: _selectedType,
                memoDate: selectedDate,
                createdAt: DateTime.now(),
                isDone: _selectedType == MemoType.todo ? false : null,
              );
              ref.read(memoListProvider.notifier).update((state) => [...state, newMemo]);
              _controller.clear();
              setState(() => _selectedType = MemoType.memo);
            },
          ),
        ],
      ),
    );
  }
}
