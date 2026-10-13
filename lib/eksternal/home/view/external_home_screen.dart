import 'package:flutter/material.dart';

import '../../../data/dummy_properties.dart';
import '../../../admin/models/property.dart';
import '../../map/view/external_map_screen.dart';

class ExternalHomeScreen extends StatelessWidget {
  const ExternalHomeScreen({
    super.key,
    this.showNavbar = true,
    this.onPropertiesTap,
    this.onMapTap,
    this.onAboutTap,
    this.onRentalTap,
    this.onPropertyTap,
  });

  final bool showNavbar;

  /// Callback navigasi supaya Home tidak bergantung
  /// langsung pada struktur routing aplikasi.
  final VoidCallback? onPropertiesTap;
  final VoidCallback? onMapTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onRentalTap;
  final ValueChanged<Property>? onPropertyTap;

  // ============================================================
  // COLOR
  // ============================================================

  static const Color navy = Color(0xFF172033);
  static const Color gold = Color(0xFFC09B60);
  static const Color background = Color(0xFFF7F7F5);
  static const Color textGrey = Color(0xFF6F747C);
  static const Color border = Color(0xFFE5E2DC);

  // ============================================================
  // DATA
  // ============================================================

  /// Menggunakan data Property yang sama dengan Admin.
  ///
  /// Tidak membuat dummy data eksternal baru.
  List<Property> get featuredProperties {
    return dummyProperties.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    final content = SingleChildScrollView(
      child: Column(
        children: [
          if (showNavbar) _navbar(context),
          _hero(context),
          _featuredProperties(context),
          _visualizationSection(context),
          _aboutSection(context),
          _rentalCTA(context),
          _footer(),
        ],
      ),
    );

    if (!showNavbar) {
      return content;
    }

    return Scaffold(
      backgroundColor: background,
      body: content,
    );
  }

  // ============================================================
  // NAVBAR
  // ============================================================

