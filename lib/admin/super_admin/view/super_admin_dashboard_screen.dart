import 'package:flutter/material.dart';

import '../viewmodel/super_admin_viewmodel.dart';
import 'access_management_screen.dart';
import 'division_management_screen.dart';
import 'user_management_screen.dart';

class SuperAdminDashboardScreen extends StatefulWidget {
  const SuperAdminDashboardScreen({super.key});

  @override
  State<SuperAdminDashboardScreen> createState() =>
      _SuperAdminDashboardScreenState();
}

class _SuperAdminDashboardScreenState
    extends State<SuperAdminDashboardScreen> {
  static const Color navy = Color(0xFF172033);
  static const Color gold = Color(0xFFC09B60);
  static const Color background = Color(0xFFF7F7F5);
  static const Color textGrey = Color(0xFF6F747C);
  static const Color border = Color(0xFFE5E5E1);

  late final SuperAdminViewModel viewModel;

  int selectedMenu = 0;

  @override
  void initState() {
    super.initState();

    viewModel = SuperAdminViewModel();
    viewModel.addListener(_refresh);
  }

  @override
  void dispose() {
    viewModel.removeListener(_refresh);
    viewModel.dispose();
    super.dispose();
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void _selectMenu(int index) {
    setState(() {
      selectedMenu = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;

        return Scaffold(
          backgroundColor: background,

          drawer: isMobile
              ? Drawer(
                  child: _buildSidebar(
                    isDrawer: true,
                  ),
                )
              : null,

          body: Row(
            children: [
              if (!isMobile)
                _buildSidebar(),

              Expanded(
                child: Column(
                  children: [
                    if (isMobile)
                      _buildMobileTopBar(),

                    Expanded(
                      child: _buildContent(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // SIDEBAR
  // ============================================================

  Widget _buildSidebar({
    bool isDrawer = false,
  }) {
    return Container(
      width: 250,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: navy,
      ),
      child: Column(
        children: [
          // BRAND
          Padding(
            padding: const EdgeInsets.fromLTRB(
              25,
              30,
              25,
              30,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'EVENTARY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'PROPERTY VISUALIZATION',
                  style: TextStyle(
                    color: gold,
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            height: 1,
            color: Colors.white.withValues(
              alpha: 0.08,
            ),
          ),

          const SizedBox(height: 25),

          // SECTION TITLE
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 22,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'SUPER ADMIN',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // MENU
          _sidebarItem(
            index: 0,
            icon: Icons.dashboard_outlined,
            activeIcon:
                Icons.dashboard_rounded,
            title: 'Dashboard',
            isDrawer: isDrawer,
          ),

          _sidebarItem(
            index: 1,
            icon: Icons.people_outline,
            activeIcon:
                Icons.people_rounded,
            title: 'User Management',
            isDrawer: isDrawer,
          ),

          _sidebarItem(
            index: 2,
            icon:
                Icons.account_tree_outlined,
            activeIcon:
                Icons.account_tree_rounded,
            title: 'Division Management',
            isDrawer: isDrawer,
          ),

          _sidebarItem(
            index: 3,
            icon: Icons.lock_outline,
            activeIcon:
                Icons.lock_rounded,
            title: 'Access Management',
            isDrawer: isDrawer,
          ),

          const Spacer(),

          // USER INFO
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(
                alpha: 0.06,
              ),
              borderRadius:
                  BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: gold.withValues(
                      alpha: 0.18,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.admin_panel_settings_outlined,
                    color: gold,
                    size: 19,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Super Admin',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Administrator',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // LOGOUT
          Padding(
            padding: const EdgeInsets.fromLTRB(
              18,
              0,
              18,
              22,
            ),
            child: InkWell(
              borderRadius:
                  BorderRadius.circular(9),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              },
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.logout_rounded,
                      color: Colors.white60,
                      size: 19,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sidebarItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String title,
    bool isDrawer = false,
  }) {
    final isActive = selectedMenu == index;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 2,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius:
              BorderRadius.circular(9),
          onTap: () {
            _selectMenu(index);

            if (isDrawer) {
              Navigator.of(context).pop();
            }
          },
          child: AnimatedContainer(
            duration:
                const Duration(milliseconds: 180),
            padding:
                const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.white.withValues(
                      alpha: 0.10,
                    )
                  : Colors.transparent,
              borderRadius:
                  BorderRadius.circular(9),
            ),
            child: Row(
              children: [
                Icon(
                  isActive
                      ? activeIcon
                      : icon,
                  color: isActive
                      ? gold
                      : Colors.white60,
                  size: 19,
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: isActive
                          ? Colors.white
                          : Colors.white70,
                      fontSize: 13,
                      fontWeight: isActive
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
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
  // MOBILE TOP BAR
  // ============================================================

  Widget _buildMobileTopBar() {
    return Container(
      height: 64,
      color: navy,
      padding:
          const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      child: Row(
        children: [
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context)
                      .openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              );
            },
          ),
          const SizedBox(width: 5),
          const Text(
            'EVENTARY',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CONTENT
  // ============================================================

  Widget _buildContent() {
    switch (selectedMenu) {
      case 0:
        return _dashboardContent();

      case 1:
        return UserManagementScreen(
          viewModel: viewModel,
        );

      case 2:
        return DivisionManagementScreen(
          viewModel: viewModel,
        );

      case 3:
        return AccessManagementScreen(
          viewModel: viewModel,
        );

      default:
        return _dashboardContent();
    }
  }

  // ============================================================
  // DASHBOARD
  // ============================================================

  Widget _dashboardContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1450,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 30),
              _buildStatistics(),
              const SizedBox(height: 40),
              _buildSystemManagement(),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'Super Admin Dashboard',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: navy,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Kelola akun admin, divisi, dan hak akses sistem.',
          style: TextStyle(
            fontSize: 14,
            color: textGrey,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // STATISTICS
  // ============================================================

  Widget _buildStatistics() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return Column(
            children: [
              _statCard(
                title: 'Total Admin',
                value:
                    viewModel.totalAdmins.toString(),
                icon:
                    Icons.people_outline_rounded,
              ),
              const SizedBox(height: 14),
              _statCard(
                title: 'Admin Aktif',
                value:
                    viewModel.activeAdmins.toString(),
                icon:
                    Icons.person_outline_rounded,
              ),
              const SizedBox(height: 14),
              _statCard(
                title: 'Admin Nonaktif',
                value:
                    viewModel.inactiveAdmins.toString(),
                icon:
                    Icons.person_off_outlined,
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: _statCard(
                title: 'Total Admin',
                value:
                    viewModel.totalAdmins.toString(),
                icon:
                    Icons.people_outline_rounded,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: _statCard(
                title: 'Admin Aktif',
                value:
                    viewModel.activeAdmins.toString(),
                icon:
                    Icons.person_outline_rounded,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: _statCard(
                title: 'Admin Nonaktif',
                value:
                    viewModel.inactiveAdmins.toString(),
                icon:
                    Icons.person_off_outlined,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(14),
        border: Border.all(
          color: border,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color:
                  gold.withValues(alpha: 0.12),
              borderRadius:
                  BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: gold,
              size: 23,
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  color: textGrey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: navy,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SYSTEM MANAGEMENT
  // ============================================================

  Widget _buildSystemManagement() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'System Management',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w800,
            color: navy,
          ),
        ),
        const SizedBox(height: 7),
        const Text(
          'Kelola pengguna dan konfigurasi akses sistem.',
          style: TextStyle(
            fontSize: 14,
            color: textGrey,
          ),
        ),
        const SizedBox(height: 20),

        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 800) {
              return Column(
                children: [
                  _managementCard(
                    icon:
                        Icons.people_alt_outlined,
                    title: 'User Management',
                    description:
                        'Tambah, edit, aktifkan, atau nonaktifkan akun admin.',
                    onTap: () =>
                        _selectMenu(1),
                  ),
                  const SizedBox(height: 15),
                  _managementCard(
                    icon:
                        Icons.account_tree_outlined,
                    title:
                        'Division Management',
                    description:
                        'Kelola divisi yang digunakan oleh admin.',
                    onTap: () =>
                        _selectMenu(2),
                  ),
                  const SizedBox(height: 15),
                  _managementCard(
                    icon:
                        Icons.lock_outline_rounded,
                    title:
                        'Access Management',
                    description:
                        'Atur fitur yang dapat diakses oleh setiap admin.',
                    onTap: () =>
                        _selectMenu(3),
                  ),
                ],
              );
            }

            return Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _managementCard(
                    icon:
                        Icons.people_alt_outlined,
                    title: 'User Management',
                    description:
                        'Tambah, edit, aktifkan, atau nonaktifkan akun admin.',
                    onTap: () =>
                        _selectMenu(1),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: _managementCard(
                    icon:
                        Icons.account_tree_outlined,
                    title:
                        'Division Management',
                    description:
                        'Kelola divisi yang digunakan oleh admin.',
                    onTap: () =>
                        _selectMenu(2),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: _managementCard(
                    icon:
                        Icons.lock_outline_rounded,
                    title:
                        'Access Management',
                    description:
                        'Atur fitur yang dapat diakses oleh setiap admin.',
                    onTap: () =>
                        _selectMenu(3),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _managementCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius:
          BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius:
            BorderRadius.circular(14),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(14),
            border: Border.all(
              color: border,
            ),
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color:
                      navy.withValues(alpha: 0.07),
                  borderRadius:
                      BorderRadius.circular(11),
                ),
                child: Icon(
                  icon,
                  color: navy,
                  size: 23,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: navy,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: textGrey,
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    'Manage',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: gold,
                    ),
                  ),
                  SizedBox(width: 7),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: gold,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}