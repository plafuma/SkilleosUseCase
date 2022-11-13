import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skilleos/src/presentation/screens/favorites_screen.dart';
import 'package:flutter_skilleos/src/presentation/screens/home_screen.dart';
import 'package:flutter_skilleos/src/utils/color_constants.dart';
import '../providers/bottom_navigation_providers.dart';

class BottomNavigation extends ConsumerWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: IndexedStack(
        index: ref.watch(providerIndex),
        children: const [
          HomeScreen(),
          FavoritesScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          ref.read(providerIndex.notifier).state = index;
        },
        currentIndex: ref.watch(providerIndex),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: AppLocalizations.of(context).homePageTabTitle,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_outline_sharp),
            label: AppLocalizations.of(context).favoritesPageTabTitle,
          ),
        ],
        selectedItemColor: ColorConstants.redSkilleos,
      ),
    );
  }
}
