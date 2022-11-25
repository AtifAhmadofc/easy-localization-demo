import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:implement_easy_localization/generated/locale_keys.g.dart';

Future<void> main() async {

   WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();


   runApp(
     EasyLocalization(
         supportedLocales: [const Locale('en'), const Locale('es', 'SP')],
         path: 'assets/translations', // <-- change the path of the translation files
         fallbackLocale: const Locale('en'),
         child: const MyApp()
     ),
   );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              Text("Selected language: ${context.locale.toString()}"),

              const Text("\nWith Dictionary"),
              const Text("title").tr(),

              const Text("\n\nWith Generated Local Keys"),
              const Text(LocaleKeys.title).tr(),

              TextButton(
                onPressed: () {
                  if(context.locale.toString()=="en")
                  context.setLocale(Locale('es', 'SP'));
                  else
                    context.setLocale(Locale('en'));

                },
                child: Text(
                  context.locale.toString()=="en"?
                  "to Spnaish":
                  "to Englis",
                ),
              ),


              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black
                  )
                ),
                child: Text('''"msg":"{} is a {lang} developer",\n
  "gender":{
    "male":"Hi man",
    "female":"Hello girl"
  }''',

                ),
              ),


              Text('msg').tr(args: ['Atif',],namedArgs:{"lang":"Flutter"}),

              Text('gender').tr(gender: true ? "female" : "male"),
            ],
          ),
        ),
      ),
    );
  }
}
