import 'package:chat_test/screens/schedual/controllers/task_controller.dart';
import 'package:chat_test/screens/schedual/services/theme_services.dart';
import 'package:chat_test/screens/schedual/user_interfaces/theme.dart';
import 'package:chat_test/screens/schedual/user_interfaces/widgets/add_task_bar.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:chat_test/screens/schedual/user_interfaces/widgets/button.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:chat_test/screens/schedual/user_interfaces/widgets/task_tile.dart';

import '../models/task.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.backgroundColor,//coustom app bar
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          SizedBox(height: 10,),
          _showTasks(),
        ],
      ),
    );
  }

  _showTasks(){
    return Expanded(
        child: Obx((){
      return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (_, index){
            print(_taskController.taskList.length);
            Task task = _taskController.taskList[index];
            print(task.toJson());
            if(task.repeat=='Daily') {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          ),

                        ],
                      ),
                    ),
                  ));
            }
            if(task.date==DateFormat.yMd().format(_selectedDate)){
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          ),

                        ],
                      ),
                    ),
                  ));
            }else{
              return Container();
            }


      });
    }),
    );
  }

  _showBottomSheet(BuildContext context, Task task){
  Get.bottomSheet(Container(
    padding: const EdgeInsets.only(top: 4),
    height: task.isCompleted==1?
        MediaQuery.of(context).size.height*0.24:
        MediaQuery.of(context).size.height*0.32,
        color: Get.isDarkMode?darkGreyClr:Colors.white,
        child: Flexible(
          child: Column(
            children: [
              Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300]
                ),
              ),
              Spacer(),
              task.isCompleted==1
              ?Container()
                  :_bottomSheetButton(
                lable: 'Task Completed',
                onTap: (){
                  _taskController.markTaskCompleted(task.id!);
                  Get.back();
                },
                clr: primaryClr,
                context:context,
              ),

              _bottomSheetButton(
                lable: 'Delete Task ',
                onTap: (){
                  _taskController.delete(task);
                //  _taskController.getTasks();
                  Get.back();
                },
                clr: Colors.red[300]!,
                context:context,
              ),
              SizedBox(
                height: 10,
              ),
              _bottomSheetButton(
                lable: 'Close ',
                onTap: (){
                  Get.back();
                },
                clr: Colors.red[300]!,
                isClose: true,
                context:context,
              ),

            ],
          ),
        ),
  )
  );
  }

  _bottomSheetButton({
    required String lable,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width*0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color:isClose==true?Get.isDarkMode?Colors.grey[600]!:Colors.grey[300]!:clr,
          ),
         borderRadius: BorderRadius.circular(20) ,
          color: isClose==true?Colors.transparent:clr,
        ),
        child: Center(
          child: Text(
            lable,
            style: isClose?titleStyle:titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );

  }
_addDateBar(){
    return Container(
      margin: EdgeInsets.only(top: 20,left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle:GoogleFonts.lato(
            textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.grey
            )
        ),
        dayTextStyle:GoogleFonts.lato(
            textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.grey
            )
        ),
        monthTextStyle:GoogleFonts.lato(
            textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.grey
            )
        ),
        onDateChange: (date){
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
}
_addTaskBar(){
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,),
                Text("Today",style: headingStyle,)
              ],
            ),
          ),
          MyButton(label: "+ Add Task", onTap: () async{
           await Get.to(()=>AddTaskPage());//as this await we want to refresh the list
          _taskController.getTasks();
          }
          )
        ],
      ),
    );
  }
_appBar(){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: (){
            ThemeService().switchTheme();

          /*  notifyHeper.displayNotification(
              title :"theme changed",
              body:Get.isDarkMode?"Activated Dark Theme":"Activated Light Theme"
            );*/
        },
        child: Icon(Get.isDarkMode ? Icons.wb_sunny_outlined:Icons.nightlight_round,
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
}


