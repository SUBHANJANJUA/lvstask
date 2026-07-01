import 'package:get/get.dart';

class HomeController extends GetxController {
  final selectedTabIndex = 0.obs;
  final selectedCountryIndex = 0.obs;
  final selectedBottomIndex = 0.obs;

  final tabs = const ['Stream', 'Hot', 'Follow'];

  final countries = const [
    CountryFilter('🌐', 'Global'),
    CountryFilter('🇮🇳', 'India'),
    CountryFilter('🇵🇭', 'Philippines'),
    CountryFilter('🇧🇷', 'Brazil'),
    CountryFilter('🇻🇳', 'Vietnam'),
  ];

  final streams = const [
    StreamUser(
      name: 'Sofia Chen',
      flag: '🇵🇭',
      viewers: '8.2K',
      imageUrl:
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=700&q=80',
    ),
    StreamUser(
      name: 'Sofia Chen',
      flag: '🇵🇭',
      viewers: '8.2K',
      imageUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=700&q=80',
    ),
    StreamUser(
      name: 'Sofia Chen',
      flag: '🇵🇭',
      viewers: '8.2K',
      imageUrl:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=700&q=80',
    ),
    StreamUser(
      name: 'Sofia Chen',
      flag: '🇵🇭',
      viewers: '8.2K',
      imageUrl:
          'https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?auto=format&fit=crop&w=700&q=80',
    ),
    StreamUser(
      name: 'Sofia Chen',
      flag: '🇵🇭',
      viewers: '8.2K',
      imageUrl:
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=700&q=80',
    ),
    StreamUser(
      name: 'Sofia Chen',
      flag: '🇵🇭',
      viewers: '8.2K',
      imageUrl:
          'https://images.unsplash.com/photo-1509967419530-da38b4704bc6?auto=format&fit=crop&w=700&q=80',
    ),
  ];

  void selectTab(int index) {
    selectedTabIndex.value = index;
  }

  void selectCountry(int index) {
    selectedCountryIndex.value = index;
  }

  void selectBottomItem(int index) {
    selectedBottomIndex.value = index;
  }
}

class CountryFilter {
  const CountryFilter(this.icon, this.label);

  final String icon;
  final String label;
}

class StreamUser {
  const StreamUser({
    required this.name,
    required this.flag,
    required this.viewers,
    required this.imageUrl,
  });

  final String name;
  final String flag;
  final String viewers;
  final String imageUrl;
}
