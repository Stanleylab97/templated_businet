import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/blocs/ads_bloc.dart';
import 'package:news_app/blocs/article_notification_bloc.dart';
import 'package:news_app/blocs/bookmark_bloc.dart';
import 'package:news_app/blocs/categories_bloc.dart';
import 'package:news_app/blocs/documentaires.dart';
import 'package:news_app/blocs/comments_bloc.dart';
import 'package:news_app/blocs/custom_notification_bloc.dart';
import 'package:news_app/blocs/featured_bloc.dart';
import 'package:news_app/pages/entrepreneur/posts/widgets/home_bloc.dart';
import 'package:news_app/blocs/internet_bloc.dart';
import 'package:news_app/blocs/notification_bloc.dart';
import 'package:news_app/blocs/popular_articles_bloc.dart';
import 'package:news_app/blocs/recent_articles_bloc.dart';
import 'package:news_app/blocs/related_articles_bloc.dart';
import 'package:news_app/blocs/tab_index_bloc.dart';
import 'package:news_app/blocs/search_bloc.dart';
import 'package:news_app/blocs/sign_in_bloc.dart';
import 'package:news_app/blocs/theme_bloc.dart';
import 'package:news_app/blocs/videos_bloc.dart';
import 'package:news_app/pages/splash.dart';
import 'package:provider/provider.dart';
import 'blocs/podcasts.dart';
import 'blocs/category_tab3_bloc.dart';
import 'blocs/comments_bloc.dart';
import 'models/theme_model.dart';

import 'models/chat/chat_params.dart';
import 'package:news_app/pages/chat/chat/chat_screen.dart';

FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics();
FirebaseAnalyticsObserver firebaseObserver =
    FirebaseAnalyticsObserver(analytics: firebaseAnalytics);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  runApp(EasyLocalization(
    supportedLocales: [Locale('fr'), Locale('en'), Locale('es')],
    path: 'assets/translations',
    fallbackLocale: Locale('fr'),
    startLocale: Locale('fr'),
    useOnlyLangCode: true,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeBloc>(
      create: (_) => ThemeBloc(),
      child: Consumer<ThemeBloc>(
        builder: (_, mode, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<HomeBLoC>(
                create: (context) => HomeBLoC(),
              ),
              ChangeNotifierProvider<InternetBloc>(
                create: (context) => InternetBloc(),
              ),
              ChangeNotifierProvider<SignInBloc>(
                create: (context) => SignInBloc(),
              ),
              ChangeNotifierProvider<CommentsBloc>(
                create: (context) => CommentsBloc(),
              ),
              ChangeNotifierProvider<BookmarkBloc>(
                create: (context) => BookmarkBloc(),
              ),
              ChangeNotifierProvider<SearchBloc>(
                  create: (context) => SearchBloc()),
              ChangeNotifierProvider<FeaturedBloc>(
                  create: (context) => FeaturedBloc()),
              ChangeNotifierProvider<PopularBloc>(
                  create: (context) => PopularBloc()),
              ChangeNotifierProvider<RecentBloc>(
                  create: (context) => RecentBloc()),
              ChangeNotifierProvider<CategoriesBloc>(
                  create: (context) => CategoriesBloc()),
              ChangeNotifierProvider<AdsBloc>(create: (context) => AdsBloc()),
              ChangeNotifierProvider<RelatedBloc>(
                  create: (context) => RelatedBloc()),
              ChangeNotifierProvider<TabIndexBloc>(
                  create: (context) => TabIndexBloc()),
              ChangeNotifierProvider<NotificationBloc>(
                  create: (context) => NotificationBloc()),
              ChangeNotifierProvider<CustomNotificationBloc>(
                  create: (context) => CustomNotificationBloc()),
              ChangeNotifierProvider<ArticleNotificationBloc>(
                  create: (context) => ArticleNotificationBloc()),
              ChangeNotifierProvider<VideosBloc>(
                  create: (context) => VideosBloc()),
              ChangeNotifierProvider<CategoryTab1Bloc>(
                  create: (context) => CategoryTab1Bloc()),
              ChangeNotifierProvider<CategoryTab2Bloc>(
                  create: (context) => CategoryTab2Bloc()),
            ],
            child: MaterialApp(
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                locale: context.locale,
                navigatorObservers: [firebaseObserver],
                theme: ThemeModel().lightMode,
                darkTheme: ThemeModel().darkMode,
                themeMode:
                    mode.darkTheme == true ? ThemeMode.dark : ThemeMode.light,
                debugShowCheckedModeBanner: false,
                home: SplashPage(),
                // initialRoute: '/',
                onGenerateRoute: (settings) =>
                    RouteGenerator.generateRoute(settings)),
          );
        },
      ),
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == '/chat') {
      var arguments = settings.arguments;
      if (arguments != null) {
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ChatScreen(chatParams: arguments as ChatParams),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              animation =
                  CurvedAnimation(curve: Curves.ease, parent: animation);
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            });
      } else {
        return pageNotFound();
      }
    }
  }
}

MaterialPageRoute pageNotFound() {
  return MaterialPageRoute(
      builder: (context) => Scaffold(
          appBar: AppBar(title: Text("Error"), centerTitle: true),
          body: Center(
            child: Text("Page not found"),
          )));
}
