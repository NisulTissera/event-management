import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../widgets/app_background.dart';

class FeedbackScreen extends StatefulWidget {
  final Event event;

  const FeedbackScreen(
      {super.key, required this.event});

  @override
  State<FeedbackScreen> createState() =>
      _FeedbackScreenState();
}

class _FeedbackScreenState
    extends State<FeedbackScreen> {
  final TextEditingController controller =
  TextEditingController();
  int rating = 0;

  void submitFeedback() {
    if (controller.text.isEmpty ||
        rating == 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
              "Please enter feedback and select rating"),
        ),
      );
      return;
    }

    Navigator.pop(context);
  }

  Widget buildStar(int index) {
    return IconButton(
      onPressed: () {
        setState(() {
          rating = index;
        });
      },
      icon: Icon(
        Icons.star,
        color: index <= rating
            ? Colors.amber
            : Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(title: const Text("Event Feedback")),
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
                Text(widget.event.title),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: List.generate(
                      5,
                          (index) =>
                          buildStar(
                              index + 1)),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: controller,
                  maxLines: 4,
                  decoration:
                  const InputDecoration(
                      labelText:
                      "Enter feedback"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed:
                  submitFeedback,
                  child: const Text(
                      "Submit"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}