import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide MenuItem;
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:petbook/create_pet_profile_new/create_pet_profile_new_widget.dart';
import 'package:petbook/home_page/first_screen.dart';
import 'auth/firebase_user_provider.dart';
import 'auth/auth_util.dart';

import 'home_page/menu.dart';
import 'petbook/petbook_util.dart';
import 'petbook/petbook_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page/home_page_widget.dart';
import 'profile_page/profile_page_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  ThemeMode _themeMode = ThemeMode.system;
  Stream<PetbookFirebaseUser> userStream;
  PetbookFirebaseUser initialUser;
  bool displaySplashImage = true;
  final authUserSub = authenticatedUserStream.listen((_) {});

  void setLocale(Locale value) => setState(() => _locale = value);
  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

  @override
  void initState() {
    super.initState();
    userStream = petbookFirebaseUserStream()
      ..listen((user) => initialUser ?? setState(() => initialUser = user));
    Future.delayed(
        Duration(seconds: 1), () => setState(() => displaySplashImage = false));
  }

  @override
  void dispose() {
    authUserSub.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'petbook',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xffF5CAC3),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark, // 2
        ),
        
      ),
      themeMode: _themeMode,
      home: initialUser == null || displaySplashImage
          ? Container(
              color: Colors.transparent,
              child: Builder(
                builder: (context) => Image.asset(
                  'assets/images/splash_screen.png',
                  fit: BoxFit.cover,
                ),
              ),
            )
          : currentUser.loggedIn
              ? NavBarPage()
              : FirstScreen(),
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key key, this.initialPage}) : super(key: key);

  final String initialPage;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  String _currentPage = 'homePage';

  MenuItem currentItem = MenuItems.home;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? _currentPage;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: ZoomDrawer(
    mainScreen: getScreen(),
    borderRadius: 30,
    showShadow: true,
    //angle: -10,
    slideWidth: MediaQuery.of(context).size.width * 0.8,
    shadowLayer2Color: const Color(0xff84A59D),
    shadowLayer1Color: const Color(0xff3A405A),
    menuScreen: Builder(
      builder: (context) => MenuPage(
      currentItem: currentItem,
      onSelectedItem: (item) {
        setState(() {
          currentItem = item;
        });

        ZoomDrawer.of(context).close();
      }
    ))),
  );

  Widget getScreen() {
    switch(currentItem) {
      case MenuItems.home:
        return HomePageWidget();
      case MenuItems.addPet:
        return CreatePetProfileNewWidget();
      case MenuItems.settings:
        return ProfilePageWidget();
      default: 
        return HomePageWidget(); 
    }
  }


  /*
  @override
  Widget build(BuildContext context) {
    final tabs = {
      'homePage': HomePageWidget(),
      'profilePage': ProfilePageWidget(),
      //'allChatsPage': AllChatsPageWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPage);
    return Scaffold(
      body: tabs[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => _currentPage = tabs.keys.toList()[i]),
        backgroundColor: PetbookTheme.of(context).tertiaryColor,
        selectedItemColor: PetbookTheme.of(context).primaryColor,
        unselectedItemColor: PetbookTheme.of(context).grayIcon,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              FFIcons.khome,
              size: 24,
            ),
            label: 'Home',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.account_circle,
              size: 24,
            ),
            label: 'Profile',
            tooltip: '',
          ),
          /*BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble_outline,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.chat_bubble_outlined,
              size: 24,
            ),
            label: 'Messages',
            tooltip: '',
          )*/
        ],
      ),
    );
  }*/
}
