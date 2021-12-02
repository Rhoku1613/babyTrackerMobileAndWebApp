class Blog {
  final int id;
  final String title;
  final String body;

  Blog({
    required this.id,
    required this.title,
    required this.body
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'],
      body:json['body']
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class SleepData{

  final String date;
  final int hours;

  SleepData(this.date, this.hours);
}