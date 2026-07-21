import 'package:go_router/go_router.dart';
// import 'package:noorah/auth/login_page.dart';
// import 'package:noorah/auth/register_page.dart';
import 'package:noorah/features/Azkar/adhkar_page.dart';
import 'package:noorah/features/Azkar/dhikr_page.dart';
// import 'package:noorah/features/Azkar/morning_evening_page.dart';
import 'package:noorah/features/home/home_page.dart';
import 'package:noorah/features/home/widgets/setup/setup_pages.dart';
import 'package:noorah/features/profile/pages/language_page.dart';
import 'package:noorah/features/profile/pages/notifications_page.dart';
import 'package:noorah/features/profile/pages/rate_page.dart';
import 'package:noorah/features/profile/profile_page.dart';
import 'package:noorah/features/profile/widgets/about_page.dart';
import 'package:noorah/features/profile/widgets/edit_profile_page.dart';
import 'package:noorah/features/quran/quran_page.dart';

import 'package:noorah/features/splash/splash_page.dart';
import 'package:noorah/qibla/qibla_page.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),


GoRoute(
  path: "/setup",
  builder: (context, state) => const SetupPage(),
),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
     GoRoute(
      path: '/quran',
      builder: (context, state) => const QuranPage(),
    ),

    GoRoute(
    path: '/dhikr',
    builder: (context, state) =>  DhikrPage(),
),

   GoRoute(
  path: '/profile',
  builder: (context, state) => const ProfilePage(),
),
   GoRoute(
  path: '/about',
  builder: (context, state) => const AboutPage(),
),


GoRoute(
  path: '/language',
  builder: (context, state) => const LanguagePage(),
),

GoRoute(
  path: '/notifications',
  builder: (context, state) => const NotificationsPage(),
),

GoRoute(
  path: '/rate',
  builder: (context, state) => const RatePage(),
),
 GoRoute(
  path: "/qibla",
  builder: (context, state) => const QiblaPage(),
),


GoRoute(
  path: '/adhkar',
  builder: (context, state) => const AdhkarPage(),
),


// GoRoute(
//   path: '/login',
//   builder: (context, state) => const LoginPage(),
// ),

// GoRoute(
//   path: '/register',
//   builder: (context, state) => const RegisterPage(),
// ),
// GoRoute(
//   path: '/edit-name',
//   builder: (context, state) => const EditNamePage(),
// ),
// GoRoute(
//   path: "/morning-evening",
//   builder: (context, state) => const MorningEveningPage(),
// ),

GoRoute(
  path: "/edit-profile",
  builder: (context, state) {
    final extra = state.extra as Map<String, dynamic>;

    return EditProfilePage(
      currentName: extra["name"],
      currentLocation: extra["location"],
    );
  },
),

  ],
);