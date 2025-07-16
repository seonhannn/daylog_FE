import 'package:flutter/cupertino.dart';
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
              color: selected ? CupertinoColors.activeBlue : CupertinoColors.transparent,
              border: Border.all(
                color: selected ? CupertinoColors.activeBlue : CupertinoColors.systemGrey,
                width: 1,
              ),
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
      color: CupertinoColors.systemGroupedBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _circleRadio(MemoType.memo, '메모'),
              const SizedBox(width: 12),
              _circleRadio(MemoType.todo, '할일'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: CupertinoTextField(
                  controller: _controller,
                  placeholder: '메모를 입력하세요.',
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: CupertinoColors.systemGrey4, width: 1),
                  ),
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(width: 8),
              CupertinoButton(
                padding: const EdgeInsets.all(0),
                minSize: 36,
                color: CupertinoColors.activeBlue,
                borderRadius: BorderRadius.circular(20),
                child: const Icon(
                  CupertinoIcons.arrow_up_circle_fill,
                  color: CupertinoColors.white,
                  size: 22,
                ),
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
        ],
      ),
    );
  }
}
