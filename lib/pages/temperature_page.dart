import 'package:material_ui/material_ui.dart';

class TemperaturePage extends StatelessWidget {
  final String title;
  const TemperaturePage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(title)));
  }
}
