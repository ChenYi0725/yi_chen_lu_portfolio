import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yi_chen_lu_protfolio/constant.dart';

import '../provider/responsive_provider.dart';

class HeaderBar extends StatelessWidget implements PreferredSizeWidget {
  static const double _compactHeaderBreakpoint = 1100;

  final String currentRoute;
  final Function(String) onNavItemSelected;

  HeaderBar({
    super.key,
    required this.currentRoute,
    required this.onNavItemSelected,
  });

  final navItems = [
    {'label': 'Theatre', 'route': '/theatre'},
    {'label': 'Opera', 'route': '/opera'},
    {'label': 'Dance', 'route': '/dance'},
    {'label': 'Assistant', 'route': '/assistant'},
    {'label': 'Paperwork', 'route': '/paperwork'},
    {'label': 'About', 'route': '/about'},
    {'label': 'Contact', 'route': '/contact'},
    {'label': 'Resume', 'route': '/resume'},
  ];

  Widget mobileLayout({required Widget child, required bool isMobile}) {
    return !isMobile ? Center(child: child) : child;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Provider.of<ResponsiveProvider>(
      context,
      listen: true,
    ).isMobile;
    final useCompactHeader =
        isMobile || MediaQuery.sizeOf(context).width < _compactHeaderBreakpoint;

    if (useCompactHeader) {
      return Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 69,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => context.go('/'),
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'YI-CHEN   LU',
                                style: headerBarNameStyle,
                              ),
                              const TextSpan(text: '  '),
                              TextSpan(
                                text: 'LIGHTING DESIGNER',
                                style: headerBarTitleStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Open navigation',
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () => _showNavigationDrawer(context),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 3, color: Colors.white54, thickness: 3),
          ],
        ),
      );
    }

    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Row(
              mainAxisAlignment: !isMobile
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.start,
              children: [
                // 左側名稱
                !isMobile
                    ? Flexible(
                        fit: FlexFit.loose,
                        child: InkWell(
                          onTap: () => context.go('/'),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'YI-CHEN   LU',
                                  style: headerBarNameStyle,
                                ),
                                TextSpan(text: "  "),
                                TextSpan(
                                  text: 'LIGHTING DESIGNER',
                                  style: headerBarTitleStyle,
                                ),
                              ],
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),

                Wrap(
                  spacing: 24,
                  children: navItems.map((item) {
                    final isSelected = currentRoute == item['route'];
                    return InkWell(
                      onTap: () => onNavItemSelected(item['route']!),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 100),
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: isSelected
                            ? const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              )
                            : null,
                        child: Text(
                          item['label']!,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: headerBarTextStyle.copyWith(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: !isMobile ? 16 : 14,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const Divider(height: 3, color: Colors.white54, thickness: 3),
        ],
      ),
    );
  }

  Future<void> _showNavigationDrawer(BuildContext context) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close navigation',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (dialogContext, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: Drawer(
            backgroundColor: themeColor,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                    title: Text('YI-CHEN LU', style: headerBarNameStyle),
                    subtitle: Text(
                      'LIGHTING DESIGNER',
                      style: headerBarTitleStyle,
                    ),
                    onTap: () {
                      Navigator.of(dialogContext).pop();
                      context.go('/');
                    },
                  ),
                  const Divider(color: Colors.white38),
                  Expanded(
                    child: ListView(
                      children: navItems.map((item) {
                        final route = item['route']!;
                        final isSelected = currentRoute == route;
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          selected: isSelected,
                          selectedTileColor: Colors.white12,
                          title: Text(
                            item['label']!,
                            style: headerBarTextStyle.copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          trailing: isSelected
                              ? const Icon(
                                  Icons.chevron_right,
                                  color: Colors.white70,
                                )
                              : null,
                          onTap: () {
                            Navigator.of(dialogContext).pop();
                            onNavItemSelected(route);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72);
}
