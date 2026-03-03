import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../widgets/app_background.dart';

class RSVPscreen extends StatelessWidget {
  final Event event;

  const RSVPscreen(
      {super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(title: const Text("RSVP Confirmation")),
      body: AppBackground(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(20),
          ),
          child: Padding(
            padding:
            const EdgeInsets.all(25),
            child: Column(
              mainAxisSize:
              MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 80,
                ),
                const SizedBox(height: 20),
                Text(
                  "Registration Successful!",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),
                const SizedBox(height: 20),
                Text(event.title),
                Text(event.date),
                Text(event.location),
              ],
            ),
          ),
        ),
      ),
    );
  }
}