class Activity {
  final int id;
  final int child;
  final String type;

  Activity({required this.id, required this.child, required this.type});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(id: json['id'], child: json['child'], type: json['type']);
  }
}

class Child {
  final int id;
  final String name;
  final String dob;
  final double weight;
  final int height;
  final int parent;
  final String gender;

  Child(
      {required this.id,
      required this.name,
      required this.dob,
      required this.weight,
      required this.height,
      required this.parent,
      required this.gender});

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
        id: json['id'],
        name: json['name'],
        dob: json['dob'],
        weight: json['weight'],
        height: json['height'],
        parent: json['parent'],
        gender: json['gender']);
  }
}
