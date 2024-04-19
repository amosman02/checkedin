import 'package:checkedin/views/utils/AppColor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
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
  });

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
                airline,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.network(
                airlineLogo,
                width: 50,
                height: 50,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Display the passenger name
          Text(
            'Passenger: $name',
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
                '$departureAirportName ($departureAirportCode) - $departureCity, $departureCountry',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                'Departure Time: ${departureTimestamp.toDate()}',
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
                '$destinationAirportName ($destinationAirportCode) - $destinationCity, $destinationCountry',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                'Arrival Time: ${arrivalTimestamp.toDate()}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          // Display the flight duration
          Text(
            'Flight Duration: ${int.parse(flightDurationTime) ~/ 60} hours ${int.parse(flightDurationTime) % 60 > 0 ? 'and ${int.parse(flightDurationTime) % 60} minutes' : ''}',
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
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: AppColor.primarySoft,
              ),
              child: Text(
                'Confirm Flight',
                style: TextStyle(
                    color: AppColor.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'inter'),
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
