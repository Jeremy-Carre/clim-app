import 'package:material_ui/material_ui.dart';

class FirePage extends StatelessWidget {
  final String title;
  const FirePage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(title)));
  }
}
