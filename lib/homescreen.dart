import 'package:flutter/material.dart';

/// Home screen for a gaming-expenses tracker.
/// Black & white base with a neon-blue accent palette. Layout adapts to
/// screen width (phone vs. wider/tablet) via LayoutBuilder.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ---- Palette: black/white base, neon blue accents ----
  static const Color bgBlack = Color(0xFF000000);
  static const Color surface = Color(0xFF121212);
  static const Color surfaceAlt = Color(0xFF1C1C1C);
  static const Color neonBlue = Color(0xFF2F8CFF);
  static const Color neonCyan = Color(0xFF00E5FF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0xFFA6A6A6);
  static const Color danger = Color(0xFFFF5C5C);
  static const Color success = Color(0xFF3DDC84);

  @override
  Widget build(BuildContext context) {
    // Route arguments passed from Sign In: a Map with the entered username.
    final args = ModalRoute.of(context)?.settings.arguments;
    final data = (args is Map) ? args : <String, dynamic>{};
    final username = (data['username'] as String?)?.trim().isNotEmpty == true
        ? data['username'] as String
        : 'Player';

    return Scaffold(
      backgroundColor: bgBlack,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final isWide = width >= 600; // tablet / landscape breakpoint
            final horizontalPadding = width * 0.05 > 24 ? 24.0 : width * 0.05;
            final contentWidth = isWide ? 560.0 : double.infinity;
            final statColumns = isWide ? 4 : 3;
            final quickColumns = isWide ? 4 : 2;

            return Center(
              child: SizedBox(
                width: contentWidth,
                child: CustomScrollView( // ← this already supports mouse cursor scrolling
                  slivers: [
                    // ---------- Top bar ----------
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(horizontalPadding, 14, horizontalPadding, 0),
                        child: Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [neonBlue, neonCyan]),
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: const Icon(Icons.sports_esports_rounded, color: Colors.black, size: 20),
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                'GameSpend',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                            _iconButton(Icons.notifications_none_rounded),
                            const SizedBox(width: 8),
                            _iconButton(Icons.person_outline_rounded),
                          ],
                        ),
                      ),
                    ),

                    // ---------- Greeting ----------
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(horizontalPadding, 20, horizontalPadding, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_greeting()}, $username',
                              style: const TextStyle(
                                color: white,
                                fontSize: 21,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 3),
                            const Text(
                              'Here’s your gaming spend overview',
                              style: TextStyle(color: textMuted, fontSize: 12.5),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ---------- Budget summary card ----------
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(horizontalPadding, 18, horizontalPadding, 0),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF0B0B0B), Color(0xFF15151A)],
                            ),
                            border: Border.all(color: neonBlue.withValues(alpha: 0.4)),
                            boxShadow: [
                              BoxShadow(
                                color: neonBlue.withValues(alpha: 0.18),
                                blurRadius: 26,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('This Month’s Gaming Spend',
                                  style: TextStyle(color: textMuted, fontSize: 12.5, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    '₱2,840',
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 34,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 6),
                                    child: Text('/ ₱4,000 budget',
                                        style: TextStyle(color: textMuted, fontSize: 13)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Stack(
                                  children: [
                                    Container(height: 9, color: surfaceAlt),
                                    FractionallySizedBox(
                                      widthFactor: 0.71,
                                      child: Container(
                                        height: 9,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(colors: [neonBlue, neonCyan]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text('71% of budget used · ₱1,160 left',
                                  style: TextStyle(color: neonCyan, fontSize: 11.5, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // ---------- Quick stats ----------
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(horizontalPadding, 16, horizontalPadding, 0),
                        child: GridView.count(
                          crossAxisCount: statColumns,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.05,
                          children: [
                            _statCard(Icons.videogame_asset_rounded, '14', 'Games Bought'),
                            _statCard(Icons.diamond_outlined, '₱620', 'In-Game Items'),
                            _statCard(Icons.subscriptions_outlined, '3', 'Subscriptions'),
                          ],
                        ),
                      ),
                    ),

                    // ---------- Spending by category ----------
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(horizontalPadding, 26, horizontalPadding, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _sectionTitle('Spending by Category'),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: surface,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  _categoryRow(Icons.sports_esports_rounded, 'Game Purchases', 1240, 2840, neonBlue),
                                  const SizedBox(height: 14),
                                  _categoryRow(Icons.diamond_outlined, 'In-Game Items', 620, 2840, neonCyan),
                                  const SizedBox(height: 14),
                                  _categoryRow(Icons.subscriptions_outlined, 'Subscriptions', 540, 2840, success),
                                  const SizedBox(height: 14),
                                  _categoryRow(Icons.headset_mic_outlined, 'Gear & Peripherals', 440, 2840, danger),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ---------- Quick actions ----------
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(horizontalPadding, 26, horizontalPadding, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _sectionTitle('Quick Actions'),
                            const SizedBox(height: 10),
                            GridView.count(
                              crossAxisCount: quickColumns,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 2.6,
                              children: [
                                _quickAction(Icons.add_circle_outline_rounded, 'Add Expense'),
                                _quickAction(Icons.pie_chart_outline_rounded, 'View Report'),
                                _quickAction(Icons.flag_outlined, 'Set Budget'),
                                _quickAction(Icons.history_rounded, 'History'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ---------- Recent transactions ----------
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(horizontalPadding, 26, horizontalPadding, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _sectionTitle('Recent Transactions'),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: surface,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  _transactionTile(Icons.sports_esports_rounded, 'Starlight Odyssey',
                                      'Steam · Today', 999, neonBlue),
                                  _divider(),
                                  _transactionTile(Icons.diamond_outlined, 'Battle Pass – Season 9',
                                      'In-game purchase · Yesterday', 450, neonCyan),
                                  _divider(),
                                  _transactionTile(Icons.subscriptions_outlined, 'Game Pass Ultimate',
                                      'Subscription · 3 days ago', 549, success),
                                  _divider(),
                                  _transactionTile(Icons.headset_mic_outlined, 'Wireless Headset',
                                      'Gear · 5 days ago', 2499, danger),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ---------- Bottom padding for FAB clearance ----------
                    const SliverToBoxAdapter(child: SizedBox(height: 100)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: neonBlue,
        foregroundColor: Colors.black,
        onPressed: () {},
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Expense', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      bottomNavigationBar: BottomAppBar(
        color: surface,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 58,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navIcon(Icons.home_rounded, active: true),
              _navIcon(Icons.pie_chart_outline_rounded),
              const SizedBox(width: 40),
              _navIcon(Icons.history_rounded),
              _navIcon(Icons.settings_outlined),
            ],
          ),
        ),
      ),
    );
  }

  static String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 18) return 'Good afternoon';
    return 'Good evening';
  }

  static Widget _iconButton(IconData icon, {VoidCallback? onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap ?? () {},
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: const BoxDecoration(color: surface, shape: BoxShape.circle),
        child: Icon(icon, color: white, size: 19),
      ),
    );
  }

  static Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(color: white, fontSize: 15, fontWeight: FontWeight.bold),
    );
  }

  static Widget _statCard(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: neonBlue.withValues(alpha: 0.18)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: neonCyan, size: 20),
          const SizedBox(height: 6),
          Text(value,
              style: const TextStyle(color: white, fontSize: 15, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          const SizedBox(height: 2),
          Text(label,
              style: const TextStyle(color: textMuted, fontSize: 10.5),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  static Widget _quickAction(IconData icon, String label) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, color: neonBlue, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(label,
                  style: const TextStyle(color: white, fontSize: 12.5, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _categoryRow(IconData icon, String label, double amount, double total, Color color) {
    final pct = amount / total;
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(color: color.withValues(alpha: 0.15), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 17),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(label,
                        style: const TextStyle(color: white, fontSize: 13, fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis),
                  ),
                  Text('₱${amount.toStringAsFixed(0)}',
                      style: const TextStyle(color: white, fontSize: 13, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Container(height: 6, color: surfaceAlt),
                    FractionallySizedBox(
                      widthFactor: pct.clamp(0.0, 1.0),
                      child: Container(height: 6, color: color),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _transactionTile(IconData icon, String title, String subtitle, double amount, Color color) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: color.withValues(alpha: 0.15), shape: BoxShape.circle),
        child: Icon(icon, color: color, size: 19),
      ),
      title: Text(title,
          style: const TextStyle(color: white, fontSize: 13.5, fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis),
      subtitle: Text(subtitle, style: const TextStyle(color: textMuted, fontSize: 11.5)),
      trailing: Text('-₱${amount.toStringAsFixed(0)}',
          style: const TextStyle(color: danger, fontSize: 13.5, fontWeight: FontWeight.w700)),
      dense: true,
    );
  }

  static Widget _navIcon(IconData icon, {bool active = false}) {
    return Icon(icon, color: active ? neonBlue : textMuted, size: 24);
  }

  static Widget _divider() {
    return const Divider(height: 1, color: surfaceAlt, indent: 16, endIndent: 16);
  }
}