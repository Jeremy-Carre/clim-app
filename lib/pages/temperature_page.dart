
import 'package:material_ui/material_ui.dart';
import 'package:climapp/models/temperature_mods.dart';
import 'package:climapp/models/temperature_annuelle.dart';
import 'package:climapp/services/geocoding_service.dart';
import 'package:climapp/services/nasa_service.dart';
import 'package:climapp/calculs/temperature_calculs.dart';


// Attention affichage moche désolé c'est juste pour tester !!!

class TemperaturePage extends StatefulWidget {
  final String title;
  final TemperatureMods temperatureMod;

  const TemperaturePage({
    super.key,
    required this.title,
    required this.temperatureMod,
  });

  @override
  State<TemperaturePage> createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {
  final GeocodingService geocodingService = GeocodingService();
  final NasaService nasaService = NasaService();

  final TextEditingController lieuController =
      TextEditingController();

  List<TemperatureAnnuelle> temperatures = [];

  Future<void> rechercher() async {
    setState(() {
      temperatures = [];
    });

    final coordonnees = await geocodingService.trouverCoordonnees(
      lieuController.text.trim(),
    );

    final resultats = await nasaService.recupererTemperatures(
      latitude: coordonnees['latitude']!,
      longitude: coordonnees['longitude']!,
    );


    if (!mounted) return;

    setState(() {
      temperatures = resultats;
    });
  }

  @override
  void dispose() {
    lieuController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Text(widget.title),

          TextField(
            controller: lieuController,
            decoration: const InputDecoration(
              labelText: 'Lieu',
              hintText: 'Ex. : Paris, France',
            ),
          ),

          ElevatedButton(
            onPressed: rechercher,
            child: const Text('Rechercher'),
          ),
          if (temperatures.length >= 20)
            Text(
              'La température moyenne a '
              '${calculerRechauffement(temperatures) >= 0 ? "augmenté" : "diminué"} de '
              '${calculerRechauffement(temperatures).abs().toStringAsFixed(1)} °C '
              'entre les dix premières et dix dernières années.'),

          Expanded(
            child: ListView(
              children: temperatures.map((t) {
                final valeur =
                    widget.temperatureMod == TemperatureMods.fahrenheit
                        ? t.temperature * 9 / 5 + 32
                        : t.temperature;

                final unite =
                    widget.temperatureMod == TemperatureMods.celsius
                        ? '°C'
                        : '°F';

                return Text(
                  '${t.annee} : ${valeur.toStringAsFixed(1)} $unite',
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}