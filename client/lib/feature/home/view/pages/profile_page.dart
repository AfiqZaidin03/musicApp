import 'package:client/core/provider/current_user_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/app_bar.dart';
import 'package:client/feature/auth/view/pages/login_page.dart';
import 'package:client/feature/auth/viewmodel/auth_viewmodel.dart';
import 'package:client/feature/home/view/widgets/profile_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(currentUserNotifierProvider);
    final userSignOut = ref.watch(authViewModelProvider.notifier);

    return Scaffold(
      appBar: BasicAppbar(
        hideBack: false,
        title: SvgPicture.asset(
          'assets/icons/app_icon.svg',
          height: 60,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: CircleAvatar(
                backgroundColor: Pallete.containerColor,
                radius: 50,
                child: Icon(
                  Icons.person,
                  size: 85,
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (userData != null) ...[
              ProfileContainer(
                label: 'Username',
                value: userData.name,
                isFirst: true,
              ),
              ProfileContainer(
                label: 'Email',
                value: userData.email,
              ),
              ProfileContainer(
                label: 'Favorites',
                value: '${userData.favorites.length}',
                isLast: true,
              ),
            ] else ...[
              const Center(child: Text('User data not available')),
            ],
            const SizedBox(height: 24),
            Center(
              child: TextButton(
                onPressed: () {
                  userSignOut.signOutUser();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                    (_) => false,
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Pallete.containerColor),
                ),
                child: const Text(
                  'Sign Out',
                  style: TextStyle(
                    color: Pallete.greyColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
