import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/event.dart';
import '../providers/cart_provider.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({required this.event, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/event-details',
          arguments: event,
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              child: Image.network(
                event.image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/default_image.jpg',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text("Date: ${event.date}"),
                  Text("Location: ${event.location}"),
                  Text("Price: \$${event.price.toStringAsFixed(2)}"),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            '/event-details',
                            arguments: event,
                          );
                        },
                        child: Text("View Details"),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          cartProvider.addItem(event, 1);
                        },
                        child: Text("Add to Cart"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
