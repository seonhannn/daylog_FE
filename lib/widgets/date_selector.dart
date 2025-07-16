import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/date_provider.dart';
import '../providers/memo_provider.dart';
import '../models/memo.dart';

class DateSelector extends ConsumerStatefulWidget {
  const DateSelector({super.key});

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
      _jumpToTodayWeek();
    });
  }

  void _jumpToTodayWeek() {
    final selectedDate = ref.read(selectedDateProvider);
    final allDatesOfYear = getAllDatesOfYear(selectedDate.year);
    final today = DateTime.now();
    final todayIndex = allDatesOfYear.indexWhere(
      (d) => d.year == today.year && d.month == today.month && d.day == today.day,
    );
    if (todayIndex != -1) {
      final screenWidth = MediaQuery.of(context).size.width;
      final offset = (todayIndex - today.weekday % 7) * (screenWidth / 7);
      _scrollController.jumpTo(offset < 0 ? 0 : offset);
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                '${selectedDate.year.toString().padLeft(4, '0')}.${selectedDate.month.toString().padLeft(2, '0')}.${selectedDate.day.toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            IconButton(
              onPressed: () {
                ref.read(selectedDateProvider.notifier).state = DateTime.now();
                _jumpToTodayWeek(); // 오늘 날짜로 스크롤 이동
              },
              icon: const Icon(Icons.today),
            ),
          ],
        ),
        SizedBox(
          height: 80,
          width: screenWidth, // 한 화면에 7일만 보이게
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
                    width: screenWidth / 7, // 각 날짜의 width를 1/7로 고정
                    child: GestureDetector(
                      onTap: () => ref.read(selectedDateProvider.notifier).state = date,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (todos.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.only(top: 2),
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Color(0xff7E99A3),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${todos.length}',
                                style: const TextStyle(color: Colors.white, fontSize: 10),
                              ),
                            )
                          else
                            const SizedBox(height: 20), // 숫자 뱃지와 동일한 높이로 맞춤
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${date.day}',
                              style: TextStyle(
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Text(_weekdayKor(date.weekday), style: const TextStyle(fontSize: 12)),
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
