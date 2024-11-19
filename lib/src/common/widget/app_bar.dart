import 'package:blood_donation/src/common/repository/authentication_repository.dart';
import 'package:flutter/material.dart';

class BDAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BDAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.redAccent,
      leading: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
            onPressed: () => AuthenticationRepository().logout(),
            icon: const Icon(Icons.logout))
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
