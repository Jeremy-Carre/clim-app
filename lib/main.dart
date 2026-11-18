import 'package:climapp/models/temperature_mods.dart';
import 'package:climapp/pages/fire_page.dart';
import 'package:climapp/pages/solar_page.dart';
import 'package:climapp/pages/temperature_page.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const MyApp(darkMode: false));
}

class MyApp extends StatefulWidget {
  final bool darkMode;
  const MyApp({super.key, required this.darkMode});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _darkMode;
  Icon navigationModIcon = Icon(Icons.dark_mode);
  String themText = 'Activer le mode sombre';
  int currentPageIndex = 0;
  TemperatureMods temperatureMod = TemperatureMods.celsius;

  void toogleNavigationTheme(bool value) {
    setState(() {
      navigationModIcon = (value)
          ? Icon(Icons.light_mode)
          : Icon(Icons.dark_mode);

      themText = (value) ? 'Activer le mode clair' : 'Activer le mode sombre';
      _darkMode = value;
    });
  }

  void toogleTemperatureMode(Set<TemperatureMods> selection) {
    setState(() {
      temperatureMod = selection.first;
    });
  }

  @override
  void initState() {
    super.initState();
    _darkMode = widget.darkMode;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clim-App',
      theme: _darkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text(
            "Clim-App",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: .zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blueGrey),
                child: Text(
                  'Paramétres',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              SwitchListTile(
                title: Text(themText),
                value: _darkMode,
                onChanged: toogleNavigationTheme,
                secondary: navigationModIcon,
              ),
              ListTile(
                title: Text('Unité de température'),
                trailing: SegmentedButton(
                  segments: const <ButtonSegment<TemperatureMods>>[
                    ButtonSegment<TemperatureMods>(
                      value: TemperatureMods.celsius,
                      label: Text('°C'),
                    ),
                    ButtonSegment<TemperatureMods>(
                      value: TemperatureMods.fahrenheit,
                      label: Text('°F'),
                    ),
                  ],
                  selected: {temperatureMod},
                  onSelectionChanged: toogleTemperatureMode,
                ),
              ),
            ],
          ),
        ),
        body: IndexedStack(
          index: currentPageIndex,
          children: [
            TemperaturePage(title: "Ici c'est la page de température ",temperatureMod: temperatureMod,),
            FirePage(title: "Ici c'est la pages des incendies ."),
            SolarPage(title: "Ici c'est la page de l'énergie solaire ."),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.blueGrey,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.thermostat),
              icon: Icon(Icons.thermostat_outlined),
              label: 'Température',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.fire_extinguisher),
              icon: Icon(Icons.fire_extinguisher_outlined),
              label: 'Incendies',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.solar_power),
              icon: Icon(Icons.solar_power_outlined),
              label: 'Solaire',
            ),
          ],
        ),
      ),
    );
  }
}
