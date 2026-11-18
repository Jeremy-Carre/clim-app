import 'package:climapp/models/temperature_mods.dart';
import 'package:material_ui/material_ui.dart';

class TemperaturePage extends StatelessWidget {
  final String title;
  final TemperatureMods temperatureMod;
  TemperaturePage({
    super.key,
    required this.title,
    required this.temperatureMod,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('$title in ${temperatureMod.name} .')),
    );
  }
}
