import 'package:climapp/pages/fire_page.dart';
import 'package:climapp/pages/solar_page.dart';
import 'package:climapp/pages/temperature_page.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clim-App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text(
            "Clim-App",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        body: IndexedStack(
          index: currentPageIndex,
          children: [
            TemperaturePage(title: "Ici c'est la page de Température ."),
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
