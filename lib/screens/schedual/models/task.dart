//models tells you how to get data and how to
//set data to the data base and also the format

class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  //int? color;
  int? remind;
  String? repeat;

  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
   // this.color,
    this.remind,
    this.repeat,

});

Task.fromJson(Map<String,dynamic> json){// when i get the data from data base
  id=json['id'];
  title = json['title'];
  note = json['note'];
  isCompleted = json['isCompleted'];
  date = json['date'];
  startTime = json['startTime'];
  endTime = json['endTime'];
  remind = json['remind'];
  repeat = json['repeat'];
  }


  Map<String,dynamic> toJson(){//convert the data to json format
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] =  this.id;
    data ['title'] = this.title;
    data['date']  =  this.date;
    data ['note'] = this.note;
    data ['isCompleted']= this.isCompleted;
    data ['startTime'] = this.startTime;
    data  ['endTime'] = this.endTime;
    data ['remind']= this.remind;
    data ['repeat']= this.repeat;
    return data;

  }

}
//controller file will help us processing data