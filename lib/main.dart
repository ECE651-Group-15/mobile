import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'common/routes/routes.dart';
import 'common/utils/utils.dart';
import 'global.dart';

late SupabaseClient client;

Future<void> main() async {
  await Global.init();
  await initializeClient();

  // initialize supabase server
  var supabase = await Supabase.initialize(
    url: "https://ggyuylxzdyxjnasajohd.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdneXV5bHh6ZHl4am5hc2Fqb2hkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA3MDkzOTcsImV4cCI6MjAyNjI4NTM5N30.T86dumPMQGv7OamV4SOpzDdpHXJU8KNKo1ja5nPjfK0",
  );
  client = supabase.client;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => RefreshConfiguration(
        headerBuilder: () => const ClassicHeader(),
        footerBuilder: () => const ClassicFooter(),
        hideFooterWhenNotFull: true,
        headerTriggerDistance: 80,
        maxOverScrollExtent: 100,
        footerTriggerDistance: 150,
        child: GetMaterialApp(
          title: 'UW Exchange',
          // theme: AppTheme.light,
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.application,
          getPages: AppPages.routes,
          builder: EasyLoading.init(),
          navigatorObservers: [AppPages.observer],
          // localizationsDelegates: [
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          // ],
          fallbackLocale: const Locale('en', 'US'),
          enableLog: true,
          logWriterCallback: Logger.write,
        ),
      ),
    );
  }
}
