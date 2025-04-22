class Entity {
  Data? data;

  Entity({this.data});

  Entity.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Movies>? movies;

  Data({this.movies});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['movies'] != null) {
      movies = <Movies>[];
      json['movies'].forEach((v) {
        movies!.add(Movies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (movies != null) {
      data['movies'] = movies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Movies {
  String? elementId;
  String? identity;
  List<String>? labels;
  List<Actors>? actors;
  List<Directors>? directors; 
  Properties? properties;

  Movies({
    this.elementId,
    this.identity,
    this.labels,
    this.actors,
    this.directors, 
    this.properties,
  });

  Movies.fromJson(Map<String, dynamic> json) {
    elementId = json['elementId'];
    identity = json['identity'];
    labels = List<String>.from(json['labels'] ?? []);
    
    if (json['actors'] != null) {
      actors = <Actors>[];
      json['actors'].forEach((v) {
        actors!.add(Actors.fromJson(v));
      });
    }
    
    if (json['directors'] != null) {
      directors = <Directors>[];
      json['directors'].forEach((v) {
        directors!.add(Directors.fromJson(v));
      });
    }
    
    properties = json['properties'] != null
        ? Properties.fromJson(json['properties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['elementId'] = elementId;
    data['identity'] = identity;
    data['labels'] = labels;
    
    if (actors != null) {
      data['actors'] = actors!.map((v) => v.toJson()).toList();
    }

    if (directors != null) {
      data['directors'] = directors!.map((v) => v.toJson()).toList();
    }

    if (properties != null) {
      data['properties'] = properties!.toJson();
    }

    return data;
  }
}

class Actors {
  String? name;
  int? born;

  Actors({this.name, this.born});

  Actors.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    born = json['born'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['born'] = born;
    return data;
  }
}

class Directors {
  String? name;
  int? born;

  Directors({this.name, this.born});

  Directors.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    born = json['born'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['born'] = born;
    return data;
  }
}

class Properties {
  String? title;
  String? tagline;
  int? released;

  Properties({this.title, this.tagline, this.released});

  Properties.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    tagline = json['tagline'];
    released = json['released'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['title'] = title;
    data['tagline'] = tagline;
    data['released'] = released;
    return data;
  }
}