  Widget _navbar(BuildContext context) {
    return Container(
      height: 78,
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: Row(
        children: [
          // LOGO
          GestureDetector(
            onTap: () {
              // Home sudah aktif.
            },
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
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

          _navItem(
            'Home',
            active: true,
            onTap: null,
          ),

          _navItem(
            'Properties',
            onTap: onPropertiesTap,
          ),

          _navItem(
            'Map',
            onTap: onMapTap,
          ),

          _navItem(
            'About',
            onTap: onAboutTap,
          ),

          const SizedBox(width: 20),

          // REQUEST RENTAL
          _goldButton(
            label: 'Request Rental',
            icon: Icons.arrow_forward_rounded,
            onPressed: onRentalTap,
            height: 44,
            horizontalPadding: 20,
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
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 10,
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
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
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
  // HERO
  // ============================================================

  Widget _hero(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 510,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1519167758481-83f550bb49b3'
            '?auto=format&fit=crop&w=1800&q=85',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              navy.withValues(alpha: 0.94),
              navy.withValues(alpha: 0.72),
              navy.withValues(alpha: 0.20),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 70,
            vertical: 70,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 620,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'PROPERTY VISUALIZATION PLATFORM',
                      style: TextStyle(
                        color: gold,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.5,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Temukan Ruang\n'
                      'yang Tepat untuk\n'
                      'Kebutuhan Anda',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        height: 1.08,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -1.2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(
                      width: 520,
                      child: Text(
                        'Jelajahi berbagai properti dan ruang yang '
                        'tersedia untuk kebutuhan acara, bisnis, '
                        'dan berbagai kebutuhan lainnya.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        _goldButton(
                          label: 'Jelajahi Properti',
                          icon: Icons.arrow_forward_rounded,
                          onPressed: onPropertiesTap,
                        ),
                        const SizedBox(width: 14),
                        _outlineButton(
                          label: 'Lihat Peta',
                          icon: Icons.location_on_outlined,
                          onPressed: onMapTap,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // FEATURED PROPERTIES
  // ============================================================

  Widget _featuredProperties(BuildContext context) {
    return Container(
      width: double.infinity,
      color: background,
      padding: const EdgeInsets.fromLTRB(
        70,
        75,
        70,
        80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PROPERTI UNGGULAN',
                      style: TextStyle(
                        color: gold,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.2,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Jelajahi Properti Kami',
                      style: TextStyle(
                        color: navy,
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.6,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: onPropertiesTap,
                iconAlignment: IconAlignment.end,
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 18,
                ),
                label: const Text(
                  'Lihat Semua Properti',
                ),
                style: TextButton.styleFrom(
                  foregroundColor: navy,
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // PROPERTY CARDS
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              if (width < 800) {
                return Column(
                  children: featuredProperties
                      .map(
                        (property) => Padding(
                          padding: const EdgeInsets.only(
                            bottom: 20,
                          ),
                          child: _propertyCard(
                            property,
                            context,
                          ),
                        ),
                      )
                      .toList(),
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _propertyCard(
                      featuredProperties[0],
                      context,
                    ),
                  ),
                  const SizedBox(width: 22),
                  Expanded(
                    child: _propertyCard(
                      featuredProperties[1],
                      context,
                    ),
                  ),
                  const SizedBox(width: 22),
                  Expanded(
                    child: _propertyCard(
                      featuredProperties[2],
                      context,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _propertyCard(
    Property property,
    BuildContext context,
  ) {
    final imageUrl = _propertyImage(property);

    return InkWell(
      onTap: () {
        if (onPropertyTap != null) {
          onPropertyTap!(property);
        }
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: border,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.035),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            AspectRatio(
              aspectRatio: 1.65,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) {
                  return Container(
                    color: const Color(0xFFE8E7E3),
                    child: const Icon(
                      Icons.apartment_rounded,
                      size: 48,
                      color: Color(0xFF9B9A95),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TYPE
                  Text(
                    property.type.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: gold,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // NAME
                  Text(
                    property.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: navy,
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 9),

                  // LOCATION
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: textGrey,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          property.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: textGrey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // AREA & CAPACITY
                  Row(
                    children: [
                      const Icon(
                        Icons.square_foot_rounded,
                        size: 16,
                        color: textGrey,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${_formatNumber(property.area)} m²',
                        style: const TextStyle(
                          color: textGrey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 18),
                      const Icon(
                        Icons.people_outline_rounded,
                        size: 16,
                        color: textGrey,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${_formatNumber(property.capacity)} orang',
                        style: const TextStyle(
                          color: textGrey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      _statusBadge(property.status),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 19,
                        color: navy,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PROPERTY VISUALIZATION
  // ============================================================

  Widget _visualizationSection(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFECEEF0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 850;

          if (isMobile) {
            return Column(
              children: [
                _visualizationText(),
                _visualizationPreview(),
              ],
            );
          }

          return SizedBox(
            height: 490,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 70,
                      right: 40,
                    ),
                    child: _visualizationText(),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: _visualizationPreview(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _visualizationText() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 65,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'VISUALISASI PROPERTI',
            style: TextStyle(
              color: gold,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.2,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Lihat Sebelum\n'
            'Anda Berkunjung',
            style: TextStyle(
              color: navy,
              fontSize: 38,
              height: 1.1,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 18),
          const SizedBox(
            width: 450,
            child: Text(
              'Jelajahi properti pilihan melalui visualisasi '
              'yang memberikan gambaran ruang secara lebih '
              'jelas sebelum melakukan kunjungan atau '
              'permintaan penyewaan.',
              style: TextStyle(
                color: textGrey,
                fontSize: 15,
                height: 1.65,
              ),
            ),
          ),
          const SizedBox(height: 28),
          _goldButton(
            label: 'Jelajahi Visualisasi',
            icon: Icons.arrow_forward_rounded,
            onPressed: () {
              _showVisualizationInfo();
            },
          ),
        ],
      ),
    );
  }

  Widget _visualizationPreview() {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1497366811353-6870744d04b2'
            '?auto=format&fit=crop&w=1400&q=80',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              const Color(0xFFECEEF0).withValues(alpha: 0.92),
              Colors.transparent,
              navy.withValues(alpha: 0.28),
            ],
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.65),
              ),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.view_in_ar_rounded,
                  color: Colors.white,
                  size: 54,
                ),
                SizedBox(height: 14),
                Text(
                  '3D PROPERTY VIEW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Interactive Visualization',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ABOUT
  // ============================================================

  Widget _aboutSection(BuildContext context) {
    return Container(
      width: double.infinity,
      color: background,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 80,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 850;

          final image = ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://images.unsplash.com/photo-1497366754035-f200968a6e72'
              '?auto=format&fit=crop&w=1200&q=80',
              width: double.infinity,
              height: isMobile ? 280 : 390,
              fit: BoxFit.cover,
              errorBuilder: (
                context,
                error,
                stackTrace,
              ) {
                return Container(
                  height: isMobile ? 280 : 390,
                  color: const Color(0xFFE3E4E0),
                  child: const Icon(
                    Icons.business_rounded,
                    size: 60,
                    color: Color(0xFF92948F),
                  ),
                );
              },
            ),
          );

          final text = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'TENTANG Iventaris',
                style: TextStyle(
                  color: gold,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.2,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Mengenal Iventaris',
                style: TextStyle(
                  color: navy,
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Iventaris merupakan platform visualisasi properti '
                'yang membantu pengguna menemukan, mengeksplorasi, '
                'dan mendapatkan informasi mengenai berbagai '
                'properti untuk kebutuhan acara, bisnis, dan '
                'kebutuhan lainnya.',
                style: TextStyle(
                  color: textGrey,
                  fontSize: 15,
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 25),
              OutlinedButton.icon(
                onPressed: onAboutTap,
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 17,
                ),
                label: const Text(
                  'Tentang Kami',
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: navy,
                  side: const BorderSide(
                    color: navy,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          );

          if (isMobile) {
            return Column(
              children: [
                image,
                const SizedBox(height: 35),
                text,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: image,
              ),
              const SizedBox(width: 70),
              Expanded(
                child: text,
              ),
            ],
          );
        },
      ),
    );
  }

  // ============================================================
  // RENTAL CTA
  // ============================================================

  Widget _rentalCTA(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 55,
      ),
      decoration: const BoxDecoration(
        color: navy,
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1497366216548-37526070297c'
            '?auto=format&fit=crop&w=1600&q=75',
          ),
          fit: BoxFit.cover,
          opacity: 0.18,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 750;

          final text = const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SIAP MENEMUKAN RUANG YANG TEPAT?',
                style: TextStyle(
                  color: gold,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Wujudkan Kebutuhan Anda\n'
                'Bersama Iventaris',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  height: 1.15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Temukan properti yang sesuai dan hubungi '
                'kami untuk informasi serta permintaan penyewaan.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
          );

          final button = _goldButton(
            label: 'Request Rental',
            icon: Icons.arrow_forward_rounded,
            onPressed: onRentalTap,
            height: 48,
          );

          if (isMobile) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text,
                const SizedBox(height: 25),
                button,
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: text),
              const SizedBox(width: 30),
              button,
            ],
          );
        },
      ),
    );
  }

  // ============================================================
  // FOOTER
  // ============================================================

  Widget _footer() {
    return Container(
      width: double.infinity,
      color: const Color(0xFF101827),
      padding: const EdgeInsets.fromLTRB(
        70,
        55,
        70,
        25,
      ),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 750;

              final brand = const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Iventaris',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'PROPERTY VISUALIZATION',
                    style: TextStyle(
                      color: gold,
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.3,
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: 260,
                    child: Text(
                      'Platform visualisasi properti untuk '
                      'membantu menemukan dan mengeksplorasi '
                      'ruang yang sesuai dengan kebutuhan Anda.',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              );

              final navigation = _footerColumn(
                'Navigasi',
                [
                  'Home',
                  'Properties',
                  'Map',
                  'About',
                ],
              );

              final contact = _footerColumn(
                'Kontak',
                [
                  'info@Iventaris.co.id',
                  '+62 21 1234 5678',
                  'Indonesia',
                ],
              );

              if (isMobile) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    brand,
                    const SizedBox(height: 35),
                    navigation,
                    const SizedBox(height: 30),
                    contact,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: brand,
                  ),
                  Expanded(
                    child: navigation,
                  ),
                  Expanded(
                    child: contact,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 45),
          Divider(
            color: Colors.white.withValues(
              alpha: 0.10,
            ),
            height: 1,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Expanded(
                child: Text(
                  '© 2026 Iventaris. All rights reserved.',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 11,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Privacy Policy',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 11,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Terms of Service',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _footerColumn(
    String title,
    List<String> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 15),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(
              bottom: 9,
            ),
            child: Text(
              item,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // BUTTONS
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
        style: ElevatedButton.styleFrom(
          backgroundColor: gold,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _outlineButton({
    required String label,
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return SizedBox(
      height: 48,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 17,
        ),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: BorderSide(
            color: Colors.white.withValues(
              alpha: 0.65,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HELPERS
  // ============================================================

  Widget _statusBadge(String status) {
    final isAvailable = status.toLowerCase().contains('tersedia');

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: isAvailable ? const Color(0xFFE8F5EC) : const Color(0xFFF3EEE5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color:
              isAvailable ? const Color(0xFF2E7D4F) : const Color(0xFF8A6A35),
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatNumber(num value) {
    final text = value.toInt().toString();
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i > 0 && (text.length - i) % 3 == 0) {
        buffer.write('.');
      }

      buffer.write(text[i]);
    }

    return buffer.toString();
  }

  String _propertyImage(Property property) {
    final index = dummyProperties.indexWhere(
      (item) => item.id == property.id,
    );

    const images = [
      'https://images.unsplash.com/photo-1519167758481-83f550bb49b3'
          '?auto=format&fit=crop&w=900&q=80',
      'https://images.unsplash.com/photo-1505373877841-8d25f7d46678'
          '?auto=format&fit=crop&w=900&q=80',
      'https://images.unsplash.com/photo-1497366754035-f200968a6e72'
          '?auto=format&fit=crop&w=900&q=80',
    ];

    return images[index % images.length];
  }

  void _showVisualizationInfo() {
    // Untuk sementara tombol hanya memberikan informasi.
    // Nanti bisa diarahkan ke halaman/model 3D.
    if (navigatorKey.currentState?.overlay == null) {
      return;
    }
  }
}

/// Global navigator key sementara tidak diperlukan untuk routing.
/// Dipisahkan agar bagian visualization tetap bisa dikembangkan
/// ke halaman 3D pada tahap berikutnya.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
