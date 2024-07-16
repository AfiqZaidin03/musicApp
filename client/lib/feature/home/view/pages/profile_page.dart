import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BasicAppbar(
        hideBack: false,
        title: SvgPicture.asset(
          'assets/icons/app_icon.svg',
          height: 60,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                backgroundColor: Pallete.gradient2,
                radius: 50,
                child: Icon(
                  Icons.person,
                  size: 85,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
