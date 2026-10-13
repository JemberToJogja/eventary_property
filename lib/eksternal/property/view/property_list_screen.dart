import 'package:eventary_prototype/eksternal/home/model/external_property.dart';
import 'package:eventary_prototype/eksternal/property/data/dummy_external_properties.dart';
import 'package:flutter/material.dart';

class PropertyListScreen extends StatefulWidget {
  const PropertyListScreen({
    super.key,
    this.showNavbar = true,
    this.onPropertyTap,
  });

  /// Navbar ditampilkan ketika halaman dibuka sendiri.
  ///
  /// Jika halaman dibuka melalui ExternalShellScreen,
  /// gunakan showNavbar: false agar tidak ada navbar kedua.
  final bool showNavbar;

  /// Callback ketika user memilih sebuah property.
  ///
  /// Digunakan oleh ExternalShellScreen untuk membuka
  /// PropertyDetailScreen tanpa Navigator.push().
  final ValueChanged<ExternalProperty>? onPropertyTap;

  @override
  State<PropertyListScreen> createState() =>
      _PropertyListScreenState();
}

class _PropertyListScreenState
    extends State<PropertyListScreen> {
  // ==========================================================
  // THEME
  // ==========================================================

  static const Color navy =
      Color(0xFF172033);

  static const Color gold =
      Color(0xFFC09B60);

  static const Color background =
      Color(0xFFF7F7F5);

  static const Color textGrey =
      Color(0xFF6F747C);

  // ==========================================================
  // FILTER STATE
  // ==========================================================

  String selectedCategory = 'All';

  String searchQuery = '';

  // ==========================================================
  // PROPERTY DATA
  // ==========================================================

  final List<ExternalProperty> properties =
      dummyExternalProperties;

  List<ExternalProperty> get filteredProperties {
    final query =
        searchQuery.trim().toLowerCase();

    return properties.where((property) {
      final categoryMatch =
          selectedCategory == 'All' ||
              property.category ==
                  selectedCategory;

      final searchMatch =
          query.isEmpty ||
              property.name
                  .toLowerCase()
                  .contains(query) ||
              property.location
                  .toLowerCase()
                  .contains(query);

      return categoryMatch &&
          searchMatch;
    }).toList();
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Navbar hanya ditampilkan jika halaman
            // dibuka tanpa ExternalShellScreen.
            if (widget.showNavbar)
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

  // ==========================================================
  // NAVBAR
  // ==========================================================

  Widget _navbar(BuildContext context) {
    return Container(
      height: 78,
      width: double.infinity,
      color: Colors.white,
      padding:
          const EdgeInsets.symmetric(
        horizontal: 70,
      ),
      child: Row(
        children: [
          // ======================================================
          // LOGO
          // ======================================================

          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'IVENTARIS',
                  style: TextStyle(
                    color: navy,
                    fontSize: 21,
                    fontWeight:
                        FontWeight.w800,
                    letterSpacing: 2.2,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'PROPERTY VISUALIZATION',
                  style: TextStyle(
                    color: gold,
                    fontSize: 7.5,
                    fontWeight:
                        FontWeight.w700,
                    letterSpacing: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          _navItem(
            'Home',
            onTap: () {
              Navigator.pop(context);
            },
          ),

          _navItem(
            'Properties',
            active: true,
          ),

          _navItem(
            'Map',
          ),

          _navItem(
            'About',
          ),

          const SizedBox(width: 20),

          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward_rounded,
              size: 16,
            ),
            label: const Text(
              'Request Rental',
            ),
            style:
                ElevatedButton.styleFrom(
              backgroundColor: navy,
              foregroundColor:
                  Colors.white,
              elevation: 0,
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(4),
              ),
              textStyle:
                  const TextStyle(
                fontSize: 12,
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(
    String title, {
    bool active = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius:
            BorderRadius.circular(6),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 10,
          ),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: active
                      ? navy
                      : textGrey,
                  fontSize: 13,
                  fontWeight: active
                      ? FontWeight.w700
                      : FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration:
                    const Duration(
                  milliseconds: 200,
                ),
                width: active ? 24 : 0,
                height: 2,
                color: gold,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // HEADER
  // ==========================================================

  Widget _header() {
    return Container(
      width: double.infinity,
      color: navy,
      padding:
          const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 75,
      ),
      child: LayoutBuilder(
        builder: (
          context,
          constraints,
        ) {
          final isMobile =
              constraints.maxWidth < 700;

          return Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'OUR PROPERTIES',
                style: TextStyle(
                  color: gold,
                  fontSize: 11,
                  fontWeight:
                      FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'Find a space that fits\n'
                'your needs.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize:
                      isMobile ? 34 : 44,
                  height: 1.15,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),

              const SizedBox(height: 18),

              ConstrainedBox(
                constraints:
                    const BoxConstraints(
                  maxWidth: 650,
                ),
                child: const Text(
                  'Explore our portfolio of properties '
                  'and event spaces available for business, '
                  'events, exhibitions, and other activities.',
                  style: TextStyle(
                    color:
                        Color(0xFFB8BFCA),
                    fontSize: 14,
                    height: 1.8,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ==========================================================
  // FILTER
  // ==========================================================

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
      padding:
          const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 28,
      ),
      child: LayoutBuilder(
        builder: (
          context,
          constraints,
        ) {
          final isMobile =
              constraints.maxWidth < 850;

          if (isMobile) {
            return Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                _searchField(),

                const SizedBox(height: 16),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      categories.map(
                    (category) {
                      return _categoryButton(
                        category,
                      );
                    },
                  ).toList(),
                ),
              ],
            );
          }

          return Row(
            children: [
              _searchField(),

              const Spacer(),

              Wrap(
                spacing: 8,
                children:
                    categories.map(
                  (category) {
                    return _categoryButton(
                      category,
                    );
                  },
                ).toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _searchField() {
    return SizedBox(
      width: 320,
      height: 44,
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
        decoration:
            InputDecoration(
          hintText:
              'Search properties...',
          hintStyle:
              const TextStyle(
            color: Color(0xFF999D9F),
            fontSize: 13,
          ),
          prefixIcon:
              const Icon(
            Icons.search,
            size: 19,
            color: textGrey,
          ),
          filled: true,
          fillColor: background,
          border:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(3),
            borderSide:
                BorderSide.none,
          ),
          enabledBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(3),
            borderSide:
                BorderSide.none,
          ),
          focusedBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(3),
            borderSide:
                const BorderSide(
              color: gold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _categoryButton(
    String category,
  ) {
    final selected =
        selectedCategory == category;

    return InkWell(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      borderRadius:
          BorderRadius.circular(3),
      child: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 11,
        ),
        decoration:
            BoxDecoration(
          color: selected
              ? navy
              : background,
          borderRadius:
              BorderRadius.circular(3),
          border: Border.all(
            color: selected
                ? navy
                : const Color(
                    0xFFE2E3DF,
                  ),
          ),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: selected
                ? Colors.white
                : textGrey,
            fontSize: 12,
            fontWeight: selected
                ? FontWeight.w600
                : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // PROPERTY GRID
  // ==========================================================

  Widget _propertyGrid() {
    final data =
        filteredProperties;

    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${data.length} Properties',
                style:
                    const TextStyle(
                  color: navy,
                  fontSize: 15,
                  fontWeight:
                      FontWeight.w700,
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
              builder: (
                context,
                constraints,
              ) {
                int columns = 3;

                if (constraints.maxWidth <
                    900) {
                  columns = 2;
                }

                if (constraints.maxWidth <
                    600) {
                  columns = 1;
                }

                final cardWidth =
                    (constraints.maxWidth -
                            ((columns - 1) *
                                24)) /
                        columns;

                return Wrap(
                  spacing: 24,
                  runSpacing: 30,
                  children:
                      data.map(
                    (property) {
                      return SizedBox(
                        width: cardWidth,
                        child:
                            _propertyCard(
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

  // ==========================================================
  // PROPERTY CARD
  // ==========================================================

  Widget _propertyCard(
    ExternalProperty property,
  ) {
    final bool available =
        property.status == 'Available';

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          // ======================================================
          // IMAGE
          // ======================================================

          Container(
            height: 240,
            width: double.infinity,
            color:
                const Color(0xFFE3E4DF),
            child: Stack(
              children: [
                const Center(
                  child: Icon(
                    Icons.business_rounded,
                    size: 70,
                    color:
                        Color(0xFF999C96),
                  ),
                ),

                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    color: available
                        ? Colors.white
                        : const Color(
                            0xFF777A75,
                          ),
                    child: Text(
                      property.status,
                      style:
                          TextStyle(
                        color: available
                            ? navy
                            : Colors.white,
                        fontSize: 10,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ======================================================
          // CONTENT
          // ======================================================

          Padding(
            padding:
                const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  property.category
                      .toString()
                      .toUpperCase(),
                  style:
                      const TextStyle(
                    color: gold,
                    fontSize: 10,
                    fontWeight:
                        FontWeight.w700,
                    letterSpacing: 1.4,
                  ),
                ),

                const SizedBox(height: 9),

                Text(
                  property.name,
                  maxLines: 2,
                  overflow:
                      TextOverflow.ellipsis,
                  style:
                      const TextStyle(
                    color: navy,
                    fontSize: 21,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 12),

                // LOCATION
                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons
                          .location_on_outlined,
                      color: textGrey,
                      size: 16,
                    ),

                    const SizedBox(width: 6),

                    Expanded(
                      child: Text(
                        property.location,
                        maxLines: 2,
                        overflow:
                            TextOverflow
                                .ellipsis,
                        style:
                            const TextStyle(
                          color: textGrey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 7),

                // AREA
                Row(
                  children: [
                    const Icon(
                      Icons
                          .square_foot_outlined,
                      color: textGrey,
                      size: 16,
                    ),

                    const SizedBox(width: 6),

                    Expanded(
                      child: Text(
                        property.area,
                        overflow:
                            TextOverflow
                                .ellipsis,
                        style:
                            const TextStyle(
                          color: textGrey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // DESCRIPTION
                Text(
                  property.description,
                  maxLines: 3,
                  overflow:
                      TextOverflow.ellipsis,
                  style:
                      const TextStyle(
                    color: textGrey,
                    fontSize: 12,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 20),

                // ==================================================
                // VIEW PROPERTY
                // ==================================================
                //
                // Tidak menggunakan Navigator.push().
                // Property dikirim kembali ke ExternalShellScreen.
                //

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      widget.onPropertyTap
                          ?.call(property);
                    },
                    style:
                        OutlinedButton
                            .styleFrom(
                      foregroundColor: navy,
                      side:
                          const BorderSide(
                        color:
                            Color(0xFFD8D9D5),
                      ),
                      padding:
                          const EdgeInsets
                              .symmetric(
                        vertical: 14,
                      ),
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          3,
                        ),
                      ),
                    ),
                    child:
                        const Text(
                      'View Property',
                      style:
                          TextStyle(
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // EMPTY STATE
  // ==========================================================

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.symmetric(
        vertical: 80,
      ),
      child: const Column(
        children: [
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
              fontWeight:
                  FontWeight.w700,
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

  // ==========================================================
  // FOOTER
  // ==========================================================

  Widget _footer() {
    return Container(
      width: double.infinity,
      color:
          const Color(0xFF101827),
      padding:
          const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 40,
      ),
      child: Row(
        children: [
          const Text(
            'IVENTARIS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight:
                  FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),

          const Spacer(),

          Text(
            'Property & Event Management Platform',
            style: TextStyle(
              color:
                  Colors.white.withOpacity(
                0.45,
              ),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}