import 'package:eventary_prototype/eksternal/home/model/external_property.dart';
import 'package:eventary_prototype/eksternal/property/data/dummy_external_properties.dart';
import 'package:eventary_prototype/eksternal/property/view/property_detail_screen.dart';
import 'package:flutter/material.dart';

class PropertyListScreen extends StatefulWidget {
  const PropertyListScreen({super.key});

  @override
  State<PropertyListScreen> createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {
  static const Color navy = Color(0xFF172033);
  static const Color gold = Color(0xFFC09B60);
  static const Color background = Color(0xFFF7F7F5);
  static const Color textGrey = Color(0xFF6F747C);

  String selectedCategory = 'All';
  String searchQuery = '';

  final List<ExternalProperty> properties = dummyExternalProperties;

  List<ExternalProperty> get filteredProperties {
    return properties.where((property) {
      final categoryMatch =
          selectedCategory == 'All' || property.category == selectedCategory;

      final searchMatch = property.name
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          property.location.toLowerCase().contains(searchQuery.toLowerCase());

      return categoryMatch && searchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _navbar(context),
            _header(),
            _filterSection(),
            _propertyGrid(),
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
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
      ),
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
              'Home',
              style: TextStyle(
                color: textGrey,
                fontSize: 13,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Properties',
              style: TextStyle(
                color: navy,
                fontSize: 13,
                fontWeight: FontWeight.w700,
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
  // HEADER
  // =========================================================

  Widget _header() {
    return Container(
      width: double.infinity,
      color: navy,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 75,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'OUR PROPERTIES',
            style: TextStyle(
              color: gold,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Find a space that fits\nyour needs.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 44,
              height: 1.15,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 18),
          SizedBox(
            width: 600,
            child: Text(
              'Explore our portfolio of properties and event '
              'spaces available for business, events, exhibitions, '
              'and other activities.',
              style: TextStyle(
                color: Color(0xFFB8BFCA),
                fontSize: 14,
                height: 1.8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // FILTER
  // =========================================================

  Widget _filterSection() {
    const categories = [
      'All',
      'Mall',
      'Event Venue',
      'Office',
      'Commercial',
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 28,
      ),
      child: Row(
        children: [
          // SEARCH
          SizedBox(
            width: 320,
            height: 44,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search properties...',
                hintStyle: const TextStyle(
                  color: Color(0xFF999D9F),
                  fontSize: 13,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 19,
                  color: textGrey,
                ),
                filled: true,
                fillColor: background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const Spacer(),

          ...categories.map(
            (category) => Padding(
              padding: const EdgeInsets.only(left: 8),
              child: _categoryButton(category),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryButton(String category) {
    final selected = selectedCategory == category;

    return InkWell(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: selected ? navy : background,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            color: selected ? navy : const Color(0xFFE2E3DF),
          ),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: selected ? Colors.white : textGrey,
            fontSize: 12,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // =========================================================
  // PROPERTY GRID
  // =========================================================

  Widget _propertyGrid() {
    final data = filteredProperties;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${data.length} Properties',
                style: const TextStyle(
                  color: navy,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              const Text(
                'Showing available properties',
                style: TextStyle(
                  color: textGrey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          if (data.isEmpty)
            _emptyState()
          else
            LayoutBuilder(
              builder: (context, constraints) {
                int columns = 3;

                if (constraints.maxWidth < 900) {
                  columns = 2;
                }

                if (constraints.maxWidth < 600) {
                  columns = 1;
                }

                final cardWidth =
                    (constraints.maxWidth - ((columns - 1) * 24)) / columns;

                return Wrap(
                  spacing: 24,
                  runSpacing: 30,
                  children: data.map(
                    (property) {
                      return SizedBox(
                        width: cardWidth,
                        child: _propertyCard(
                          property,
                        ),
                      );
                    },
                  ).toList(),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _propertyCard(
    ExternalProperty property,
  ) {
    final bool available = property.status == 'Available';

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE
          Container(
            height: 240,
            width: double.infinity,
            color: const Color(0xFFE3E4DF),
            child: Stack(
              children: [
                const Center(
                  child: Icon(
                    Icons.business_rounded,
                    size: 70,
                    color: Color(0xFF999C96),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    color: available ? Colors.white : const Color(0xFF777A75),
                    child: Text(
                      property.status,
                      style: TextStyle(
                        color: available ? navy : Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // CONTENT
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  property.category.toString().toUpperCase(),
                  style: const TextStyle(
                    color: gold,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  property.name,
                  style: const TextStyle(
                    color: navy,
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: textGrey,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        property.location,
                        style: const TextStyle(
                          color: textGrey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    const Icon(
                      Icons.square_foot_outlined,
                      color: textGrey,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      property.area,
                      style: const TextStyle(
                        color: textGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  property.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: textGrey,
                    fontSize: 12,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PropertyDetailScreen(
                                property: property,
                              ),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: navy,
                          side: const BorderSide(
                            color: Color(0xFFD8D9D5),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        child: const Text(
                          'View Property',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: available ? () {} : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: navy,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: const Color(
                            0xFFE1E2DE,
                          ),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        child: const Text(
                          'Rent Space',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // EMPTY STATE
  // =========================================================

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 80,
      ),
      child: Column(
        children: const [
          Icon(
            Icons.search_off_rounded,
            size: 50,
            color: Color(0xFF999C96),
          ),
          SizedBox(height: 16),
          Text(
            'No properties found',
            style: TextStyle(
              color: navy,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Try changing your search or filter.',
            style: TextStyle(
              color: textGrey,
              fontSize: 13,
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
