import 'package:eventary_prototype/eksternal/home/model/external_property.dart';
import 'package:flutter/material.dart';



class PropertyDetailScreen extends StatelessWidget {
  final ExternalProperty property;

  const PropertyDetailScreen({
    super.key,
    required this.property,
  });

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
            _hero(),
            _overview(),
            _spaces(),
            _facilities(),
            _events(),
            _location(),
            _rentalBanner(),
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
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Text(
              'EVENTARY',
              style: TextStyle(
                color: navy,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
          ),

          const Spacer(),

          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Properties',
              style: TextStyle(
                color: textGrey,
                fontSize: 13,
              ),
            ),
          ),

          TextButton(
            onPressed: () {},
            child: const Text(
              'Map',
              style: TextStyle(
                color: textGrey,
                fontSize: 13,
              ),
            ),
          ),

          TextButton(
            onPressed: () {},
            child: const Text(
              'Events',
              style: TextStyle(
                color: textGrey,
                fontSize: 13,
              ),
            ),
          ),

          const SizedBox(width: 20),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: navy,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            child: const Text(
              'Request Rental',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // HERO
  // =========================================================

  Widget _hero() {
    return Container(
      width: double.infinity,
      height: 480,
      color: navy,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 70,
                right: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.category.toUpperCase(),
                    style: const TextStyle(
                      color: gold,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    property.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      height: 1.1,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Color(0xFFADB5C1),
                        size: 18,
                      ),
                      const SizedBox(width: 7),
                      Text(
                        property.location,
                        style: const TextStyle(
                          color: Color(0xFFADB5C1),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    color: Colors.white.withOpacity(0.1),
                    child: Text(
                      property.status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.only(
                right: 70,
                top: 45,
                bottom: 45,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF263248),
                borderRadius: BorderRadius.circular(4),
              ),
              child: property.image.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        property.image,
                        fit: BoxFit.cover,
                        errorBuilder: (
                          context,
                          error,
                          stackTrace,
                        ) {
                          return const Center(
                            child: Icon(
                              Icons.business_rounded,
                              color: Color(0xFF68758A),
                              size: 110,
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: Icon(
                        Icons.business_rounded,
                        color: Color(0xFF68758A),
                        size: 110,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // OVERVIEW
  // =========================================================

  Widget _overview() {
    return Container(
      width: double.infinity,
      color: background,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 75,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ABOUT THE PROPERTY',
                  style: TextStyle(
                    color: gold,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.8,
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'A space designed for your next experience.',
                  style: TextStyle(
                    color: navy,
                    fontSize: 32,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  property.description,
                  style: const TextStyle(
                    color: textGrey,
                    fontSize: 14,
                    height: 1.9,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 90),

          Expanded(
            flex: 3,
            child: Column(
              children: [
                _infoRow(
                  'Property Area',
                  property.area,
                ),
                _infoRow(
                  'Location',
                  property.location,
                ),
                _infoRow(
                  'Status',
                  property.status,
                ),
                _infoRow(
                  'Property Type',
                  property.category,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(
    String title,
    String value,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 18,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE0E1DD),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: textGrey,
                fontSize: 12,
              ),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: navy,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // AVAILABLE SPACES
  // =========================================================

  Widget _spaces() {
    final spaces = [
      {
        'name': 'Main Exhibition Hall',
        'area': '5.000 m²',
        'capacity': '2.000 people',
      },
      {
        'name': 'Event Ballroom',
        'area': '2.500 m²',
        'capacity': '800 people',
      },
      {
        'name': 'Outdoor Area',
        'area': '3.000 m²',
        'capacity': '1.500 people',
      },
    ];

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 75,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'AVAILABLE SPACES',
            style: TextStyle(
              color: gold,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.8,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'Choose the right space',
            style: TextStyle(
              color: navy,
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 35),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: spaces.map(
              (space) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 18,
                    ),
                    child: _spaceCard(space),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _spaceCard(
    Map<String, String> space,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: background,
        border: Border.all(
          color: const Color(0xFFE1E2DE),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 110,
            width: double.infinity,
            color: const Color(0xFFE1E2DE),
            child: const Center(
              child: Icon(
                Icons.meeting_room_outlined,
                size: 45,
                color: Color(0xFF92958F),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            space['name']!,
            style: const TextStyle(
              color: navy,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 14),

          _smallInfo(
            Icons.square_foot_outlined,
            space['area']!,
          ),

          const SizedBox(height: 7),

          _smallInfo(
            Icons.people_outline,
            space['capacity']!,
          ),

          const SizedBox(height: 18),

          const Text(
            'View space details →',
            style: TextStyle(
              color: navy,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallInfo(
    IconData icon,
    String text,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 15,
          color: textGrey,
        ),
        const SizedBox(width: 7),
        Text(
          text,
          style: const TextStyle(
            color: textGrey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // =========================================================
  // FACILITIES
  // =========================================================

  Widget _facilities() {
    final facilities = [
      'Parking Area',
      'Security',
      'Loading Dock',
      'Food Court',
      'Event Space',
      'Public Wi-Fi',
      'Restroom',
      'Prayer Room',
    ];

    return Container(
      width: double.infinity,
      color: background,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 75,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'FACILITIES',
            style: TextStyle(
              color: gold,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.8,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'Everything you need',
            style: TextStyle(
              color: navy,
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 30),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: facilities.map(
              (facility) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFFE0E1DD),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        size: 16,
                        color: gold,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        facility,
                        style: const TextStyle(
                          color: navy,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // EVENTS
  // =========================================================

  Widget _events() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 75,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'UPCOMING EVENTS',
            style: TextStyle(
              color: gold,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.8,
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'What’s happening here',
            style: TextStyle(
              color: navy,
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 30),

          _eventRow(
            '10 OCT',
            'Jakarta Fashion Week',
            'Exhibition',
          ),

          _eventRow(
            '20 OCT',
            'Food Exhibition',
            'Exhibition',
          ),

          _eventRow(
            '05 NOV',
            'Music Festival',
            'Festival',
          ),
        ],
      ),
    );
  }

  Widget _eventRow(
    String date,
    String title,
    String type,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
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
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: navy,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          Text(
            type,
            style: const TextStyle(
              color: textGrey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // LOCATION
  // =========================================================

  Widget _location() {
    return Container(
      width: double.infinity,
      color: background,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 75,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'LOCATION',
                  style: TextStyle(
                    color: gold,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.8,
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'Find us on the map.',
                  style: TextStyle(
                    color: navy,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 18),

                Text(
                  property.location,
                  style: const TextStyle(
                    color: textGrey,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Jakarta, Indonesia',
                  style: TextStyle(
                    color: textGrey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 60),

          Expanded(
            flex: 2,
            child: Container(
              height: 320,
              decoration: BoxDecoration(
                color: const Color(0xFFE1E2DE),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(
                      Icons.map_outlined,
                      size: 75,
                      color: Color(0xFF999C96),
                    ),
                  ),

                  const Positioned(
                    left: 220,
                    top: 130,
                    child: Icon(
                      Icons.location_on,
                      size: 42,
                      color: navy,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // RENTAL BANNER
  // =========================================================

  Widget _rentalBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        70,
        70,
        70,
        80,
      ),
      padding: const EdgeInsets.all(40),
      color: navy,
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'INTERESTED IN THIS PROPERTY?',
                  style: TextStyle(
                    color: gold,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.6,
                  ),
                ),

                SizedBox(height: 12),

                Text(
                  'Ready to rent this space?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  'Submit a rental request and our team '
                  'will contact you.',
                  style: TextStyle(
                    color: Color(0xFFADB5C1),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 30),

          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(gold),
              foregroundColor: WidgetStateProperty.all(
                Colors.white,
              ),
              elevation: WidgetStateProperty.all(0),
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 16,
                ),
              ),
            ),
            child: const Text(
              'Request Rental',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
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
        vertical: 40,
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