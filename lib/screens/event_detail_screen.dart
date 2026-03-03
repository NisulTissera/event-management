import 'package:flutter/material.dart';
import '../models/event_model.dart';
import 'rsvp_screen.dart';

class EventDetailScreen extends StatelessWidget {
  final Event event;

  const EventDetailScreen({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [

          /// ================= APP BAR WITH IMAGE =================
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: const Color(0xFF4A90E2),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                event.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [

                  // Event Image
                  event.image.isNotEmpty
                      ? Image.network(
                    event.image,
                    fit: BoxFit.cover,
                  )
                      : Container(
                    color: Colors.grey[300],
                  ),

                  // Gradient overlay
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black54,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// ================= CONTENT =================
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF4F6FA),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// Title
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// Info Cards
                    _infoTile(
                        Icons.calendar_today,
                        "Date",
                        event.date),
                    const SizedBox(height: 12),

                    _infoTile(
                        Icons.access_time,
                        "Time",
                        event.time),
                    const SizedBox(height: 12),

                    _infoTile(
                        Icons.location_on,
                        "Location",
                        event.location),
                    const SizedBox(height: 12),

                    /// Price Badge
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A90E2)
                            .withOpacity(0.1),
                        borderRadius:
                        BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.attach_money,
                            color: Color(0xFF4A90E2),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            event.price == "0" ||
                                event.price
                                    .toLowerCase() ==
                                    "free"
                                ? "Free Event"
                                : "Price: LKR ${event.price}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight:
                              FontWeight.bold,
                              color:
                              Color(0xFF4A90E2),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// Description Title
                    const Text(
                      "About Event",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// Description Box
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Text(
                        event.description.isEmpty
                            ? "No description available."
                            : event.description,
                        style: const TextStyle(
                          height: 1.5,
                          fontSize: 15,
                        ),
                      ),
                    ),

                    const SizedBox(height: 35),

                    /// RSVP BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        icon: const Icon(
                            Icons.event_available),
                        label: const Text(
                          "Register / RSVP",
                          style: TextStyle(
                              fontSize: 16),
                        ),
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(
                              0xFF4A90E2),
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius
                                .circular(15),
                          ),
                          elevation: 4,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  RSVPscreen(
                                      event:
                                      event),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= INFO TILE WIDGET =================
  Widget _infoTile(
      IconData icon,
      String title,
      String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withOpacity(0.05),
            blurRadius: 8,
          )
        ],
      ),
      child: Row(
        children: [
          Icon(icon,
              color:
              const Color(0xFF4A90E2)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight:
                    FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}