import 'package:iiit_suite/src/models/sgpa.dart';

List<double> getPoints(List<Sgpa> x) {
  List<double> res = [];
  for (Sgpa s in x) {
    res.add(double.parse(s.points));
  }
  return res;
}
