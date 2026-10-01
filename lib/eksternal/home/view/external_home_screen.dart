import 'package:flutter/material.dart';

import '../../property/view/property_list_screen.dart';

class ExternalHomeScreen extends StatelessWidget {
  const ExternalHomeScreen({super.key});

  static const Color navy = Color(0xFF172033);
  static const Color gold = Color(0xFFC09B60);
  static const Color background = Color(0xFFF7F7F5);
  static const Color textGrey = Color(0xFF6F747C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _navbar(context),
            _hero(context),
            _featuredProperties(context),
            _mapSection(context),
            _eventsSection(context),
            _aboutSection(),
            _contactSection(),
            _footer(),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // NAVBAR
  // =========================================================

  Widget _navbar(BuildContext context) {
    return Container(
      height: 78,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: Row(
        children: [
          const Text(
            'EVENTARY',
            style: TextStyle(
              color: navy,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),

          const Spacer(),

          _navItem(
            'Home',
            onTap: () {},
            active: true,
          ),

          _navItem(
            'Properties',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const PropertyListScreen(),
                ),
              );
            },
          ),

          _navItem(
            'Map',
            onTap: () {},
          ),

          _navItem(
            'Events',
            onTap: () {},
          ),

          _navItem(
            'About',
            onTap: () {},
          ),

          const SizedBox(width: 24),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: navy,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            child: const Text(
              'Request Rental',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(
    String label, {
    required VoidCallback onTap,
    bool active = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          label,
          style: TextStyle(
            color: active ? navy : textGrey,
            fontSize: 13,
            fontWeight:
                active ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // =========================================================
  // HERO
  // =========================================================

  Widget _hero(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 570,
      color: navy,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 80,
                right: 40,
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PROPERTY & EVENT SPACE',
                    style: TextStyle(
                      color: gold,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Find a property\nyou’ll love.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 54,
                      height: 1.08,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 24),

                  const SizedBox(
                    width: 520,
                    child: Text(
                      'Discover carefully selected properties and event spaces '
                      'for business, events, exhibitions, and other activities.',
                      style: TextStyle(
                        color: Color(0xFFB7BDC8),
                        fontSize: 15,
                        height: 1.8,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const PropertyListScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: gold,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 17,
                          ),
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(3),
                          ),
                        ),
                        child: const Text(
                          'Explore Properties',
                        ),
                      ),

                      const SizedBox(width: 14),

                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(
                            color: Color(0xFF667083),
                          ),
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 17,
                          ),
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(3),
                          ),
                        ),
                        child: const Text(
                          'View Map',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 70,
              ),
              child: Container(
                height: 410,
                decoration: BoxDecoration(
                  color: const Color(0xFF222D41),
                  borderRadius:
                      BorderRadius.circular(4),
                ),
                child: const Center(
                  child: Icon(
                    Icons.location_city_rounded,
                    color: Color(0xFF68758A),
                    size: 110,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // FEATURED PROPERTIES
  // =========================================================

  Widget _featuredProperties(BuildContext context) {
    return Container(
      width: double.infinity,
      color: background,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 90,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'OUR PROPERTIES',
                      style: TextStyle(
                        color: gold,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.8,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Featured properties',
                      style: TextStyle(
                        color: navy,
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const PropertyListScreen(),
                    ),
                  );
                },
                child: const Text(
                  'View all properties →',
                  style: TextStyle(
                    color: navy,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          Row(
            children: [
              Expanded(
                child: _propertyCard(
                  name: 'Mall ABC',
                  category: 'Mall',
                  location: 'Jakarta Selatan',
                  area: '45.000 m²',
                ),
              ),

              const SizedBox(width: 24),

              Expanded(
                child: _propertyCard(
                  name: 'Mall XYZ',
                  category: 'Mall',
                  location: 'Jakarta Barat',
                  area: '32.500 m²',
                ),
              ),

              const SizedBox(width: 24),

              Expanded(
                child: _propertyCard(
                  name: 'Event Venue A',
                  category: 'Event Venue',
                  location: 'Jakarta Pusat',
                  area: '12.000 m²',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _propertyCard({
    required String name,
    required String category,
    required String location,
    required String area,
  }) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            height: 230,
            width: double.infinity,
            color: const Color(0xFFE5E5E0),
            child: const Center(
              child: Icon(
                Icons.business_rounded,
                size: 65,
                color: Color(0xFF9A9D97),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  category.toUpperCase(),
                  style: const TextStyle(
                    color: gold,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  name,
                  style: const TextStyle(
                    color: navy,
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 15,
                      color: textGrey,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        location,
                        style: const TextStyle(
                          color: textGrey,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(
                      Icons.square_foot_outlined,
                      size: 15,
                      color: textGrey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      area,
                      style: const TextStyle(
                        color: textGrey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                const Text(
                  'View property →',
                  style: TextStyle(
                    color: navy,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // MAP
  // =========================================================

  Widget _mapSection(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 90,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'EXPLORE BY LOCATION',
                  style: TextStyle(
                    color: gold,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.8,
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  'Find properties\non the map.',
                  style: TextStyle(
                    color: navy,
                    fontSize: 36,
                    height: 1.15,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  'Explore our property locations and find '
                  'the space that fits your needs.',
                  style: TextStyle(
                    color: textGrey,
                    fontSize: 14,
                    height: 1.7,
                  ),
                ),

                const SizedBox(height: 25),

                OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    'Explore Map',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 70),

          Expanded(
            flex: 2,
            child: Container(
              height: 390,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E3DE),
                borderRadius:
                    BorderRadius.circular(4),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(
                      Icons.map_outlined,
                      size: 90,
                      color: Color(0xFF999C96),
                    ),
                  ),

                  _mapMarker(
                    left: 110,
                    top: 90,
                    label: 'Mall ABC',
                  ),

                  _mapMarker(
                    right: 100,
                    top: 160,
                    label: 'Mall XYZ',
                  ),

                  _mapMarker(
                    left: 210,
                    bottom: 70,
                    label: 'Venue A',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mapMarker({
    double? left,
    double? right,
    double? top,
    double? bottom,
    required String label,
  }) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Column(
        children: [
          const Icon(
            Icons.location_on,
            color: navy,
            size: 30,
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 5,
            ),
            color: navy,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // EVENTS
  // =========================================================

  Widget _eventsSection(BuildContext context) {
    return Container(
      width: double.infinity,
      color: background,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 90,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'WHAT’S HAPPENING',
            style: TextStyle(
              color: gold,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.8,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'Upcoming events',
            style: TextStyle(
              color: navy,
              fontSize: 34,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 35),

          _eventItem(
            date: '10 OCT',
            title: 'Jakarta Fashion Week',
            location: 'Mall ABC',
            type: 'Exhibition',
          ),

          _eventItem(
            date: '20 OCT',
            title: 'Food Exhibition',
            location: 'Mall XYZ',
            type: 'Exhibition',
          ),

          _eventItem(
            date: '05 NOV',
            title: 'Music Festival',
            location: 'Event Venue A',
            type: 'Festival',
          ),
        ],
      ),
    );
  }

  Widget _eventItem({
    required String date,
    required String title,
    required String location,
    required String type,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 22,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE1E2DE),
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              date,
              style: const TextStyle(
                color: gold,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: navy,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          SizedBox(
            width: 170,
            child: Text(
              location,
              style: const TextStyle(
                color: textGrey,
                fontSize: 13,
              ),
            ),
          ),

          SizedBox(
            width: 100,
            child: Text(
              type,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: textGrey,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // ABOUT
  // =========================================================

  Widget _aboutSection() {
    return Container(
      width: double.infinity,
      color: navy,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 90,
      ),
      child: Row(
        children: [
          Expanded(
            child: const Text(
              'Connecting people\nwith the right space.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 38,
                height: 1.2,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(width: 100),

          Expanded(
            child: Text(
              'Eventary is a property management and '
              'discovery platform that brings properties, '
              'events, and rental services together in one place.',
              style: TextStyle(
                color: Colors.white.withOpacity(0.65),
                fontSize: 15,
                height: 1.9,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // CONTACT
  // =========================================================

  Widget _contactSection() {
    return Container(
      width: double.infinity,
      color: background,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 80,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'GET IN TOUCH',
                  style: TextStyle(
                    color: gold,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.8,
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  'Have a property inquiry?',
                  style: TextStyle(
                    color: navy,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: const [
                Text(
                  'Email',
                  style: TextStyle(
                    color: textGrey,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'hello@eventary.com',
                  style: TextStyle(
                    color: navy,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  'Phone',
                  style: TextStyle(
                    color: textGrey,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '+62 21 1234 5678',
                  style: TextStyle(
                    color: navy,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // FOOTER
  // =========================================================

  Widget _footer() {
    return Container(
      width: double.infinity,
      color: const Color(0xFF101827),
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 35,
      ),
      child: Row(
        children: [
          const Text(
            'EVENTARY',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),

          const Spacer(),

          Text(
            'Property & Event Management Platform',
            style: TextStyle(
              color: Colors.white.withOpacity(0.45),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}