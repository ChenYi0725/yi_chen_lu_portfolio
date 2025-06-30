import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HeaderBar extends StatelessWidget implements PreferredSizeWidget {
  final String currentRoute;
  final Function(String) onNavItemSelected;

  HeaderBar({
    super.key,
    required this.currentRoute,
    required this.onNavItemSelected,
  });

  final navItems = [
    {'label': 'Theatre', 'route': '/theatre'},
    {'label': 'Dance', 'route': '/dance'},
    {'label': 'About', 'route': '/about'},
    {'label': 'Contact', 'route': '/contact'},
    {'label': 'Resume', 'route': '/resume'},
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => context.go('/'),
                  child: const Text(
                    'YI CHEN LU',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                // 右側導覽列
                Row(
                  children: navItems.map((item) {
                    final isSelected = currentRoute == item['route'];
                    return InkWell(
                      onTap: () => onNavItemSelected(item['route']!),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
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
                          style: TextStyle(
                            fontSize: 16,
                            color: isSelected ? Colors.white : Colors.grey[300],
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          // 分隔線
          const Divider(height: 5, color: Colors.white54, thickness: 3),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72); // 高度你可微調
}
