import 'package:flutter/cupertino.dart';

class HeaderText extends StatelessWidget {
  final String text;

  const HeaderText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.center,
        softWrap: true,
        style: const TextStyle(fontWeight: FontWeight.w600));
  }
}

class SubHeaderText extends StatelessWidget {
  final String text;

  const SubHeaderText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w300));
  }
}

class TextWidgetsUtils {
  static List<Widget> generateHeaderWithSubHedaer() {
    return [
      const HeaderText('If you want to upload this photo to identify and'),
      const SizedBox(
        height: 10,
      ),
      const HeaderText(' object choose “Next”. '),
      const SizedBox(
        height: 10,
      ),
      const SubHeaderText('If not click “Back” and take a new picture.'),
      const SizedBox(
        height: 10,
      )
    ];
  }
}
