import 'dart:convert';
import 'package:http/http.dart' as http;

class GeocodingService {
    Future<Map<String,double>> trouverCoordonnees(String ville) async {
        final url = Uri.https(
            'nominatim.openstreetmap.org',
            '/search',
            {
                'q' : ville,
                'format' : 'jsonv2',
                'limit' : '1',
            },
        );

        final reponse = await http.get(
            url,
            headers: {
                'User-Agent' : 'ClimApp/1.0',
            },
        );

        if (reponse.statusCode != 200) {
            throw Exception('Erreur recherche du lieu');
            }

        final resultats = jsonDecode(reponse.body) as List;

        if (resultats.isEmpty) {
            throw Exception('Lieu introuvable');
        }
        return {
            'latitude' : double.parse(resultats[0]['lat']),
            'longitude' : double.parse(resultats[0]['lon']),
            };
    }
}