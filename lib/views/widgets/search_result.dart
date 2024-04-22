import 'package:checkedin/views/widgets/modals/reservation_confirm_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'package:checkedin/views/utils/AppColor.dart';

class SearchResult extends StatefulWidget {
  final String airline;
  final String airlineLogo;
  final Timestamp arrivalTimestamp;
  final String departureAirportCode;
  final String departureAirportName;
  final String departureCity;
  final String departureCountry;
  final Timestamp departureTimestamp;
  final String destinationAirportCode;
  final String destinationAirportName;
  final String destinationCity;
  final String destinationCountry;
  final String flightDurationTime;
  final String name;
  final String bookingReference;

  const SearchResult({
    super.key,
    required this.airline,
    required this.airlineLogo,
    required this.arrivalTimestamp,
    required this.departureAirportCode,
    required this.departureAirportName,
    required this.departureCity,
    required this.departureCountry,
    required this.departureTimestamp,
    required this.destinationAirportCode,
    required this.destinationAirportName,
    required this.destinationCity,
    required this.destinationCountry,
    required this.flightDurationTime,
    required this.name,
    required this.bookingReference,
  });

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  String formatDate(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    return formattedDate;
  }

  void confirmBooking() async {
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users_history')
        .doc(user!.uid)
        .collection('booking_details')
        .doc(widget.bookingReference)
        .set({
      "name": widget.name,
      "departure_timestamp": widget.departureTimestamp,
      "airline": widget.airline,
      "airline_logo": widget.airlineLogo,
      "departure_city": widget.departureCity,
      "departure_country": widget.departureCountry,
      "departure_airport_name": widget.departureAirportName,
      "departure_airport_code": widget.departureAirportCode,
      "arrival_timestamp": widget.arrivalTimestamp,
      "destination_city": widget.destinationCity,
      "destination_country": widget.destinationCountry,
      "destination_airport_name": widget.destinationAirportName,
      "destination_airport_code": widget.departureAirportCode,
      "flight_duration_time": widget.flightDurationTime,
      "submission_date": Timestamp.now(),
    });

    if (!mounted) return;

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) {
          return const ReservationConfirmModal();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display the airline name and logo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.airline,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.network(
                widget.airlineLogo,
                width: 70,
                height: 70,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Display the passenger name
          Text(
            'Passenger: ${widget.name}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Display the departure and arrival information
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Departure',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${widget.departureAirportName} (${widget.departureAirportCode}) - ${widget.departureCity}, ${widget.departureCountry}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                'Departure Time: ${formatDate(widget.departureTimestamp)}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Arrival',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${widget.destinationAirportName} (${widget.destinationAirportCode}) - ${widget.destinationCity}, ${widget.destinationCountry}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                'Arrival Time: ${formatDate(widget.arrivalTimestamp)}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          // Display the flight duration
          Text(
            'Flight Duration: ${int.parse(widget.flightDurationTime) ~/ 60} hours ${int.parse(widget.flightDurationTime) % 60 > 0 ? 'and ${int.parse(widget.flightDurationTime) % 60} minutes' : ''}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Display the confirmation button
          Container(
            margin: const EdgeInsets.only(top: 32, bottom: 6),
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: ElevatedButton(
              onPressed: confirmBooking,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: AppColor.primarySoft,
              ),
              child: Text(
                'Confirm Flight',
                style: TextStyle(
                    color: AppColor.whiteSoft,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'inter'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
