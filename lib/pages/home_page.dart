import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todo_app/data/local_stroage.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/widgets/custom_search_delegate.dart';
import 'package:todo_app/widgets/task_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Task> _allTasks;
  late LocalStorage _localStorage;

  @override
  void initState() {
    super.initState();
    _localStorage = locator<LocalStorage>();
    _allTasks = <Task>[];
    _allTasks.add(Task.create(name: "deneme Task", createdAt: DateTime.now()));
    _getAllTaskDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            _showAddTaskBottomSheet(context);
          },
          child: const Text(
            "Bugün Neler Yapacaksın?",
            style: TextStyle(color: Colors.black),
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              _onSearchPage();
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              _showAddTaskBottomSheet(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: _allTasks.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                var _oAnkiListeElemani = _allTasks[index];
                return Dismissible(
                  background: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(Icons.delete, color: Colors.red),
                      Text(
                        "Sil",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                  key: Key(_oAnkiListeElemani.id),
                  onDismissed: (direction) {
                    _allTasks.removeAt(index);
                    _localStorage.deleteTask(task: _oAnkiListeElemani);
                    setState(() {});
                  },
                  child: TaskItem(
                    task: _oAnkiListeElemani,
                  ),
                );
              },
              itemCount: _allTasks.length,
            )
          : const Center(
              child: Text("Görev Yok "),
            ),
    );
  }

  void _showAddTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      //showModalBottomSheet alttan açılır pencere
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom), //klavyenin hemen üstüne gelmesi için
          width: MediaQuery.of(context).size.width,
          child: ListTile(
            title: TextField(
              autofocus: true, //klavye direkmen açılsın ve yazılabilsin diye
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(
                  hintText: "Görev Nedir ?", border: InputBorder.none),
              onSubmitted: (value) {
                Navigator.of(context)
                    .pop(); //alttan açılı pencereyi(showModalBottomSheet) kapatacak
                if (value.length > 3) {
                  //TextFielde girilen metin 3 karakterden büyük ise
                  //showTimePicker ekranı görünecek
                  //bu ekrande saniye çubuğu kalatıldı
                  //onConfirmde bulunan time bize seçilen zamanı vermekte
                  DatePicker.showTimePicker(context, showSecondsColumn: false,
                      onConfirm: (time) async {
                    var yeniEklenecekGorev =
                        Task.create(name: value, createdAt: time);
                    _allTasks.insert(0, yeniEklenecekGorev);
                    await _localStorage.addTask(task: yeniEklenecekGorev);
                    setState(() {});
                  });
                }
              },
            ),
          ),
        );
      },
    );
  }

  void _getAllTaskDb() async {
    _allTasks = await _localStorage.getAllTask();
    setState(() {});
  }

  void _onSearchPage() {
    showSearch(
        context: context, delegate: CustomSearchDelegate(allTasks: _allTasks));
  }
}
