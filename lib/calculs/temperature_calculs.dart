import '../models/temperature_annuelle.dart';

double calculerMoyenne(List<TemperatureAnnuelle> temperatures) {
    if (temperatures.isEmpty) {
        return 0;
    }


final somme = temperatures.fold<double>(0, (total,t) => total + t.temperature,);
return somme / temperatures.length;
}

double calculerRechauffement(List<TemperatureAnnuelle> temperatures){
    if (temperatures.length < 20) {
        return 0;
    }


final premieresAnnees = temperatures.take(10).toList();
final dernieresAnnees = temperatures.skip(temperatures.length - 10).toList();

return calculerMoyenne(dernieresAnnees) - calculerMoyenne(premieresAnnees);
}