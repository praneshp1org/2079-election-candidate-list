class District {
  List bbox = [];
  var title_en, title_ne;
  Centroid centroid;
  District.fromJson(Map<String, dynamic> json)
      : bbox = json['bbox'],
        title_en = json['title_en'],
        title_ne = json['title_ne'],
        centroid = Centroid.fromJson(json['centroid']);
}

class Centroid {
  List coordinates = [];
  Centroid.fromJson(Map<String, dynamic> json)
      : coordinates = json['coordinates'];
}
