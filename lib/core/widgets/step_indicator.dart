import 'package:flutter/material.dart';

/// A little AppBar bottom widget that draws a full-width line,
/// positions the step‑circle on it (evenly spaced for N steps),
/// and puts the label below.
class StackStepIndicator extends StatelessWidget implements PreferredSizeWidget {
  final int currentStep;
  final int totalSteps;
  final String label;
  final Color lineColor;
  final Color circleColor;
  final Color circleTextColor;
  final double lineThickness;
  final double circleDiameter;
  final TextStyle? labelStyle;

  const StackStepIndicator({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
    required this.label,
    this.lineColor = Colors.grey,
    this.circleColor = Colors.red,
    this.circleTextColor = Colors.white,
    this.lineThickness = 2,
    this.circleDiameter = 30,
    this.labelStyle,
  })  : assert(currentStep >= 1 && currentStep <= totalSteps),
        super(key: key);

  // height = circle + spacing + label
  @override
  Size get preferredSize => Size.fromHeight(circleDiameter + 8 + 16);

  @override
  Widget build(BuildContext context) {
    // map step 1 → x = -1.0, step N → x = +1.0
    final double alignX = totalSteps == 1
        ? 0.0
        : -1.0 + 2 * (currentStep - 1) / (totalSteps - 1);

    return SizedBox(
      height: preferredSize.height,
      child: Column(
        children: [
          // The line + circle stacked on top of each other
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // full-width baseline
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: lineThickness,
                      color: lineColor,
                    ),
                  ),
                ),

                // the moving/red circle
                Align(
                  alignment: Alignment(alignX, 0),
                  child: Container(
                    width: circleDiameter,
                    height: circleDiameter,
                    decoration: BoxDecoration(
                      color: circleColor,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$currentStep',
                      style: TextStyle(
                        color: circleTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
          // the label
          Text(
            label,
            style: labelStyle ??
                const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
