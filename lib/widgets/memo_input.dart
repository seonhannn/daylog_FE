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

  Widget _circleRadio(MemoType type, String label) {
    final selected = _selectedType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected ? const Color(0xff7E99A3) : Colors.transparent,
              border: Border.all(color: selected ? const Color(0xff7E99A3) : Colors.grey, width: 1),
            ),
          ),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _circleRadio(MemoType.memo, '메모'),
              const SizedBox(width: 12),
              // _circleRadio(MemoType.notice, '공지'),
              // const SizedBox(width: 12),
              _circleRadio(MemoType.todo, '할일'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: '메모를 입력하세요.',
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
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
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(Icons.send, size: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
