import 'package:eventary_prototype/eksternal/home/model/external_property.dart';
import 'package:flutter/material.dart';

class PropertyDetailScreen extends StatelessWidget {
  final ExternalProperty property;
  final bool showNavbar;
  final VoidCallback? onBack;
  final VoidCallback? onRequestRental;

  const PropertyDetailScreen({
    super.key,
    required this.property,
    this.showNavbar = true,
    this.onBack,
    this.onRequestRental,
  });

  // =========================================================
  // COLORS
  // =========================================================

  static const Color navy = Color(0xFF172033);
  static const Color gold = Color(0xFFC09B60);
  static const Color background = Color(0xFFF7F7F5);
  static const Color textGrey = Color(0xFF6F747C);
  static const Color border = Color(0xFFE5E5E1);

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (showNavbar) _navbar(context),

            _hero(),

            _overview(),

            _spaces(),

            _facilities(),

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
              if (onBack != null) {
                onBack!();
              } else {
                Navigator.pop(context);
              }
            },
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EVENTARY',
                  style: TextStyle(
                    color: navy,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'PROPERTY VISUALIZATION',
                  style: TextStyle(
                    color: gold,
                    fontSize: 7.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          TextButton(
            onPressed: () {
              if (onBack != null) {
                onBack!();
              } else {
                Navigator.pop(context);
              }
            },
            child: const Text(
              'Properties',
              style: TextStyle(
                color: textGrey,
                fontSize: 13,
              ),
            ),
          ),

          const SizedBox(width: 8),

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

          const SizedBox(width: 8),

          TextButton(
            onPressed: () {},
            child: const Text(
              'About',
              style: TextStyle(
                color: textGrey,
                fontSize: 13,
              ),
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
      color: navy,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 55,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1250,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // LEFT
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 55,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
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
                          fontSize: 50,
                          height: 1.08,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 18),

                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: Color(0xFFB8C0CF),
                            size: 18,
                          ),
                          const SizedBox(width: 7),
                          Text(
                            property.location,
                            style: const TextStyle(
                              color: Color(0xFFB8C0CF),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 22),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.10),
                          border: Border.all(
                            color: Colors.white.withOpacity(.12),
                          ),
                          borderRadius:
                              BorderRadius.circular(4),
                        ),
                        child: Text(
                          property.status,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      SizedBox(
                        width: 520,
                        child: Text(
                          property.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFFB8C0CF),
                            fontSize: 13,
                            height: 1.7,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // RIGHT - IMAGE
              Expanded(
                flex: 5,
                child: _heroImage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _heroImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: double.infinity,
            height: 340,
            child: property.image.isNotEmpty
                ? Image.network(
                    property.image,
                    fit: BoxFit.cover,
                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return _imagePlaceholder();
                    },
                  )
                : _imagePlaceholder(),
          ),
        ),

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _thumbnail(property.image),
            const SizedBox(width: 8),
            _thumbnail(property.image),
            const SizedBox(width: 8),
            _thumbnail(property.image),
          ],
        ),
      ],
    );
  }

  Widget _thumbnail(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: SizedBox(
        width: 68,
        height: 48,
        child: image.isNotEmpty
            ? Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) {
                  return _smallPlaceholder();
                },
              )
            : _smallPlaceholder(),
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: const Color(0xFF263248),
      child: const Center(
        child: Icon(
          Icons.business_rounded,
          color: Color(0xFF68758A),
          size: 85,
        ),
      ),
    );
  }

  Widget _smallPlaceholder() {
    return Container(
      color: const Color(0xFF344057),
      child: const Icon(
        Icons.image_outlined,
        color: Colors.white54,
        size: 20,
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
        vertical: 65,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1250,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
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

              const SizedBox(height: 12),

              const Text(
                'A space designed for your next experience.',
                style: TextStyle(
                  color: navy,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: 900,
                child: Text(
                  property.description,
                  style: const TextStyle(
                    color: textGrey,
                    fontSize: 14,
                    height: 1.8,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              Row(
                children: [
                  Expanded(
                    child: _infoCard(
                      Icons.square_foot_outlined,
                      property.area,
                      'Property Area',
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _infoCard(
                      Icons.business_outlined,
                      property.category,
                      'Property Type',
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _infoCard(
                      Icons.location_on_outlined,
                      property.location,
                      'Location',
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _infoCard(
                      Icons.check_circle_outline,
                      property.status,
                      'Status',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard(
    IconData icon,
    String value,
    String label,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: border,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: gold,
            size: 23,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: navy,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: const TextStyle(
                    color: textGrey,
                    fontSize: 11,
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
  // AVAILABLE SPACES
  // =========================================================

  Widget _spaces() {
    final spaces = [
      {
        'name': 'Main Exhibition Hall',
        'area': '5.000 m²',
        'capacity': '2.000 people',
        'image':
            'https://images.unsplash.com/photo-1497366754035-f200968a6e72?auto=format&fit=crop&w=900&q=80',
      },
      {
        'name': 'Event Ballroom',
        'area': '2.500 m²',
        'capacity': '800 people',
        'image':
            'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?auto=format&fit=crop&w=900&q=80',
      },
      {
        'name': 'Outdoor Area',
        'area': '3.000 m²',
        'capacity': '1.500 people',
        'image':
            'https://images.unsplash.com/photo-1507504031003-b417219a0fde?auto=format&fit=crop&w=900&q=80',
      },
    ];

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 70,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1250,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
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

              const SizedBox(height: 12),

              const Text(
                'Choose the right space',
                style: TextStyle(
                  color: navy,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 30),

              Row(
                children: spaces.map(
                  (space) {
                    return Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(
                          right: 15,
                        ),
                        child:
                            _spaceCard(space),
                      ),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _spaceCard(
    Map<String, String> space,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: border,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 175,
            width: double.infinity,
            child: Image.network(
              space['image']!,
              fit: BoxFit.cover,
              errorBuilder: (
                context,
                error,
                stackTrace,
              ) {
                return Container(
                  color: const Color(0xFFE4E5E1),
                  child: const Icon(
                    Icons.image_outlined,
                    size: 45,
                    color: Color(0xFF92958F),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  space['name']!,
                  style: const TextStyle(
                    color: navy,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    const Icon(
                      Icons.square_foot_outlined,
                      size: 15,
                      color: textGrey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      space['area']!,
                      style: const TextStyle(
                        color: textGrey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 18),
                    const Icon(
                      Icons.people_outline,
                      size: 15,
                      color: textGrey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      space['capacity']!,
                      style: const TextStyle(
                        color: textGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

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
          ),
        ],
      ),
    );
  }

  // =========================================================
  // FACILITIES
  // =========================================================

  Widget _facilities() {
    final facilities = [
      (
        Icons.directions_car_outlined,
        'Parking Area',
      ),
      (
        Icons.verified_user_outlined,
        'Security',
      ),
      (
        Icons.local_shipping_outlined,
        'Loading Dock',
      ),
      (
        Icons.restaurant_outlined,
        'Food Court',
      ),
      (
        Icons.groups_outlined,
        'Event Space',
      ),
      (
        Icons.wifi_outlined,
        'Public Wi-Fi',
      ),
      (
        Icons.wc_outlined,
        'Restroom',
      ),
      (
        Icons.mosque_outlined,
        'Prayer Room',
      ),
    ];

    return Container(
      width: double.infinity,
      color: background,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 65,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1250,
          ),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 310,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
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

                    const SizedBox(height: 10),

                    const Text(
                      'Everything you need',
                      style: TextStyle(
                        color: navy,
                        fontSize: 30,
                        height: 1.15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Facilities designed to support '
                      'your event and rental needs.',
                      style: TextStyle(
                        color: textGrey,
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 45),

              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  itemCount: facilities.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    mainAxisExtent: 68,
                  ),
                  itemBuilder:
                      (context, index) {
                    final item =
                        facilities[index];

                    return Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(8),
                        border: Border.all(
                          color: border,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item.$1,
                            color: gold,
                            size: 22,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              item.$2,
                              style:
                                  const TextStyle(
                                color: navy,
                                fontSize: 12,
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // LOCATION
  // =========================================================

  Widget _location() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 70,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1250,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
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

                    const SizedBox(height: 12),

                    const Text(
                      'Find us on the map.',
                      style: TextStyle(
                        color: navy,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: gold,
                          size: 21,
                        ),
                        const SizedBox(width: 9),
                        Expanded(
                          child: Text(
                            property.location,
                            style: const TextStyle(
                              color: textGrey,
                              fontSize: 14,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.map_outlined,
                        size: 17,
                      ),
                      label: const Text(
                        'View on Map',
                      ),
                      style:
                          OutlinedButton.styleFrom(
                        foregroundColor: navy,
                        side: const BorderSide(
                          color: navy,
                        ),
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 60),

              Expanded(
                flex: 6,
                child: Container(
                  height: 350,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7E8E4),
                    borderRadius:
                        BorderRadius.circular(8),
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

                      const Center(
                        child: Padding(
                          padding:
                              EdgeInsets.only(
                            left: 90,
                            top: 20,
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: navy,
                            size: 45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // RENTAL CTA
  // =========================================================

  Widget _rentalBanner() {
    return Container(
      width: double.infinity,
      color: background,
      padding: const EdgeInsets.fromLTRB(
        70,
        70,
        70,
        80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1250,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 45,
              vertical: 40,
            ),
            decoration: BoxDecoration(
              color: navy,
              borderRadius:
                  BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'INTERESTED IN THIS PROPERTY?',
                        style: TextStyle(
                          color: gold,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.6,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        'Ready to rent this space?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
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

                const SizedBox(width: 35),

                ElevatedButton(
                  onPressed: onRequestRental,
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor: gold,
                    foregroundColor:
                        Colors.white,
                    elevation: 0,
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 17,
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(6),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [
                      Text(
                        'Request Rental',
                        style: TextStyle(
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward,
                        size: 17,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1250,
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
                  color:
                      Colors.white.withOpacity(.45),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}