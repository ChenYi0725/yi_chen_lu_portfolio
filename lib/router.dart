import 'package:go_router/go_router.dart';
import 'package:yi_chen_lu_protfolio/page/about_page.dart';
import 'package:yi_chen_lu_protfolio/page/contact_page.dart';
import 'package:yi_chen_lu_protfolio/page/dance_page.dart';
import 'package:yi_chen_lu_protfolio/page/home_page.dart';
import 'package:yi_chen_lu_protfolio/page/resume_page.dart';
import 'package:yi_chen_lu_protfolio/page/theatre_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomePage()),
    GoRoute(path: '/theatre', builder: (context, state) => TheatrePage()),
    GoRoute(path: '/about', builder: (context, state) => AboutPage()),
    GoRoute(path: '/resume', builder: (context, state) => ResumePage()),
    GoRoute(path: '/contact', builder: (context, state) => ContactPage()),
    GoRoute(path: '/dance', builder: (context, state) => DancePage()),
  ],
);
