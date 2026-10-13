import 'package:flutter/material.dart';

import '../../../admin/models/property.dart';

import '../../map/view/external_map_screen.dart';
import '../../property/view/property_list_screen.dart';
import '../../property/view/property_detail_screen.dart';
import '../../rental/view/request_rental_screen.dart';

import '../../home/model/external_property.dart';

import 'external_home_screen.dart';

class ExternalShellScreen extends StatefulWidget {
  const ExternalShellScreen({
    super.key,
    this.onAboutTap,
    this.onRentalTap,
    this.onPropertyTap,
  });

  final VoidCallback? onAboutTap;
  final VoidCallback? onRentalTap;
  final ValueChanged<Property>? onPropertyTap;

  @override
  State<ExternalShellScreen> createState() =>
      _ExternalShellScreenState();
}

class _ExternalShellScreenState
    extends State<ExternalShellScreen> {
  // ============================================================
  // THEME
  // ============================================================

  static const Color navy =
      Color(0xFF172033);

  static const Color gold =
      Color(0xFFC09B60);

  static const Color textGrey =
      Color(0xFF6F747C);

  static const Color background =
      Color(0xFFF7F7F5);

  // ============================================================
  // PAGE INDEX
  // ============================================================
  //
  // 0 = Home
  // 1 = Properties
  // 2 = Map
  // 3 = Property Detail
  // 4 = Request Rental
  //

  int _selectedIndex = 0;

  // ============================================================
  // SELECTED PROPERTY
  // ============================================================

  ExternalProperty? _selectedProperty;

  // ============================================================
  // RENTAL PROPERTY
  // ============================================================

  ExternalProperty? _rentalProperty;

  // ============================================================
  // MAP
  // ============================================================

  bool _mapReady = false;

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    _preloadMap();
  }

  void _preloadMap() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(milliseconds: 400),
        () {
          if (!mounted) return;

          setState(() {
            _mapReady = true;
          });
        },
      );
    });
  }

  // ============================================================
  // NAVIGATION
  // ============================================================

  void _showHome() {
    if (_selectedIndex == 0) return;

    setState(() {
      _selectedIndex = 0;
    });
  }

  void _showProperties() {
    if (_selectedIndex == 1) return;

    setState(() {
      _selectedIndex = 1;
    });
  }

  void _showMap() {
    if (_selectedIndex == 2) return;

    setState(() {
      _selectedIndex = 2;
      _mapReady = true;
    });
  }

  // ============================================================
  // SHOW PROPERTY DETAIL
  // ============================================================

  void _showPropertyDetail(
    ExternalProperty property,
  ) {
    setState(() {
      _selectedProperty = property;
      _selectedIndex = 3;
    });
  }

  // ============================================================
  // BACK TO PROPERTIES
  // ============================================================

  void _backToProperties() {
    setState(() {
      _selectedProperty = null;
      _selectedIndex = 1;
    });
  }

  // ============================================================
  // SHOW RENTAL
  // ============================================================

  void _showRental([ExternalProperty? property]) {
    setState(() {
      _rentalProperty = property;
      _selectedIndex = 4;
    });
  }

  // ============================================================
  // BACK FROM RENTAL
  // ============================================================

  void _backFromRental() {
    setState(() {
      _selectedIndex = 0;
    });
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Column(
        children: [
          // ======================================================
          // GLOBAL NAVBAR
          // ======================================================

          _buildNavbar(),

          // ======================================================
          // CONTENT
          // ======================================================

          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                // ==================================================
                // 0. HOME
                // ==================================================

                ExternalHomeScreen(
                  showNavbar: false,
                  onPropertiesTap: _showProperties,
                  onMapTap: _showMap,
                  onAboutTap: widget.onAboutTap,
                  onRentalTap: () => _showRental(),
                  onPropertyTap: widget.onPropertyTap,
                ),

                // ==================================================
                // 1. PROPERTIES
                // ==================================================

                PropertyListScreen(
                  showNavbar: false,
                  onPropertyTap: _showPropertyDetail,
                ),

                // ==================================================
                // 2. MAP
                // ==================================================

                _mapReady
                    ? const ExternalMapScreen(
                        showNavbar: false,
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),

                // ==================================================
                // 3. PROPERTY DETAIL
                // ==================================================

                _selectedProperty != null
                    ? PropertyDetailScreen(
                        property: _selectedProperty!,
                        showNavbar: false,
                        onBack: _backToProperties,

                        // Request Rental dari Property Detail
                        onRequestRental: () {
                          _showRental(_selectedProperty);
                        },
                      )
                    : const SizedBox.shrink(),

                // ==================================================
                // 4. REQUEST RENTAL
                // ==================================================

                RequestRentalScreen(
                  property: _rentalProperty,
                  showNavbar: false,
                  onBack: _backFromRental,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // GLOBAL NAVBAR
  // ============================================================

  Widget _buildNavbar() {
    return Container(
      height: 78,
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
      ),
      child: Row(
        children: [
          // ======================================================
          // LOGO
          // ======================================================

          GestureDetector(
            onTap: _showHome,
            child: const Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Iventaris',
                  style: TextStyle(
                    color: navy,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2.2,
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

          // ======================================================
          // HOME
          // ======================================================

          _navItem(
            'Home',
            active: _selectedIndex == 0,
            onTap: _showHome,
          ),

          // ======================================================
          // PROPERTIES
          // ======================================================

          _navItem(
            'Properties',
            active:
                _selectedIndex == 1 ||
                _selectedIndex == 3,
            onTap: _showProperties,
          ),

          // ======================================================
          // MAP
          // ======================================================

          _navItem(
            'Map',
            active: _selectedIndex == 2,
            onTap: _showMap,
          ),

          // ======================================================
          // ABOUT
          // ======================================================

          _navItem(
            'About',
            onTap: widget.onAboutTap,
          ),

          const SizedBox(width: 20),

          // ======================================================
          // REQUEST RENTAL
          // ======================================================

          _goldButton(
            label: 'Request Rental',
            icon: Icons.arrow_forward_rounded,

            // Sebelumnya:
            // onPressed: widget.onRentalTap,

            // Sekarang langsung membuka halaman rental.
            onPressed: () => _showRental(),

            height: 44,
            horizontalPadding: 20,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // NAV ITEM
  // ============================================================

  Widget _navItem(
    String title, {
    bool active = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
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
                  color:
                      active ? navy : textGrey,
                  fontSize: 13,
                  fontWeight:
                      active
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

  // ============================================================
  // GOLD BUTTON
  // ============================================================

  Widget _goldButton({
    required String label,
    required IconData icon,
    VoidCallback? onPressed,
    double height = 48,
    double horizontalPadding = 22,
  }) {
    return SizedBox(
      height: height,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 17,
        ),
        label: Text(label),
        style:
            ElevatedButton.styleFrom(
          backgroundColor: gold,
          foregroundColor:
              Colors.white,
          elevation: 0,
          padding:
              EdgeInsets.symmetric(
            horizontal:
                horizontalPadding,
          ),
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(6),
          ),
          textStyle:
              const TextStyle(
            fontSize: 13,
            fontWeight:
                FontWeight.w600,
          ),
        ),
      ),
    );
  }
}