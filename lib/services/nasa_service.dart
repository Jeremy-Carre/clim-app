import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/temperature_annuelle.dart';

class NasaService {
    Future<List<TemperatureAnnuelle>> recupererTemperatures({
        required double latitude,
        required double longitude,
    }) async {
        final derniereAnnee = DateTime.now().year -1;

        final url = Uri.https('power.larc.nasa.gov',
        '/api/temporal/monthly/point',
        {
        'parameters' : 'T2M',
        'community' : 'RE',
        'latitude' : latitude.toString(),
        'longitude' : longitude.toString(),
        'start' : '1981',
        'end' : derniereAnnee.toString(),
        'format' : 'JSON',
    },
    );

    final reponse = await http.get(url);

    if (reponse.statusCode != 200) {
        throw Exception('Erreur pendant la récupération des temperatures');
    }

    final donnees = jsonDecode(reponse.body);
    final valeurs = donnees['properties']['parameter']['T2M']
        as Map<String,dynamic>;

    final temperaturesParAnnee = <int,List<double>>{};

    final temperatures = <TemperatureAnnuelle>[];
    valeurs.forEach((mois,valeur) {
        if (mois.endsWith('13')) {
            final annee = int.parse(mois.substring(0,4));
            final temperature = (valeur as num).toDouble();

            if (temperature > -900) {
                temperatures.add(
                    TemperatureAnnuelle(
                    annee: annee,
                    temperature: temperature,
                    ),
                );
            }
        }
    });

    temperatures.sort((a,b) => a.annee.compareTo(b.annee));

    return temperatures;
}
}
