import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

sealed class AppIcons {
  static final Widget arrowRight = SvgPicture.asset(
    'assets/svg/arrow_right.svg',
  );
  static final Widget group = SvgPicture.asset('assets/svg/Group.svg');
  static final Widget vector1 = SvgPicture.asset(
    'assets/svg/Vector 1.svg',
    height: 130,
  );
  static final Widget cloud = SvgPicture.asset(
    'assets/svg/cloud-svgrepo-com.svg',
    height: 50,
  );
  static final Widget vector3 = SvgPicture.asset(
    'assets/svg/Vector 3.svg',
    height: 130,
  );
  static final Widget vector2 = SvgPicture.asset(
    'assets/svg/Vector 2.svg',
    height: 90,
  );

  ///  sign in page

  static final Widget pattern1 = SvgPicture.asset(
    'assets/svg/Group-2.svg',
    height: 130,
  );
  static final Widget pattern2 = SvgPicture.asset(
    'assets/svg/Group-3.svg',
    height: 100,
  );
  static final Widget todoHive = SvgPicture.asset(
    'assets/svg/Frame 7.svg',
    height: 39.4,
    width: 198.4,
  );
  static final Widget homePattern = SvgPicture.asset(
    'assets/svg/home_pattern.svg',
    height: 80,
  );
  static final Widget google = SvgPicture.asset(
    'assets/svg/logo googleg 48dp.svg',
    height: 30,
  );

  /// home
  static final Widget project = SvgPicture.asset(
    'assets/svg/project-3.svg',
    width: 40,
    height: 40,
  );
  static final Widget work = SvgPicture.asset(
    'assets/svg/work.svg',
    width: 30,
    height: 30,
    color: Colors.black,
  );
  static final Widget dailyTask = SvgPicture.asset(
    'assets/svg/gym.svg',
    width: 30,
    height: 30,
  );
  static final Widget groceries = SvgPicture.asset(
    'assets/svg/grocies.svg',
    width: 40,
    height: 40,
  );
  static final Widget edit = SvgPicture.asset(
    'assets/svg/edit.svg',
    width: 20,
    height: 20,
  );
  static final Widget delete = SvgPicture.asset(
    'assets/svg/remove.svg',
    width: 20,
    height: 20,
  );
  static final Widget editPattern = SvgPicture.asset(
    'assets/svg/edit_pattern.svg',
    width: 70,
    height: 70,
  );
  static final sound = Icons.volume_up_outlined;

  /// image user
  static final user = Image.asset(
    'assets/png/user.png',
    width: 100,
    height: 100,
  );
}
