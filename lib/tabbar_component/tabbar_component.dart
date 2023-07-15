import 'package:flutter/material.dart';

class TabBarComponent extends StatefulWidget {
  TabBarComponent({super.key, required this.tabs, required this.tabComponents});

  final List<Widget> tabs;
  final List<Widget> tabComponents;
//  [
//               Tab(text: 'Tab 1'),
//               Tab(text: 'Tab 2'),
//               Tab(text: 'Tab 3'),
//             ]

// [
//           Center(child: Text('Content of Tab 1')),
//           Center(child: Text('Content of Tab 2')),
//           Center(child: Text('Content of Tab 3')),
//         ]
  @override
  _TabBarComponentState createState() => _TabBarComponentState();
}

class _TabBarComponentState extends State<TabBarComponent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: widget.tabs.length,
        vsync: this); // Replace '3' with the number of tabs you want
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(12)),
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            labelStyle: const TextStyle(
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w800,
            ),
            unselectedLabelColor: const Color(0xFF5A546D),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w800,
            ),
            indicatorPadding: const EdgeInsets.all(3.0),
            indicator: BoxDecoration(
              color: const Color(0xFF5A546D),
              borderRadius: BorderRadius.circular(12),
            ),
            tabs: widget.tabs,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: widget.tabComponents,
      ),
    );
  }
}
