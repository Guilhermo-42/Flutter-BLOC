class Fact {
  final String id;
  final String name;

  Fact(this.id, this.name);

  Fact.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

}