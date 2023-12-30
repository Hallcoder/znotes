import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:znotes/constants.dart';
import 'package:znotes/constants.dart';
import 'package:znotes/constants.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 5, vsync: this);

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
    renderedTabs = [];
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(var tab in tabs){
      renderedTabs.add(Tab(child: tab["title"]));
      tabViews.add(Center)
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontSize:28.0),
        ),
        leading: Icon(Icons.menu, color: primaryIconColor),
        bottom: TabBar(
          labelColor: Colors.green,
          labelStyle: const TextStyle(
            fontSize: 18.0
          ),
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(width: 4.0,color: Colors.green)
          ),
          isScrollable:true,
          controller: _tabController,
          tabs: renderedTabs
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(color: primaryIconColor, Icons.search, size: 32.0),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(color: primaryIconColor, Icons.star_border_rounded,size: 32.0),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(color: primaryIconColor, Icons.sort_outlined,size: 32.0),
          )
        ],
      ),
      body:  TabBarView(
        controller: _tabController,
        children: tabViews,
      ),
    );
  }
}
