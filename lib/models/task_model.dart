import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'task_model.g.dart'; //hive için

@HiveType(typeId: 1)
class Task extends HiveObject {
  //Sınıf HiveObjec den türetildi böylelikle update ve delete daha kolay oluyor
// flutter packages pub run build_runner build  en son bu kod terminalde çalıştırılıyor
  @HiveField(0)
  //Hive için ekleniyor ,veritabanına eklenecek Alanlar Tanıtılıyor
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  bool isCompleted;

  Task(
      {required this.id,
      required this.name,
      required this.createdAt,
      required this.isCompleted});

  factory Task.create({required String name, required DateTime createdAt}) {
    return Task(
        id: const Uuid().v1(), //benzersiz id için
        name: name,
        createdAt: createdAt,
        isCompleted: false);
  }
}
