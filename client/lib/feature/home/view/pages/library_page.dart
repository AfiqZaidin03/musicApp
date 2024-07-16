import 'package:client/core/provider/current_song_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/app_bar.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/feature/home/view/pages/upload_song_page.dart';
import 'package:client/feature/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BasicAppbar(
        hideBack: true,
        action: IconButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (BuildContext context) => const ProfilePage(),
            //   ),
            // );
          },
          icon: const Icon(Icons.person),
        ),
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
              'Favorites',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 700,
              child: ref.watch(getAllFavSongsProvider).when(
                    data: (data) {
                      return ListView.builder(
                        itemCount: data.length + 1,
                        itemBuilder: (context, index) {
                          if (index == data.length) {
                            return ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const UploadSongPage(),
                                  ),
                                );
                              },
                              leading: const CircleAvatar(
                                radius: 35,
                                backgroundColor: Pallete.backgroundColor,
                                child: Icon(CupertinoIcons.plus),
                              ),
                              title: const Text(
                                'Upload New Song',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            );
                          }

                          final song = data[index];

                          return ListTile(
                            onTap: () {
                              ref
                                  .read(currentSongNotifierProvider.notifier)
                                  .updateSong(song);
                            },
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(song.thumbnail_url),
                              radius: 35,
                              backgroundColor: Pallete.backgroundColor,
                            ),
                            title: Text(
                              song.song_name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            subtitle: Text(
                              song.artist,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    error: (error, stackTrace) {
                      return Center(
                        child: Text(error.toString()),
                      );
                    },
                    loading: () => const Loader(),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
