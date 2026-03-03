import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../services/api_service.dart';
import '../widgets/event_card.dart';
import '../widgets/app_background.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Event>> _eventsFuture;
  List<Event> _allEvents = [];
  List<Event> _filteredEvents = [];

  String selectedCategory = "All";
  String searchQuery = "";

  final List<String> categories = [
    "All",
    "Workshop",
    "Sports",
    "Cultural",
    "Academic",
    "Free",
  ];

  @override
  void initState() {
    super.initState();
    _eventsFuture = ApiService.fetchEvents();
  }

  void _applyFilters() {
    List<Event> events = _allEvents;

    if (selectedCategory != "All") {
      if (selectedCategory == "Free") {
        events = events
            .where((e) =>
        e.price == "0" || e.price.toLowerCase() == "free")
            .toList();
      } else {
        events = events
            .where((e) =>
        e.category.toLowerCase() ==
            selectedCategory.toLowerCase())
            .toList();
      }
    }

    if (searchQuery.isNotEmpty) {
      events = events
          .where((e) =>
          e.title.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    setState(() {
      _filteredEvents = events;
    });
  }

  Future<void> _refreshEvents() async {
    setState(() {
      _eventsFuture = ApiService.fetchEvents();
    });
  }

  void _logout() {
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Campus Events"),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: AppBackground(
        child: FutureBuilder<List<Event>>(
          future: _eventsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(
                  child: Text("Failed to load events"));
            }

            if (!snapshot.hasData ||
                snapshot.data!.isEmpty) {
              return const Center(
                  child: Text("No events available."));
            }

            if (_allEvents.isEmpty) {
              _allEvents = snapshot.data!;
              _filteredEvents = _allEvents;
            }

            return RefreshIndicator(
              onRefresh: _refreshEvents,
              child: ListView(
                children: [
                  /// SEARCH
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search events...",
                        prefixIcon:
                        const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(15),
                        ),
                      ),
                      onChanged: (value) {
                        searchQuery = value;
                        _applyFilters();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding:
                      const EdgeInsets.symmetric(
                          horizontal: 10),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category =
                        categories[index];
                        return Padding(
                          padding:
                          const EdgeInsets.symmetric(
                              horizontal: 6),
                          child: ChoiceChip(
                            label: Text(category),
                            selected:
                            selectedCategory ==
                                category,
                            selectedColor:
                            const Color(
                                0xFF4A90E2),
                            labelStyle: TextStyle(
                              color: selectedCategory ==
                                  category
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            onSelected: (_) {
                              setState(() {
                                selectedCategory =
                                    category;
                                _applyFilters();
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// EVENTS
                  ..._filteredEvents.map(
                        (event) =>
                        EventCard(event: event),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}