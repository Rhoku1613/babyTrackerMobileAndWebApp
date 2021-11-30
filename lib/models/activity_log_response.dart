class Vaccine {
  final int id;
  final String date;
  final String name;
  final int numberOfDoses;
  final int numberOfDosesTaken;
  final int child;


  Vaccine({required this.id,required this.date,required this.name,required this.numberOfDoses,
      required this.numberOfDosesTaken,required this.child});

  factory Vaccine.fromJson(Map<String, dynamic> json) {
    return Vaccine(id: json['id'],date:json['date'],name:json["name"],numberOfDoses:json['number_of_doses'],numberOfDosesTaken:json['number_of_doses_taken'],child: json['child']);
  }
}

class SleepLogs{
  final int id;
  final String date;
  final String start;
  final String end;
  final int child;

  SleepLogs({required this.id, required this.date, required this.start, required this.end, required this.child});

  factory SleepLogs.fromJson(Map<String, dynamic> json) {
    return SleepLogs(id: json['id'],date:json['date'],start:json["start"],end:json['end'],child: json['child']);
  }
}

class GrowthLogs{
  final int id;
  final String datetime;
  final String height;
  final int child;

  GrowthLogs({required this.id, required this.datetime, required this.height, required this.child});


  factory GrowthLogs.fromJson(Map<String, dynamic> json) {
    return GrowthLogs(id: json['id'],datetime:json['datetime'],height:json["start"],child: json['child']);
  }
}


