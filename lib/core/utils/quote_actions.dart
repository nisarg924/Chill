// lib/utils/quote_actions.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

/// A helper class providing download, share, and favorite toggle methods for quotes.
class QuoteActions {
  /// Toggles the favorite state using [isFavorite] ValueNotifier.
  static void toggleFavorite(ValueNotifier<bool> isFavorite) {
    isFavorite.value = !isFavorite.value;
    Fluttertoast.showToast(
      msg: isFavorite.value ? 'Added to favorites' : 'Removed from favorites',
    );
  }

  /// Shares the given [quote] via the system share sheet.
  static Future<void> shareQuote(String quote) async {
    await Share.share(
      quote,
      subject: 'Quote of the day',
    );
  }

  /// Downloads the given [quote] as a .txt file into the Downloads folder.
  static Future<void> downloadQuote(String quote) async {
    try {
      // Request necessary permissions
      // final status = await Permission.manageExternalStorage.request();
      // if (!status.isGranted) {
      //   Fluttertoast.showToast(msg: 'Storage permission denied');
      //   return;
      // }

      // Get Download directory
      final downloadsDir = Directory('/storage/emulated/0/Download');
      final filePath = p.join(downloadsDir.path, 'quote_${DateTime.now().millisecondsSinceEpoch}.txt');
      final file = File(filePath);
      await file.writeAsString(quote);
      Fluttertoast.showToast(msg: 'Quote saved to $filePath');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to save file: \$e');
    }
  }
}