import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../core/logger.dart';

class TextLenght extends StatelessWidget {
  const TextLenght({super.key});

  @override
  Widget build(BuildContext context) {
    const text = 'lM';
    const double maxW = 3.6474609375 + 13.095703125 + 2.49464740754;
    const style = TextStyle(fontSize: 15);
    final double myLe = _getLenght(text, maxW, style);
    // final int myLe =
    // getSecondLineLength(text, const TextStyle(color: Colors.amber), 200.0);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Container(
              color: Colors.green,
              width: maxW,
              child: const Text(
                text,
                style: style,
              ),
            ),

            Container(
              color: Colors.red.withOpacity(0.3),
              // height: 100,

              child: TextFormField(
                style: const TextStyle(height: 10 / 15),
                cursorHeight: 10,
                cursorWidth: 30,
                cursorRadius: const Radius.circular(20),
                decoration: const InputDecoration(
                    // isDense: true,
                    // isCollapsed: true,
                    ),
              ),
            ),
            // Container(
            //   color: Colors.green,
            //   width: 20,
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: LayoutBuilder(builder: (context, pg) {
            //     logger(pg.widthConstraints().toString(), c);
            //     return Container(color: Colors.red, child: const Text(text));
            //   }),
            // ),
          ],
        ),
      ),
    );
  }

  double _getLenght(String text, double maxW, TextStyle style) {
    // final span = TextSpan(text: text);
    // final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    // tp.layout(maxWidth: 100);
    // text.split('').forEach((element) {
    //   final span = TextSpan(text: text);
    //   final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    //   // logger(tp.maxIntrinsicWidth, 'The tp');
    // });
    // final numLines = tp.computeLineMetrics().length;
    text.split('').forEach((element) {
      final TextPainter tp = TextPainter(
          text: TextSpan(text: element, style: style),
          textDirection: TextDirection.ltr);
      tp.layout(maxWidth: maxW);
      logger(tp.computeLineMetrics().first.width, 'The tp of $element');
      // logger(tp., 'The tp');
      // logger(tp.getBoxesForSelection(
      //     TextSelection(baseOffset: 0, extentOffset: element.length)));
    });
    return 1;
  }
}

// int getSecondLineLength(String text, TextStyle style, double maxWidth) {
//   // Create a TextPainter object
//   final TextPainter textPainter = TextPainter(
//     text: TextSpan(text: text, style: style),
//     textDirection: TextDirection.ltr,
//   )..

//       // Layout the text within the given width constraints
//       layout(maxWidth: maxWidth);

//   // Get the line metrics
//   final List<LineMetrics> lineMetrics = textPainter.computeLineMetrics();
//   logger(lineMetrics.length, 'Number of linbes');
//   logger(lineMetrics.first.height, 'Line height');
//   logger(lineMetrics.first.lineNumber, 'Line number');
//   logger(lineMetrics.first, 'Linearly');

//   if (lineMetrics.length < 2) {
//     return 0; // Less than 2 lines, no second line to measure
//   }

//   // Find the start and end offsets for the second line
//   final int startOffset = textPainter
//       .getPositionForOffset(Offset(0, lineMetrics[1].baseline))
//       .offset;
//   final int endOffset = textPainter
//       .getPositionForOffset(Offset(maxWidth, lineMetrics[1].baseline))
//       .offset;

//   // Extract the second line text
//   final String secondLineText = text.substring(startOffset, endOffset);

//   // Return the length of the second line text
//   return secondLineText.trim().length;
// }

// _getSecondLineLenght(String text, TextStyle textStyle, double maxWidth) {
//   final characters = text.split('');
//   const double lenghtD = 0;
//   for (final element in characters) {
//     // logger(element, 'The element');
//     LayoutBuilder(
//       builder: (context, constraints) {
//         logger(constraints, 'TextS Constrants for $element');
//         return Text(
//           element,
//           style: textStyle,
//         );
//       },
//     );
//   }
//   logger(lenghtD, 'The lenght oif the thing');
// }

int getSecondLineLength(String text, TextStyle style, double maxWidth) {
  // Create a TextPainter object
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
  );

  // Layout the text within the given width constraints
  textPainter.layout(maxWidth: maxWidth);

  // Get the line metrics
  final List<LineMetrics> lineMetrics = textPainter.computeLineMetrics();

  if (lineMetrics.length < 2) {
    return 0; // Less than 2 lines, no second line to measure
  }

  // Calculate the length of the second line
  final LineMetrics secondLine = lineMetrics[1];
  final double secondLineWidth = secondLine.width;
  String secondLineText = '';

  for (int i = 0; i < text.length; i++) {
    final String subText = text.substring(0, i + 1);
    final TextPainter tp = TextPainter(
      text: TextSpan(text: subText, style: style),
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: maxWidth);

    if (tp.computeLineMetrics().length > 1 &&
        tp.computeLineMetrics()[1].width <= secondLineWidth) {
      secondLineText = subText;
    } else if (tp.computeLineMetrics().length > 1) {
      secondLineText = subText.substring(subText.lastIndexOf(' ') + 1);
      break;
    }
  }

  return secondLineText.trim().length;
}
