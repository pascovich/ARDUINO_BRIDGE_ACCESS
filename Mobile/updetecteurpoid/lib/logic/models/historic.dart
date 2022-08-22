class ResultHistoric {
  List<Historic>? historics;
  ResultHistoric();

  ResultHistoric.fromJson(Map<String, dynamic> json) {
    historics = [];
    if (json['historique'] != null) {
      json['historique'].forEach((hist) {
        historics!.add(Historic.fromJson(hist));
      });
    }
  }
}

class Historic {
  String? id;
  String? heuredate;
  double? poids;
  String? decision;

  Historic.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    heuredate = json['heuredate'];
    poids = double.tryParse(json['poids'].toString());
    decision = json['decision'];
  }
}
