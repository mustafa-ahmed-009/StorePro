import 'package:flutter/material.dart';
import 'package:shops_manager_offline/core/utils/app_styles.dart'; // Import AppStyles

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final int index;
  final int currentIndex;
  final Function(int) onItemSelected;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.title,
    required this.index,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        onItemSelected(index);
      },
      child: Container(
        color: isSelected ? Colors.blue[100] : Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.blue : Colors.grey[700],
            ),
            const SizedBox(width: 12), // Add spacing between icon and text
            Text(
              title,
              style: AppStyles.styleMedium16(context).copyWith(
                color: isSelected ? Colors.blue : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
