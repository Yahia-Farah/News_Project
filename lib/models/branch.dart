class Branch {
  int count ;
  String name;
  int age;
  Branch({required this.age,required this.count,required this.name});
  factory Branch.fromJson(Map<String,dynamic> data) =>
      Branch(age: data['age'], count: data['count'], name: data['name']);
  toJson()=>{
    'count': count,
    'name': name,
    'age': age,
  };
}