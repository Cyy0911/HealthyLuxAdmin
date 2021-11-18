import 'package:firebase_storage/firebase_storage.dart';

class VideoFile {
  final Reference ref;
  final String name;
  final String url;

  const VideoFile({
    required this.ref,
    required this.name,
    required this.url,
  });
}
