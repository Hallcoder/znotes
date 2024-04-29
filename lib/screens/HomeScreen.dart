import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:znotes/components/CustomGridView.dart';
import 'package:znotes/constants.dart';
import 'package:znotes/routers/router.gr.dart';


@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: tabs.length, vsync: this);

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
    renderedTabs = [];
    tabViews = [];
  }

  @override
  void initState() {
    super.initState();
    for (var tab in tabs) {
      renderedTabs.add(Tab(child: tab["title"]));
      tabViews.add(
        CustomGridView(
          filter: tab["child"],
          options: tab["options"],
          audioPlayer: audioPlayer,
          tab:tab
        ),
      );
      // implement so the GridView custom component receives arguments that tell it which notes to load from SharedPreferences and show.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            shape:const CircleBorder(),
            backgroundColor: Colors.green,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {

            },
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text(
          "Notes",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 28.0),
        ),
        leading: Icon(Icons.menu, color: primaryIconColor),
        bottom: TabBar(
            labelColor: Colors.green,
            labelStyle: const TextStyle(fontSize: 18.0),
            indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(width: 4.0, color: Colors.green)),
            isScrollable: true,
            controller: _tabController,
            tabs: renderedTabs),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(color: primaryIconColor, Icons.search, size: 32.0),
          ),
          GestureDetector(
            onTap: (){
              context.router.push(const FavoritesRoute());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                  color: primaryIconColor, Icons.star_border_rounded, size: 32.0),
            ),
          ),
          PopupMenuButton(itemBuilder: (context)=>[
            const PopupMenuItem<String>(
              value: 'option1',
              child: Text('Sort by Option 1'),
            ),
            const PopupMenuItem<String>(
            value: 'option2',
            child: Text('Sort by Option 2'),
            ),
            const PopupMenuItem<String>(
            value: 'option3',
            child: Text('Sort by Option 3'),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Icon(color: primaryIconColor, Icons.sort_outlined, size: 32.0),
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabViews,
      ),
    );
  }
}
