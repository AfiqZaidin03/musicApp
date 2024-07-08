import 'dart:io';

import 'package:client/core/constants/server_constant.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  Future<void> uploadSong(
    File seletedImage,
    File selectedAudio,
  ) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${ServerConstant.serverUrl}/song/upload'),
    );

    request
      ..files.addAll(
        [
          await http.MultipartFile.fromPath('song', selectedAudio.path),
          await http.MultipartFile.fromPath('thumbnail', seletedImage.path)
        ],
      )
      ..fields.addAll(
        {
          'artist': 'Tanjiro',
          'song_name': 'Demon boi',
          'hex_code': 'FFFFFF',
        },
      )
      ..headers.addAll(
        {
          'x-auth-token':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdiNDcyZjRlLTJhNjUtNDU1YS1iYjVkLTE3MTMyZWVkMDg2YSJ9.7U98JFjFHW8b1EhUfEn7T7jpQokYt_7wQNY5ugs5kc4'
        },
      );
    final res = await request.send();
    print(res);
  }
}
