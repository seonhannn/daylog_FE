import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/date_provider.dart';
import '../providers/memo_provider.dart';
import '../models/memo.dart';

class DateSelector extends ConsumerStatefulWidget {
  final ScrollController? memoScrollController;
  const DateSelector({super.key, this.memoScrollController});

  @override
  ConsumerState<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends ConsumerState<DateSelector> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _jumpToTodayCenter();
    });
  }

  void _jumpToTodayCenter() {
    final selectedDate = ref.read(selectedDateProvider);
    final allDatesOfYear = getAllDatesOfYear(selectedDate.year);
    final today = DateTime.now();
    final todayIndex = allDatesOfYear.indexWhere(
      (d) => d.year == today.year && d.month == today.month && d.day == today.day,
    );
    if (todayIndex != -1) {
      final screenWidth = MediaQuery.of(context).size.width;
      final cellWidth = screenWidth / 7;
      final offset = (todayIndex + 0.5) * cellWidth - screenWidth / 2;
      if (mounted && _scrollController.hasClients) {
        _scrollController.jumpTo(offset < 0 ? 0 : offset);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<DateTime> getAllDatesOfYear(int year) {
    final start = DateTime(year, 1, 1);
    final end = DateTime(year, 12, 31);
    return List.generate(end.difference(start).inDays + 1, (i) => start.add(Duration(days: i)));
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);
    final memoList = ref.watch(memoListProvider);
    final allDatesOfYear = getAllDatesOfYear(selectedDate.year);

    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 선택한 날짜
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${selectedDate.year.toString().padLeft(4, '0')}.${selectedDate.month.toString().padLeft(2, '0')}.${selectedDate.day.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: CupertinoColors.label,
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                minSize: 32,
                onPressed: () {
                  ref.read(selectedDateProvider.notifier).state = DateTime.now();
                  _jumpToTodayCenter();
                },
                child: const Icon(
                  CupertinoIcons.calendar_today,
                  size: 22,
                  color: CupertinoColors.activeBlue,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 80,
          width: screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            children:
                allDatesOfYear.map((date) {
                  final todos =
                      memoList
                          .where(
                            (m) =>
                                m.type == MemoType.todo &&
                                m.memoDate.year == date.year &&
                                m.memoDate.month == date.month &&
                                m.memoDate.day == date.day &&
                                (m.isDone != true),
                          )
                          .toList();
                  final isSelected =
                      date.year == selectedDate.year &&
                      date.month == selectedDate.month &&
                      date.day == selectedDate.day;
                  return SizedBox(
                    width: screenWidth / 7,
                    child: GestureDetector(
                      onTap: () => ref.read(selectedDateProvider.notifier).state = date,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 48,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                // 날짜 동그라미 (항상 아래쪽)
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color:
                                          isSelected
                                              ? CupertinoColors.white
                                              : CupertinoColors.transparent,
                                      shape: BoxShape.circle,
                                      border:
                                          isSelected
                                              ? Border.all(
                                                color: CupertinoColors.activeBlue,
                                                width: 2,
                                              )
                                              : null,
                                    ),
                                    child: Text(
                                      '${date.day}',
                                      style: TextStyle(
                                        fontWeight:
                                            isSelected ? FontWeight.bold : FontWeight.normal,
                                        fontSize: 18,
                                        color:
                                            isSelected
                                                ? CupertinoColors.activeBlue
                                                : CupertinoColors.label,
                                      ),
                                    ),
                                  ),
                                ),
                                // 할일 뱃지 (있을 때만)
                                if (todos.isNotEmpty)
                                  Positioned(
                                    top: 0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: CupertinoColors.activeBlue,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        '${todos.length}',
                                        style: const TextStyle(
                                          color: CupertinoColors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 2), // 날짜 동그라미와 요일 간격
                          Text(
                            _weekdayKor(date.weekday),
                            style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}

String _weekdayKor(int weekday) {
  const days = ['일', '월', '화', '수', '목', '금', '토'];
  return days[(weekday - 1) % 7];
}
