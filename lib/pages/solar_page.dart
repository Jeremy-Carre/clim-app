import 'package:material_ui/material_ui.dart';

class SolarPage extends StatelessWidget {
  final String title;
  const SolarPage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(title)));
  }
}
