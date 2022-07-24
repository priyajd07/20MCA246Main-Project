import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';

import '../auth/auth_util.dart';
import 'flutter_flow_util.dart';

const allowedFormats = {'image/png', 'image/jpeg', 'video/mp4', 'image/gif'};

class SelectedMedia {
  const SelectedMedia(this.storagePath, this.bytes);
  final String storagePath;
  final Uint8List bytes;
}

enum MediaSource {
  photoGallery,
  videoGallery,
  camera,
}

Future<SelectedMedia> selectMediaWithSourceBottomSheet({
  BuildContext context,
  double maxWidth,
  double maxHeight,
  bool allowPhoto,
  bool allowVideo = false,
  String pickerFontFamily = 'Roboto',
  Color textColor = const Color(0xFF111417),
  Color backgroundColor = const Color(0xFFF5F5F5),
}) async {
  final createUploadMediaListTile =
      (String label, MediaSource mediaSource) => ListTile(
            title: Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.getFont(
                pickerFontFamily,
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            tileColor: backgroundColor,
            dense: false,
            onTap: () => Navigator.pop(
              context,
              mediaSource,
            ),
          );
  final mediaSource = await showModalBottomSheet<MediaSource>(
      context: context,
      backgroundColor: backgroundColor,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: ListTile(
                title: Text(
                  'Choose Source',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    pickerFontFamily,
                    color: textColor.withOpacity(0.65),
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                tileColor: backgroundColor,
                dense: false,
              ),
            ),
            const Divider(),
            if (allowPhoto && allowVideo) ...[
              createUploadMediaListTile(
                'Gallery (Photo)',
                MediaSource.photoGallery,
              ),
              const Divider(),
              createUploadMediaListTile(
                'Gallery (Video)',
                MediaSource.videoGallery,
              ),
            ] else if (allowPhoto)
              createUploadMediaListTile(
                'Gallery',
                MediaSource.photoGallery,
              )
            else
              createUploadMediaListTile(
                'Gallery',
                MediaSource.videoGallery,
              ),
            const Divider(),
            createUploadMediaListTile('Camera', MediaSource.camera),
            const Divider(),
            const SizedBox(height: 10),
          ],
        );
      });
  if (mediaSource == null) {
    return null;
  }
  return selectMedia(
    maxWidth: maxWidth,
    maxHeight: maxHeight,
    isVideo: mediaSource == MediaSource.videoGallery ||
        (mediaSource == MediaSource.camera && allowVideo && !allowPhoto),
    mediaSource: mediaSource,
  );
}

Future<SelectedMedia> selectMedia({
  double maxWidth,
  double maxHeight,
  bool isVideo = false,
  MediaSource mediaSource = MediaSource.camera,
}) async {
  final picker = ImagePicker();
  final source = mediaSource == MediaSource.camera
      ? ImageSource.camera
      : ImageSource.gallery;
  final pickedMediaFuture = isVideo
      ? picker.pickVideo(source: source)
      : picker.pickImage(
          maxWidth: maxWidth, maxHeight: maxHeight, source: source);
  final pickedMedia = await pickedMediaFuture;
  final mediaBytes = await pickedMedia?.readAsBytes();
  if (mediaBytes == null) {
    return null;
  }
  final path = storagePath(currentUserUid, pickedMedia.name, isVideo);
  return SelectedMedia(path, mediaBytes);
}

bool validateFileFormat(String filePath, BuildContext context) {
  if (allowedFormats.contains(mime(filePath))) {
    return true;
  }
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text('Invalid file format: ${mime(filePath)}'),
    ));
  return false;
}

String storagePath(String uid, String filePath, bool isVideo) {
  final timestamp = DateTime.now().microsecondsSinceEpoch;
  // Workaround fixed by https://github.com/flutter/plugins/pull/3685
  // (not yet in stable).
  final ext = isVideo ? 'mp4' : filePath.split('.').last;
  return 'users/$uid/uploads/$timestamp.$ext';
}

void showUploadMessage(BuildContext context, String message,
    {bool showLoading = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (showLoading)
              Padding(
                padding: EdgeInsetsDirectional.only(end: 10.0),
                child: CircularProgressIndicator(),
              ),
            Text(message),
          ],
        ),
      ),
    );
}
