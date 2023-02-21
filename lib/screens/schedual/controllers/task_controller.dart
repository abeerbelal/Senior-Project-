import 'package:chat_test/screens/schedual/models/task.dart';
import 'package:get/get.dart';
import '../DB/db_helper.dart';

//controller file will help us processing data
//controller sits between model and ui so
class TaskController extends GetxController{
  @override
  void onReady(){
    super.onReady();
  }
  var taskList = <Task>[].obs;
  Future<int> addTask({Task? task})async{
    return  await DBHelper.insert(task);
  }

  //get all data from table
void getTasks() async {//this list contains all the val from our query
    List<Map<String,dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
}
 void delete(Task task){
  DBHelper.delete(task);
  getTasks();

 }

 void markTaskCompleted(int id) async{//because updating may take time
  await  DBHelper.update(id);
  getTasks();
 }


}