import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:znotes/components/CustomGridView.dart';
import 'package:znotes/components/CustomListTile.dart';
import 'package:znotes/constants.dart';
import 'package:znotes/routers/router.gr.dart';
import 'package:znotes/utils/content_types.dart';

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
  late List<Note> sortedNotes;
  SortType currentSortFilter = SortType.byAlphabet;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
    renderedTabs = [];
    tabViews = [];
  }

  updateSortFilter(SortType newSortFilter) {
    setState(() {
      currentSortFilter = newSortFilter;
    });
  }

  @override
  void initState() {
    super.initState();
    sortedNotes = testNotes;
    for (var tab in tabs) {
      renderedTabs.add(Tab(child: tab["title"]));
      tabViews.add(
        CustomGridView(
            filter: tab["child"],
            options: tab["options"],
            audioPlayer: audioPlayer,
            tab: tab,
            testNotes: sortedNotes),
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
            shape: const CircleBorder(),
            backgroundColor: Colors.green,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {},
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
            onTap: () {
              context.router.push(const FavoritesRoute());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                  color: primaryIconColor,
                  Icons.star_border_rounded,
                  size: 32.0),
            ),
          ),
          SortMenu(
              sortedNotes: sortedNotes,
              currentSortFilter: currentSortFilter,
              updateSortFilter: updateSortFilter)
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabViews,
      ),
    );
  }
}

class SortMenu extends StatefulWidget {
  const SortMenu(
      {super.key,
      required this.sortedNotes,
      required this.currentSortFilter,
      required this.updateSortFilter});

  final List<Note> sortedNotes;
  final SortType currentSortFilter;
  final Function updateSortFilter;

  @override
  State<SortMenu> createState() => _SortMenuState();
}

class _SortMenuState extends State<SortMenu> {
  void sortNotes() {
    widget.sortedNotes.sort((a, b) {
      switch (widget.currentSortFilter) {
        case SortType.byDateChanged:
          if (a.modifiedDate.isAfter(b.modifiedDate)) {
            return -1;
          } else {
            return 1;
          }
        case SortType.byAlphabet:
          return a.titleDescription.compareTo(b.titleDescription);
        case SortType.byDateAdded:
          if (a.createdAt.isAfter(b.createdAt)) {
            return -1;
          } else {
            return 1;
          }
        case SortType.byScheduledDate:
          if (a.dueDate.isAfter(b.dueDate)) {
            return -1;
          } else {
            return 1;
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Icon(color: primaryIconColor, Icons.sort_outlined, size: 32.0),
      onTap: () {
        showDropdownMenu(context);
      },
    );
  }

  Future<dynamic> showDropdownMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final Offset bottomRightPosition = button
        .localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay);

    final RelativeRect position = RelativeRect.fromLTRB(
      bottomRightPosition.dx, // Adjust this value based on the menu width
      bottomRightPosition.dy + 10,
      // Adjust this value based on the menu height
      bottomRightPosition.dx,
      bottomRightPosition.dy,
    );
    return showMenu(
        context: context,
        position: position,
        constraints: const BoxConstraints(
          maxWidth: 200.0,
        ),
        items: [
          PopupMenuItem(
            onTap: () {
              print("Two in one");
              sortNotes();
              widget.updateSortFilter(SortType.byDateChanged);
            },
            child: CustomListTile(
                text: "by date changed",
                isSelected: widget.currentSortFilter == SortType.byDateChanged),
          ),
          PopupMenuItem(
            onTap: () {
              sortNotes();
              widget.updateSortFilter(SortType.byDateAdded);
            },
            child: CustomListTile(
                text: "by date added",
                isSelected: widget.currentSortFilter == SortType.byDateAdded),
          ),
          PopupMenuItem(
            onTap: () {
              sortNotes();
              widget.updateSortFilter(SortType.byAlphabet);
            },
            child: CustomListTile(
                text: "alphabetical",
                isSelected: widget.currentSortFilter == SortType.byAlphabet),
          ),
          PopupMenuItem(
            onTap: () {
              sortNotes();
              widget.updateSortFilter(SortType.byScheduledDate);
            },
            child: CustomListTile(
                text: "by scheduled date",
                isSelected:
                    widget.currentSortFilter == SortType.byScheduledDate),
          ),
        ]);
  }
}
