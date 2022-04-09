import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/widgets/task_list_item.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Task> allTasks;

  CustomSearchDelegate({required this.allTasks});

  @override
  List<Widget>? buildActions(BuildContext context) {
    //yazma ekranında sağda kalan kısım
    return [
      IconButton(
          onPressed: () {
            query.isEmpty ? null : query = '';
          },
          icon: const Icon(
            Icons.clear,
            color: Colors.red,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //yazma ekranında solada kalan kısım
    return GestureDetector(
      onTap: () {
        close(context, null);
      },
      child: const Icon(
        Icons.arrow_back_ios,
        color: Colors.yellow,
        size: 24,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //arama metni yazıp klavyeden onayladıktan sonraki gösterilecek kısımlar
    var filteredList = allTasks
        .where(
            (gorev) => gorev.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return filteredList.length > 0
        ? ListView.builder(
            itemBuilder: (context, index) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  var _oAnkiListeElemani = filteredList[index];
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
                      filteredList.removeAt(index);
                      // _localStorage.deleteTask(task: _oAnkiListeElemani);
                    },
                    child: TaskItem(
                      task: _oAnkiListeElemani,
                    ),
                  );
                },
                itemCount: filteredList.length,
              );
            },
            itemCount: filteredList.length)
        : const Center(
            child: Text("Arama Sonucu Yok"),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //arama metni yazılırken gösterilecek kısımlar
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
