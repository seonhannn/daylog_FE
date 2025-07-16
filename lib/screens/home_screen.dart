import 'package:flutter/cupertino.dart';
import '../widgets/date_selector.dart';
import '../widgets/memo_list.dart';
import '../widgets/memo_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _memoScrollController = ScrollController();

  @override
  void dispose() {
    _memoScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Daylog'),
        backgroundColor: CupertinoColors.systemGroupedBackground,
        border: null,
      ),
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              // 메모 리스트와 입력창
              Column(
                children: [
                  Expanded(
                    child: MemoList(scrollController: _memoScrollController, topPadding: 100),
                  ),
                  const MemoInput(),
                ],
              ),
              // 날짜 선택 바와 겹치는 부분만 불투명 오버레이
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: 100, // 날짜 선택 바 높이와 동일하게
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGroupedBackground.withOpacity(0.85),
                    ),
                  ),
                ),
              ),
              // 날짜 선택 바 (투명도 조절 위해 Opacity로 감쌀 예정)
              DateSelector(memoScrollController: _memoScrollController),
            ],
          ),
        ),
      ),
    );
  }
}
