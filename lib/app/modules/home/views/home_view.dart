import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_logo.dart';
import '../../../core/widgets/round_icon_button.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(18.w, 28.h, 18.w, 0),
                  sliver: SliverToBoxAdapter(
                    child: _Header(controller: controller),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 28.h)),
                SliverToBoxAdapter(child: _Tabs(controller: controller)),
                SliverToBoxAdapter(child: SizedBox(height: 26.h)),
                SliverToBoxAdapter(
                  child: _CountryFilters(controller: controller),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 22.h)),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 168.h),
                  sliver: SliverGrid.builder(
                    itemCount: controller.streams.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: .69,
                    ),
                    itemBuilder: (context, index) {
                      return _StreamCard(user: controller.streams[index]);
                    },
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _BottomNavigation(controller: controller),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const AppLogo(size: 58),
        const Spacer(),
        RoundIconButton(
          icon: Icons.notifications_none_rounded,
          badge: '3',
          size: 58,
          onTap: () {},
        ),
        SizedBox(width: 16.w),
        RoundIconButton(
          icon: Icons.wallet_rounded,
          size: 58,
          hasGradient: true,
          iconColor: AppColors.white,
          onTap: () {},
        ),
      ],
    );
  }
}

class _Tabs extends StatelessWidget {
  const _Tabs({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Obx(() {
            final isSelected = controller.selectedTabIndex.value == index;
            return GestureDetector(
              onTap: () => controller.selectTab(index),
              child: Text(
                controller.tabs[index],
                style: TextStyle(
                  color: isSelected ? AppColors.green : AppColors.textMuted,
                  fontSize: 22.sp,
                  fontWeight: isSelected ? FontWeight.w900 : FontWeight.w500,
                ),
              ),
            );
          });
        },
        separatorBuilder: (_, _) => SizedBox(width: 34.w),
        itemCount: controller.tabs.length,
      ),
    );
  }
}

class _CountryFilters extends StatelessWidget {
  const _CountryFilters({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final country = controller.countries[index];
          return Obx(() {
            final isSelected = controller.selectedCountryIndex.value == index;
            return GestureDetector(
              onTap: () => controller.selectCountry(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.green.withValues(alpha: .10)
                      : AppColors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.brightGreen
                        : AppColors.divider,
                    width: 1.3,
                  ),
                ),
                child: Row(
                  children: [
                    Text(country.icon, style: TextStyle(fontSize: 17.sp)),
                    SizedBox(width: 10.w),
                    Text(
                      country.label,
                      style: TextStyle(
                        color: isSelected
                            ? AppColors.textPrimary
                            : AppColors.textMuted,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        },
        separatorBuilder: (_, _) => SizedBox(width: 10.w),
        itemCount: controller.countries.length,
      ),
    );
  }
}

class _StreamCard extends StatelessWidget {
  const _StreamCard({required this.user});

  final StreamUser user;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18.r),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(user.imageUrl, fit: BoxFit.cover),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xB0000000)],
                stops: [.45, 1],
              ),
            ),
          ),
          Positioned(
            top: 10.h,
            left: 10.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: AppColors.black.withValues(alpha: .52),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.remove_red_eye,
                    color: AppColors.white,
                    size: 16.sp,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    user.viewers,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 10.w,
            right: 10.w,
            bottom: 12.h,
            child: Row(
              children: [
                Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.white.withValues(alpha: .55),
                      width: 1.2,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        user.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(user.flag, style: TextStyle(fontSize: 11.sp)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 11.w,
                    vertical: 7.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lime,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    '+ Follow',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation({required this.controller});

  final HomeController controller;

  static const _items = [
    _BottomNavItem(Icons.home_rounded, 'Home'),
    _BottomNavItem(Icons.celebration_outlined, 'Party'),
    _BottomNavItem(Icons.radio_button_checked_rounded, 'Go Live'),
    _BottomNavItem(Icons.near_me_outlined, 'Chats'),
    _BottomNavItem(Icons.person_outline_rounded, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 154.h,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipPath(
              clipper: BottomNavBarClipper(),
              child: SizedBox(
                height: 122.h,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        AppColors.lime,
                        Color(0xFF7BE400),
                        AppColors.green,
                      ],
                      stops: [0, .46, 1],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 44.h, 16.w, 0),
                        child: Obx(
                          () => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(_items.length, (index) {
                              final item = _items[index];
                              final isLive = index == 2;
                              final isSelected =
                                  controller.selectedBottomIndex.value == index;

                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => controller.selectBottomItem(index),
                                child: SizedBox(
                                  width: 72.w,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (isLive)
                                        SizedBox(height: 26.h)
                                      else
                                        Icon(
                                          item.icon,
                                          color: AppColors.white.withValues(
                                            alpha: isSelected ? 1 : .76,
                                          ),
                                          size: 29.sp,
                                        ),
                                      SizedBox(height: isLive ? 0 : 8.h),
                                      _BottomLabel(
                                        label: item.label,
                                        isSelected: isSelected,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 14.h,
                        child: Center(
                          child: Container(
                            width: 164.w,
                            height: 5.h,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: GestureDetector(
              onTap: () => controller.selectBottomItem(2),
              child: Container(
                width: 76.w,
                height: 76.w,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: .18),
                      blurRadius: 12,
                      offset: Offset(0, 6.h),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.sensors_rounded,
                  color: AppColors.green,
                  size: 35.sp,
                ),
              ),
            ),
          ),
          Positioned(
            top: 73.h,
            child: Container(
              width: 12.w,
              height: 12.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(6.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomLabel extends StatelessWidget {
  const _BottomLabel({required this.label, required this.isSelected});

  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: AppColors.white.withValues(alpha: isSelected ? 1 : .80),
        fontSize: 13.5.sp,
        height: 1,
        fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
      ),
    );
  }
}

class _BottomNavItem {
  const _BottomNavItem(this.icon, this.label);

  final IconData icon;
  final String label;
}

class BottomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final center = size.width / 2;
    final notchRadius = 46.w;
    final notchDepth = 44.h;
    final bottomRadius = 42.r;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(center - notchRadius - 10.w, 0)
      ..cubicTo(
        center - notchRadius * .72,
        0,
        center - notchRadius * .84,
        notchDepth,
        center,
        notchDepth,
      )
      ..cubicTo(
        center + notchRadius * .84,
        notchDepth,
        center + notchRadius * .72,
        0,
        center + notchRadius + 10.w,
        0,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - bottomRadius)
      ..quadraticBezierTo(
        size.width,
        size.height,
        size.width - bottomRadius,
        size.height,
      )
      ..lineTo(bottomRadius, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - bottomRadius)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
