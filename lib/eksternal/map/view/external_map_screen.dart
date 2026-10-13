import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/dummy_properties.dart';
import '../../../admin/models/property.dart';

class ExternalMapScreen extends StatefulWidget {
  const ExternalMapScreen({
    super.key,
    this.showNavbar = true,
  });

  final bool showNavbar;

  @override
  State<ExternalMapScreen> createState() => _ExternalMapScreenState();
}

class _ExternalMapScreenState extends State<ExternalMapScreen> {
  // ============================================================
  // THEME
  // ============================================================

  static const Color navy = Color(0xFF172033);
  static const Color gold = Color(0xFFC09B60);
  static const Color background = Color(0xFFF7F7F5);
  static const Color textGrey = Color(0xFF6F747C);

  // ============================================================
  // MAP
  // ============================================================

  final MapController _mapController = MapController();

  static const LatLng _defaultCenter = LatLng(
    -7.7928,
    110.3654,
  );

  static const double _defaultZoom = 11.0;

  // ============================================================
  // STATE
  // ============================================================

  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';
  String _selectedType = 'All';

  Property? _selectedProperty;

  // ============================================================
  // SHARED PROPERTY DATA
  // ============================================================

  List<Property> get _properties => dummyProperties;

  List<String> get _propertyTypes {
    final types = _properties
        .map((property) => property.type)
        .where((type) => type.trim().isNotEmpty)
        .toSet()
        .toList();

    types.sort();

    return ['All', ...types];
  }

  List<Property> get _filteredProperties {
    final query = _searchQuery.trim().toLowerCase();

    return _properties.where((property) {
      final matchesSearch = query.isEmpty ||
          property.name.toLowerCase().contains(query) ||
          property.location.toLowerCase().contains(query);

      final matchesType =
          _selectedType == 'All' || property.type == _selectedType;

      return matchesSearch && matchesType;
    }).toList();
  }

  // ============================================================
  // LIFECYCLE
  // ============================================================

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    if (!widget.showNavbar) {
      return _buildMapArea();
    }

