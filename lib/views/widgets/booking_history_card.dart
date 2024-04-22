import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BookingHistoryCard extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> data;
  const BookingHistoryCard({super.key, required this.data});

  String formatDate(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 220,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(data['airline_logo']),
          fit: BoxFit.cover,
        ),
      ),
      // BOoking Card Info
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: Container(
            height: 80,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black.withOpacity(0.26),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Booking Destination City
                Text(
                  data['destination_city'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 150 / 100,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'inter'),
                ),
                // Booking Date
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.alarm, size: 12, color: Colors.white),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text(
                          formatDate(data['departure_timestamp']),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
