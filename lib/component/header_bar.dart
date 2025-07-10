import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yi_chen_lu_protfolio/constant.dart';

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
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 左側名稱
                    Flexible(
                      fit: FlexFit.loose,
                      child: InkWell(
                        onTap: () => context.go('/'),
                        child: Text(
                          'YI CHEN LU',
                          style: headerBarNameStyle,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ),
                    ),

                    // 導覽列
                    Wrap(
                      // ✅ 使用 Wrap 解決項目 overflow 的問題
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
                );
              },
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: const Divider(
              height: 5,
              color: Colors.white54,
              thickness: 3,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72);
}
