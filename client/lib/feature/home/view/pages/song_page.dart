import 'package:client/core/provider/current_song_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/feature/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SongPage extends ConsumerWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentlyPlayedSongs =
        ref.watch(homeViewmodelProvider.notifier).getRecentlyPlaySongs();
    final currentSong = ref.watch(currentSongNotifierProvider);

    return SafeArea(
      child: Container(
        decoration: currentSong == null
            ? null
            : BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    hexToColor(currentSong.hex_code),
                    Pallete.transparentColor,
                  ],
                  stops: const [0.0, 0.2],
                ),
              ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 36),
              child: SizedBox(
                height: 280,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: recentlyPlayedSongs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final song = recentlyPlayedSongs[index];

                    return GestureDetector(
                      onTap: () {
                        ref
                            .read(currentSongNotifierProvider.notifier)
                            .updateSong(song);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Pallete.borderColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          children: [
                            Container(
                              width: 56,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(song.thumbnail_url),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  bottomLeft: Radius.circular(4),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                song.song_name,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Latest today',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ref.watch(getAllSongsProvider).when(
                  data: (songs) {
                    print(songs);
                    return SizedBox(
                      height: 260,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: songs.length,
                        itemBuilder: (BuildContext context, int index) {
                          final song = songs[index];
                          return GestureDetector(
                            onTap: () {
                              ref
                                  .read(currentSongNotifierProvider.notifier)
                                  .updateSong(song);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 180,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          song.thumbnail_url,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: 180,
                                    child: Text(
                                      song.song_name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: 180,
                                    child: Text(
                                      song.artist,
                                      style: const TextStyle(
                                        color: Pallete.subtitleText,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  error: (error, st) {
                    return Center(
                      child: Text(
                        error.toString(),
                      ),
                    );
                  },
                  loading: () => const Loader(),
                ),
          ],
        ),
      ),
    );
  }
}
