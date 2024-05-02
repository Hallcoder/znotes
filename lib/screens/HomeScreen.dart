import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:znotes/components/CustomGridView.dart';
import 'package:znotes/components/CustomListTile.dart';
import 'package:znotes/constants.dart';
import 'package:znotes/models/NotesProvider.dart';
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
  SortType currentSortFilter = SortType.byAlphabet;

  updateSortFilter(SortType newSortFilter) {
    setState(() {
      currentSortFilter = newSortFilter;
    });
  }
  TextEditingController searchController = TextEditingController();

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
            tab: tab),
      );
      searchController.addListener(_onSearchTextChanged);
      // TODO: implement so the GridView custom component receives arguments that tell it which notes to load from SharedPreferences and show.
    }
  }
  @override
  void dispose() {
    _tabController.dispose();
    searchController.dispose();
    super.dispose();
    renderedTabs = [];
    tabViews = [];
  }
  void _onSearchTextChanged() {
    // Get access to the NotesModel using Provider
    final notesModel = Provider.of<NotesModel>(context, listen: false);

    // Call the searchNotes method with the new text value
    notesModel.searchNotes(searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesModel>(context);
    print("Notes from provider: ${notesProvider.notes}");
    void searchNotes(String val){
      notesProvider.searchNotes(val);
    }
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
        title: notesProvider.isSearching
            ? TextField(
                controller: searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search notes...',
                  border: InputBorder.none,
                ),
              )
            : const Text(
                "Notes",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 28.0),
              ),
        leading: notesProvider.isSearching
            ? GestureDetector(
                onTap: () {
                 notesProvider.updateSearching();
                },
                child: const Icon(Icons.arrow_back))
            : Icon(Icons.menu, color: primaryIconColor),
        bottom: TabBar(
            labelColor: Colors.green,
            labelStyle: const TextStyle(fontSize: 18.0),
            indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(width: 4.0, color: Colors.green)),
            isScrollable: true,
            controller: _tabController,
            tabs: renderedTabs),
        actions: notesProvider.isSearching
            ? []
            : [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        notesProvider.updateSearching();
                      },
                      child: Icon(
                          color: primaryIconColor, Icons.search, size: 32.0)),
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
      required this.currentSortFilter,
      required this.updateSortFilter});

  final SortType currentSortFilter;
  final Function updateSortFilter;

  @override
  State<SortMenu> createState() => _SortMenuState();
}

class _SortMenuState extends State<SortMenu> {
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
    final notesProvider = Provider.of<NotesModel>(context, listen: false);
    return showMenu(
        context: context,
        position: position,
        constraints: const BoxConstraints(
          maxWidth: 200.0,
        ),
        items: [
          PopupMenuItem(
            onTap: () {
              print("Before :${notesProvider.notes}");
              notesProvider.sortNotes(SortType.byDateChanged);
              print("After :${notesProvider.notes}");
              notesProvider.updateCurrentSortFilter(SortType.byDateChanged);
            },
            child: CustomListTile(
                text: "by date changed",
                isSelected:
                    notesProvider.currentSortFilter == SortType.byDateChanged),
          ),
          PopupMenuItem(
            onTap: () {
              notesProvider.sortNotes(SortType.byDateAdded);
              print(notesProvider.notes);
              notesProvider.updateCurrentSortFilter(SortType.byDateAdded);
            },
            child: CustomListTile(
                text: "by date added",
                isSelected:
                    notesProvider.currentSortFilter == SortType.byDateAdded),
          ),
          PopupMenuItem(
            onTap: () {
              notesProvider.sortNotes(SortType.byAlphabet);
              print(notesProvider.notes);
              notesProvider.updateCurrentSortFilter(SortType.byAlphabet);
            },
            child: CustomListTile(
                text: "alphabetical",
                isSelected:
                    notesProvider.currentSortFilter == SortType.byAlphabet),
          ),
          PopupMenuItem(
            onTap: () {
              notesProvider.sortNotes(SortType.byScheduledDate);
              print(notesProvider.notes);
              notesProvider.updateCurrentSortFilter(SortType.byScheduledDate);
            },
            child: CustomListTile(
                text: "by scheduled date",
                isSelected: notesProvider.currentSortFilter ==
                    SortType.byScheduledDate),
          ),
        ]);
  }
}
