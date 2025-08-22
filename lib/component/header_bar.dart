import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yi_chen_lu_protfolio/constant.dart';

import '../provider/responsive_provider.dart';

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
    final isMobile = Provider.of<ResponsiveProvider>(
      context,
      listen: true,
    ).isMobile;

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
                                  text: 'YICHEN   LU',
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

                // 導覽列
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

  @override
  Size get preferredSize => const Size.fromHeight(72);
}
