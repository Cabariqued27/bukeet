import 'package:bukeet/theme/theme.dart';
import 'package:bukeet/utils/app/app_size.dart';
import 'package:bukeet/widgets/inputs/single_input_widget.dart';
import 'package:flutter/material.dart';

class HourAvailabilityTile extends StatelessWidget {
  final int hour;
  final bool isActive;
  final int price;
  final Function(bool) onToggleActive;
  final Function(int) onPriceChanged;
  final AppTheme theme;

  const HourAvailabilityTile({
    super.key,
    required this.hour,
    required this.isActive,
    required this.price,
    required this.onToggleActive,
    required this.onPriceChanged,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final averageWindowController =
        TextEditingController(text: price.toString());

    return GestureDetector(
      onTap: () => onToggleActive(!isActive),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive ? Colors.green[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '$hour:00',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isActive ? theme.black.value : theme.gray.value,
                ),
              ),
            ),
            SizedBox(
              width: AppSize.width()*0.28,
              child: SizedBox(
                height: 50.0,
                child: SingleInputWidget(
                  isActive: isActive,
                  controller: averageWindowController,
                  hintText: 'Precio',
                  textInputType: TextInputType.number,
                  onChanged: (value) {
                    final parsed = int.tryParse(value);
                    if (parsed != null) {
                      onPriceChanged(parsed);
                    }
                  },
                  mandatory: false,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
