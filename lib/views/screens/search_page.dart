import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:checkedin/views/utils/AppColor.dart';
import 'package:checkedin/views/widgets/search_result.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchInputController = TextEditingController();
  var searchedBooking = [];
  var searchNotFound = false;
  var isSearching = false;

  @override
  Widget build(BuildContext context) {
    void submit(referenceNumber) async {
      setState(() {
        isSearching = true;
      });
      searchedBooking.clear();
      searchNotFound = false;

      final querySnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where(FieldPath.documentId,
              isEqualTo: referenceNumber.toString().toUpperCase())
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          searchedBooking.add(querySnapshot.docs[0]);
          isSearching = false;
        });
      }

      if (searchedBooking.isEmpty) {
        setState(() {
          searchNotFound = true;
          isSearching = false;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Search your flight',
          style: TextStyle(
            fontFamily: 'inter',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: AppColor.whiteSoft,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            color: AppColor.primary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Search TextField
                      Expanded(
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.only(right: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.primarySoft),
                          child: TextField(
                            controller: searchInputController,
                            onSubmitted: submit,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            maxLines: 1,
                            textInputAction: TextInputAction.search,
                            textCapitalization: TextCapitalization.characters,
                            decoration: InputDecoration(
                              hintText: 'Enter your booking reference',
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.2)),
                              prefixIconConstraints:
                                  const BoxConstraints(maxHeight: 20),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 17),
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              prefixIcon: Visibility(
                                visible: (searchInputController.text.isEmpty)
                                    ? true
                                    : false,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 12),
                                  child: SvgPicture.asset(
                                    'assets/icons/search.svg',
                                    width: 20,
                                    height: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isSearching)
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (!isSearching &&
              searchedBooking.isEmpty &&
              searchNotFound == false)
            Container(
              alignment: Alignment.bottomCenter,
              width: 400,
              height: 400,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/search-image.png'),
                ),
              ),
              child: const Text(
                'Start searching your flight',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'inter',
                ),
              ),
            ),
          if (!isSearching && searchedBooking.isEmpty && searchNotFound == true)
            Container(
              alignment: Alignment.bottomCenter,
              width: 400,
              height: 400,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/no-results.png'),
                ),
              ),
              child: const Text(
                'No results found',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'inter',
                ),
              ),
            ),
          if (!isSearching && searchedBooking.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SearchResult(
                airline: searchedBooking[0]['airline'],
                airlineLogo: searchedBooking[0]['airline_logo'],
                arrivalTimestamp: searchedBooking[0]['arrival_timestamp'],
                departureAirportCode: searchedBooking[0]
                    ['departure_airport_code'],
                departureAirportName: searchedBooking[0]
                    ['departure_airport_name'],
                departureCity: searchedBooking[0]['departure_city'],
                departureCountry: searchedBooking[0]['departure_country'],
                departureTimestamp: searchedBooking[0]['departure_timestamp'],
                destinationAirportCode: searchedBooking[0]
                    ['destination_airport_code'],
                destinationAirportName: searchedBooking[0]
                    ['destination_airport_name'],
                destinationCity: searchedBooking[0]['destination_city'],
                destinationCountry: searchedBooking[0]['destination_country'],
                flightDurationTime: searchedBooking[0]['flight_duration_time'],
                name: searchedBooking[0]['name'],
              ),
            ),
        ],
      ),
    );
  }
}
