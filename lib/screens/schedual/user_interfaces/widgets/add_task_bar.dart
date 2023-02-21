import 'package:chat_test/screens/schedual/controllers/task_controller.dart';
import 'package:chat_test/screens/schedual/models/task.dart';
import 'package:chat_test/screens/schedual/user_interfaces/theme.dart';
import 'package:chat_test/screens/schedual/user_interfaces/widgets/button.dart';
import 'package:chat_test/screens/schedual/user_interfaces/widgets/input_feild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController  _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();//to stor data on it and then stor them on DB
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
   String _endTime = "9:30 PM";
   String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
   int _selectedRemind = 5;
   List <int> remindList = [ 5,10,15,20 ];
   String _selectedRepeat = "None";
    List <String> repeaatList = [ "None", "Daily","weekly","monthly" ];
    int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar:  _appBar(context),
      body: Container(
        padding:  const EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Exercise",style: headingStyle,textAlign: TextAlign.left,),
              MyInputField(title: "Exercise", hint: "Enter your Exercise",controller: _titleController,),
              MyInputField(title: "note", hint: "Enter your note",controller: _noteController,),
              MyInputField(title: "Date", hint: DateFormat.yMd().format(_selectedDate),
              widget:IconButton(
                icon: Icon(Icons.calendar_today_outlined,
                color: Colors.grey,),
                onPressed: (){
                 _getDateFormUser();
                },
              ) ,
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                    title: "start time ",
                    hint: _startTime,
                    widget: IconButton(
                      onPressed: (){
                        _getTimeFromUser(isStartTime: true);
                      },
                      icon: Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    child: MyInputField(
                      title: "End time ",
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: (){
                          _getTimeFromUser(isStartTime: false);
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MyInputField(title: "Remind", hint: "$_selectedRemind   mintes early",
              widget:DropdownButton(
                onChanged: (String? newValue){
                  setState(() {
                    _selectedRemind = int.parse(newValue!);
                  });
                },
                icon: Icon(Icons.keyboard_arrow_down,
                color: Colors.grey,
                ),
                iconSize: 32,
                  elevation: 4,
                style: subTitleStyle,
                underline: Container(height: 0,),
                items:remindList.map<DropdownMenuItem<String>>((int value){
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                      child: Text(value.toString())
                  );
                }
                ).toList() ,
              ) ,
              ),
              MyInputField(title: "Repeat", hint: "$_selectedRepeat",
                widget:DropdownButton(
                  onChanged: (String? newValue){
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                  icon: Icon(Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0,),
                  items:repeaatList.map<DropdownMenuItem<String>>((String? value){
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value!,style: TextStyle(
                          color: Colors.grey
                        ),)
                    );
                  }
                  ).toList() ,
                ) ,
              ),
              SizedBox(height:18 ,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 // _colorPallets(),
                  MyButton(label: "Creat Task", onTap: ()=>_validateData())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  _validateData(){
   if(_titleController.text.isNotEmpty && _noteController.text.isNotEmpty){
     //add data to DB
     _addTaskToDB();//submit the data to the controller
     Get.back();//add then back to home page
   }else if(_titleController.text.isEmpty || _noteController.text.isEmpty){
   Get.snackbar("Required", "All fields are required!",
   snackPosition: SnackPosition.BOTTOM,
     backgroundColor: Colors.white,
     icon: Icon(Icons.warning_amber_rounded)
   );
   }
  }
  _addTaskToDB() async{
     int value = await  _taskController.addTask(
        task:Task(//passing data to the model
          note: _noteController.text,
          title: _titleController.text,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _startTime,
          endTime: _endTime,
          remind: _selectedRemind,
          repeat: _selectedRepeat,
          //color: _selectedColor,
          isCompleted:0,
        )
    );
     print("My id is "+ "$value");
  }
  _appBar(BuildContext context){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: (){
         Get.back();
        },
        child: Icon(Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white:Colors.black54,),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage(
              "images/yogaaa.png"
          ),
        ),
        SizedBox(width :20),

      ],
    );
  }
  _getDateFormUser() async{
    DateTime? _pickerDate =  await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015), lastDate: DateTime(2121));

    if(_pickerDate != null){
      setState(() {
        _selectedDate = _pickerDate;
        print(_selectedDate);
      });
    }else{
       print("it's null or somethiing is wrong");
    }
  }
  _getTimeFromUser({required bool isStartTime}) async{
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format (context);
    if(pickedTime == null){
      print("Time canceld");
    }else if(isStartTime == true){
      setState(() {
        _startTime = _formatedTime;
      });

    }else if(isStartTime == false){
      setState(() {
        _endTime = _formatedTime;
      });
    }



}
  _showTimePicker() {
     return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
          context: context,
          initialTime: TimeOfDay(
              hour: int.parse(_startTime.split(":")[0]),
              minute: int.parse(_startTime.split(":")[1].split(' ')[0]),
          )
      );
    }

}



