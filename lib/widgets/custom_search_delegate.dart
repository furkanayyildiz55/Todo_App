import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/local_stroage.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/widgets/task_list_item.dart';

import '../main.dart';

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
    //yazma ekranında solada kalan kısım geri gel kısmı
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
    return filteredList.isNotEmpty
        ? ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              var _oAnkiListeElemani = filteredList[index];
              return Dismissible(
                background: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    const Icon(Icons.delete, color: Colors.red),
                    const Text(
                      "remove_task",
                      style: TextStyle(color: Colors.red),
                    ).tr()
                  ],
                ),
                key: Key(_oAnkiListeElemani.id),
                onDismissed: (direction) async {
                  filteredList.removeAt(index);
                  await locator<LocalStorage>()
                      .deleteTask(task: _oAnkiListeElemani);
                },
                child: TaskItem(
                  task: _oAnkiListeElemani,
                ),
              );
            },
          )
        :  Center(
            child: Text("search_not_found").tr(),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
