import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:checkedin/models/core/recipe.dart';
import 'package:checkedin/models/helper/recipe_helper.dart';
import 'package:checkedin/views/screens/profile_page.dart';
import 'package:checkedin/views/screens/search_page.dart';
import 'package:checkedin/views/utils/AppColor.dart';
import 'package:checkedin/views/widgets/custom_app_bar.dart';
import 'package:checkedin/views/widgets/dummy_search_bar.dart';
import 'package:checkedin/views/widgets/booking_history_card.dart';
import 'package:iconly/iconly.dart';

class HomePage extends StatelessWidget {
  final List<Recipe> featuredRecipe = RecipeHelper.featuredRecipe;

  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users_history')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('booking_details')
          .orderBy('submission_date', descending: true)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text('No Data found!'),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }

        final hasHistory = snapshot.data!.docs.isNotEmpty;
        final previousBookings = snapshot.data!.docs;

        return Scaffold(
          appBar: CustomAppBar(
            title: const Text(
              'CheckedIn',
              style: TextStyle(
                fontFamily: 'inter',
                fontWeight: FontWeight.w700,
              ),
            ),
            showProfilePhoto: true,
            profilePhotoOnPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
          ),
          body: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                height: 350,
                color: Colors.white,
                child: Stack(
                  children: [
                    Container(
                      color: AppColor.primary,
                    ),
                    // Section 1 - Content
                    Column(
                      children: [
                        // Search Bar
                        DummySearchBar(
                          routeTo: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SearchPage()));
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          width: MediaQuery.of(context).size.width,
                          child: const Text(
                            'History',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'inter'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          height: 220,
                          child: hasHistory
                              ? ListView.separated(
                                  itemCount: previousBookings.length,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 16);
                                  },
                                  itemBuilder: (context, index) {
                                    return BookingHistoryCard(
                                        data: previousBookings[index]);
                                  },
                                )
                              : Text(
                                  'No previous history',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'inter',
                                    color: AppColor.whiteSoft,
                                  ),
                                ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.only(top: 32, bottom: 6),
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: AppColor.primarySoft,
                  ),
                  icon: Icon(
                    IconlyBold.calendar,
                    color: AppColor.whiteSoft,
                  ),
                  label: Text(
                    'Book Your Next Reservation',
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
      },
    );
  }
}