    return Scaffold(
      backgroundColor: background,
      body: Column(
        children: [
          _buildNavbar(context),
          Expanded(
            child: _buildMapArea(),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // NAVBAR
  // ============================================================

  Widget _buildNavbar(BuildContext context) {
    return Container(
      height: 78,
      padding: const EdgeInsets.symmetric(horizontal: 70),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        children: [
          // LOGO
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.circular(8),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 8,
              ),
              child: Text(
                'Iventaris',
                style: TextStyle(
                  color: navy,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),

          const Spacer(),

          // HOME
          _navItem(
            title: 'Home',
            active: false,
            onTap: () {
              Navigator.pop(context);
            },
          ),

          // PROPERTIES
          _navItem(
            title: 'Properties',
            active: false,
            onTap: () {},
          ),

          // MAP
          _navItem(
            title: 'Map',
            active: true,
            onTap: () {},
          ),

          // EVENTS
          _navItem(
            title: 'Events',
            active: false,
            onTap: () {},
          ),

          // ABOUT
          _navItem(
            title: 'About',
            active: false,
            onTap: () {},
          ),

          const SizedBox(width: 18),

          // RENTAL BUTTON
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
                borderRadius: BorderRadius.circular(5),
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

  Widget _navItem({
    required String title,
    required bool active,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: active ? navy : textGrey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: active ? navy : textGrey,
                fontSize: 13,
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: active ? 22 : 0,
              decoration: BoxDecoration(
                color: gold,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // MAP AREA
  // ============================================================

  Widget _buildMapArea() {
    return Stack(
      children: [
        // ========================================================
        // MAP
        // ========================================================

        FlutterMap(
          mapController: _mapController,
          options: const MapOptions(
            initialCenter: _defaultCenter,
            initialZoom: _defaultZoom,
            minZoom: 8,
            maxZoom: 18,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.Iventaris.property',
            ),
            MarkerLayer(
              markers: _buildMarkers(),
            ),
            RichAttributionWidget(
              attributions: [
                TextSourceAttribution(
                  'OpenStreetMap contributors',
                ),
              ],
            ),
          ],
        ),

        // ========================================================
        // TOP SEARCH & FILTER
        // ========================================================

        Positioned(
          top: 24,
          left: 28,
          right: 28,
          child: _buildSearchPanel(),
        ),

        // ========================================================
        // MAP CONTROL
        // ========================================================

        Positioned(
          right: 28,
          bottom: 28,
          child: _buildMapControls(),
        ),

        // ========================================================
        // PROPERTY PREVIEW
        // ========================================================

        if (_selectedProperty != null)
          Positioned(
            left: 28,
            bottom: 28,
            child: _buildPropertyPreview(
              _selectedProperty!,
            ),
          ),

        // ========================================================
        // PROPERTY COUNT
        // ========================================================

        Positioned(
          left: 28,
          bottom: 28,
          child: _selectedProperty == null
              ? _buildPropertyCount()
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  // ============================================================
  // SEARCH PANEL
  // ============================================================

  Widget _buildSearchPanel() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;

        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchField(),
              const SizedBox(height: 10),
              _buildFilterPanel(),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 390,
              child: _buildSearchField(),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildFilterPanel(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchField() {
    return Material(
      elevation: 6,
      shadowColor: Colors.black.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });

            _moveToFirstSearchResult();
          },
          decoration: InputDecoration(
            hintText: 'Search property or location...',
            hintStyle: const TextStyle(
              color: textGrey,
              fontSize: 13,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: navy,
              size: 21,
            ),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _searchController.clear();

                      setState(() {
                        _searchQuery = '';
                      });

                      _resetMap();
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 19,
                      color: textGrey,
                    ),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterPanel() {
    return Material(
      elevation: 6,
      shadowColor: Colors.black.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _propertyTypes.map((type) {
              final active = _selectedType == type;

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 3,
                ),
                child: ChoiceChip(
                  label: Text(type),
                  selected: active,
                  onSelected: (_) {
                    setState(() {
                      _selectedType = type;
                      _selectedProperty = null;
                    });

                    _moveToFirstSearchResult();
                  },
                  selectedColor: navy,
                  backgroundColor: Colors.transparent,
                  side: BorderSide.none,
                  labelStyle: TextStyle(
                    color: active ? Colors.white : textGrey,
                    fontSize: 12,
                    fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MARKERS
  // ============================================================

  List<Marker> _buildMarkers() {
    return _filteredProperties.map((property) {
      final isSelected = _selectedProperty?.id == property.id;

      return Marker(
        point: LatLng(
          property.latitude,
          property.longitude,
        ),
        width: isSelected ? 52 : 46,
        height: isSelected ? 58 : 52,
        child: GestureDetector(
          onTap: () {
            _onMarkerTap(property);
          },
          child: _buildMarker(
            property,
            isSelected,
          ),
        ),
      );
    }).toList();
  }

  Widget _buildMarker(
    Property property,
    bool selected,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: selected ? 42 : 36,
          height: selected ? 42 : 36,
          decoration: BoxDecoration(
            color: selected ? gold : navy,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.22),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(
            Icons.location_on,
            color: Colors.white,
            size: selected ? 23 : 20,
          ),
        ),
        Container(
          width: 2,
          height: 7,
          color: selected ? gold : navy,
        ),
      ],
    );
  }

  // ============================================================
  // PROPERTY PREVIEW
  // ============================================================

  Widget _buildPropertyPreview(Property property) {
    return Material(
      elevation: 12,
      shadowColor: Colors.black.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 360,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: gold.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          property.type.toUpperCase(),
                          style: const TextStyle(
                            color: gold,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        property.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: navy,
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedProperty = null;
                    });
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 19,
                  ),
                  color: textGrey,
                  tooltip: 'Close',
                ),
              ],
            ),

            const SizedBox(height: 12),

            // LOCATION
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: gold,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    property.location,
                    style: const TextStyle(
                      color: textGrey,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // INFO
            Row(
              children: [
                Expanded(
                  child: _infoItem(
                    icon: Icons.square_foot,
                    label: 'Luas',
                    value: '${_formatNumber(property.area)} m²',
                  ),
                ),
                Expanded(
                  child: _infoItem(
                    icon: Icons.people_outline,
                    label: 'Kapasitas',
                    value: '${_formatNumber(property.capacity)} orang',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // STATUS
            Row(
              children: [
                const Icon(
                  Icons.circle,
                  size: 10,
                  color: Colors.green,
                ),
                const SizedBox(width: 7),
                Text(
                  property.status,
                  style: const TextStyle(
                    color: textGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // DESCRIPTION
            Text(
              property.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: textGrey,
                fontSize: 12,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 18),

            // BUTTON
            SizedBox(
              width: double.infinity,
              height: 42,
              child: ElevatedButton(
                onPressed: () {
                  _showPropertyDetail(property);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: navy,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
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
          ],
        ),
      ),
    );
  }

  Widget _infoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: gold,
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: textGrey,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: navy,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // PROPERTY COUNT
  // ============================================================

  Widget _buildPropertyCount() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(7),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.location_on,
              color: gold,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              '${_filteredProperties.length} Properties',
              style: const TextStyle(
                color: navy,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // MAP CONTROLS
  // ============================================================

  Widget _buildMapControls() {
    return Material(
      elevation: 7,
      borderRadius: BorderRadius.circular(7),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Column(
          children: [
            _mapControlButton(
              icon: Icons.add,
              tooltip: 'Zoom in',
              onTap: () {
                final currentZoom = _mapController.camera.zoom;

                _mapController.move(
                  _mapController.camera.center,
                  currentZoom + 1,
                );
              },
            ),
            Container(
              height: 1,
              width: 38,
              color: Colors.grey.shade200,
            ),
            _mapControlButton(
              icon: Icons.remove,
              tooltip: 'Zoom out',
              onTap: () {
                final currentZoom = _mapController.camera.zoom;

                _mapController.move(
                  _mapController.camera.center,
                  currentZoom - 1,
                );
              },
            ),
            Container(
              height: 1,
              width: 38,
              color: Colors.grey.shade200,
            ),
            _mapControlButton(
              icon: Icons.my_location,
              tooltip: 'Reset map',
              onTap: _resetMap,
            ),
          ],
        ),
      ),
    );
  }

  Widget _mapControlButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(7),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            icon,
            size: 19,
            color: navy,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MARKER TAP
  // ============================================================

  void _onMarkerTap(Property property) {
    setState(() {
      _selectedProperty = property;
    });

    _mapController.move(
      LatLng(
        property.latitude,
        property.longitude,
      ),
      14,
    );
  }

  // ============================================================
  // SEARCH
  // ============================================================

  void _moveToFirstSearchResult() {
    final results = _filteredProperties;

    if (results.isEmpty) {
      return;
    }

    final property = results.first;

    _mapController.move(
      LatLng(
        property.latitude,
        property.longitude,
      ),
      12.5,
    );
  }

  // ============================================================
  // RESET
  // ============================================================

  void _resetMap() {
    setState(() {
      _selectedProperty = null;
      _selectedType = 'All';
      _searchQuery = '';
      _searchController.clear();
    });

    _mapController.move(
      _defaultCenter,
      _defaultZoom,
    );
  }

  // ============================================================
  // PUBLIC PROPERTY DETAIL
  // ============================================================

  void _showPropertyDetail(Property property) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 650,
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HEADER
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                property.type.toUpperCase(),
                                style: const TextStyle(
                                  color: gold,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                property.name,
                                style: const TextStyle(
                                  color: navy,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                          color: textGrey,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // LOCATION
                    _detailRow(
                      icon: Icons.location_on_outlined,
                      title: 'Location',
                      value: property.location,
                    ),

                    const SizedBox(height: 16),

                    // AREA
                    _detailRow(
                      icon: Icons.square_foot,
                      title: 'Area',
                      value: '${_formatNumber(property.area)} m²',
                    ),

                    const SizedBox(height: 16),

                    // CAPACITY
                    _detailRow(
                      icon: Icons.people_outline,
                      title: 'Capacity',
                      value: '${_formatNumber(property.capacity)} people',
                    ),

                    const SizedBox(height: 16),

                    // STATUS
                    _detailRow(
                      icon: Icons.check_circle_outline,
                      title: 'Status',
                      value: property.status,
                    ),

                    const SizedBox(height: 24),

                    const Divider(),

                    const SizedBox(height: 22),

                    const Text(
                      'About Property',
                      style: TextStyle(
                        color: navy,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      property.description,
                      style: const TextStyle(
                        color: textGrey,
                        fontSize: 13,
                        height: 1.7,
                      ),
                    ),

                    const SizedBox(height: 26),

                    // RENTAL CTA
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Request Rental feature siap diintegrasikan.',
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: navy,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _detailRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: gold.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            color: gold,
            size: 20,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: textGrey,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  color: navy,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // FORMAT NUMBER
  // ============================================================

  String _formatNumber(num value) {
    return value.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match.group(1)}.',
        );
  }
}
