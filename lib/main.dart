import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/local_stroage.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/pages/home_page.dart';

final locator = GetIt.instance; //9 10 11 12 get it paketi kullanımı ile ilgili
void setupGetIt() {
  locator.registerSingleton<LocalStorage>(HiveLocalStroage());
}

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Box<Task> taskBox = await Hive.openBox("tasks");

  //TaskBox içini gezerek aynı günde olmayan tasklar siliniyor
  taskBox.values.forEach((task) {
    if (task.createdAt.day != DateTime.now().day) {
      taskBox.delete(task.id);
    }
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  ); // STatusBar Yani en üstteki bilgirim menülerinin olduğu barın rengi değiştirildi

  await setupHive();
  setupGetIt(); //get_it
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('tr', 'TR')],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: const Locale(
            'en', 'US'), //herhangi ssorunda ingilizceyi kullancak   s
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates, //dil
      supportedLocales: context.supportedLocales, //dil
      locale:
          context.deviceLocale, //dil  //uygulama cihazın dili ile başlayacak
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.blue),
        ),
      ),
      home: const HomePage(),
    );
  }
}
