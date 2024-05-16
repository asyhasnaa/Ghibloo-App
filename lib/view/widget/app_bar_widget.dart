import 'package:flutter/material.dart';
import 'package:ghibloo_app/view/screen/films/film_list_screen.dart';
import 'package:iconsax/iconsax.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FilmListScreen(),
                ),
              );
            },
            child: const Icon(
              Iconsax.notification,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
        const Icon(
          Iconsax.people,
          size: 30,
          color: Colors.black,
        ),
      ],
    );
  }
}
