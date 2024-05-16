import 'dart:convert';

class CharacterModel {
  String id;
  String? image;
  String name;
  Gender? gender;
  String? age;
  String eyeColor;
  String hairColor;
  List<String> films;
  String species;
  String url;

  CharacterModel({
    required this.id,
    this.image,
    required this.name,
    required this.gender,
    required this.age,
    required this.eyeColor,
    required this.hairColor,
    required this.films,
    required this.species,
    required this.url,
  }) {
    image = getImageUrlForId(id);
  }

  String getImageUrlForId(String id) {
    Map<String, String> imageMap = {
      "267649ac-fb1b-11eb-9a03-0242ac130003":
          "https://static.wikia.nocookie.net/studio-ghibli/images/8/89/Haku-2.png/revision/latest/thumbnail/width/360/height/450?cb=20201008131345",
      "fe93adf2-2f3a-4ec4-9f68-5422f1b87c01":
          "https://static.wikia.nocookie.net/studio-ghibli/images/8/8b/Pazu.jpg/revision/latest?cb=202102142050232",
      "598f7048-74ff-41e0-92ef-87dc1ad980a9":
          "https://static.wikia.nocookie.net/studio-ghibli/images/b/bb/Sheeta_3.png/revision/latest?cb=20221030023634",
      "3bc0b41e-3569-4d20-ae73-2da329bf0786":
          "https://static.wikia.nocookie.net/disney/images/c/c3/5688-2094236141.jpg/revision/latest?cb=20140915192650",
      "abe886e7-30c8-4c19-aaa5-d666e60d14de":
          "https://static.wikia.nocookie.net/studio-ghibli/images/d/d5/Muska.jpg/revision/latest?cb=20210516132909",
      "e08880d0-6938-44f3-b179-81947e7873fc":
          "https://static.wikia.nocookie.net/studio-ghibli/images/d/de/Uncle_Pom.png/revision/latest?cb=20180809131657",
      "5c83c12a-62d5-4e92-8672-33ac76ae1fa0":
          "https://static.wikia.nocookie.net/studio-ghibli/images/1/12/Muoro.jpg/revision/latest?cb=20210516135925",
      "3f4c408b-0bcc-45a0-bc8b-20ffc67a2ede":
          "https://static.wikia.nocookie.net/studio-ghibli/images/0/0a/Duffi.png/revision/latest?cb=20170504183048",
      "fcb4a2ac-5e41-4d54-9bba-33068db083ca":
          "https://static.wikia.nocookie.net/studio-ghibli/images/2/28/Charlies.jpg/revision/latest/thumbnail/width/360/height/450?cb=20181031025246",
    };

    return imageMap[id] ??
        "https://i.pinimg.com/736x/52/5f/4e/525f4e461721696d958b58350da1af8d.jpg";
  }

  factory CharacterModel.fromRawJson(String str) =>
      CharacterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        id: json["id"],
        name: json["name"],
        gender: genderValues.map[json["gender"]]!,
        age: json["age"],
        eyeColor: json["eye_color"],
        hairColor: json["hair_color"],
        films: List<String>.from(json["films"].map((x) => x)),
        species: json["species"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "gender": genderValues.reverse[gender],
        "age": age,
        "eye_color": eyeColor,
        "hair_color": hairColor,
        "films": List<dynamic>.from(films.map((x) => x)),
        "species": species,
        "url": url,
      };
}

enum Gender { FEMALE, MALE, NA }

final genderValues =
    EnumValues({"Female": Gender.FEMALE, "Male": Gender.MALE, "NA": Gender.NA});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
