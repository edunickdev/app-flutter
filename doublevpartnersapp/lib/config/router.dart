import 'package:doublevpartnersapp/presentation/screens/details_screen.dart';
import 'package:doublevpartnersapp/presentation/screens/form_screen.dart';
import 'package:doublevpartnersapp/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  routes: [
    GoRoute(path: "/", redirect: (context, state) => "/home"),
    GoRoute(path: "/home", builder: (context, state) => const HomeScreen()),
    GoRoute(path: "/form", builder: (context, state) => const FormScreen()),
    GoRoute(
      path: "/details",
      builder: (context, state) => const DetailsScreen(),
    ),
  ],
);
