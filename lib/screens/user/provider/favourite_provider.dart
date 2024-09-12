import 'package:flutter/material.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/database/delete_funtions.dart';
import 'package:learncode/models/course.dart';
import 'package:provider/provider.dart';

class FavouriteProvider extends ChangeNotifier {
  void toggleFavourite(TutorialPlayList playlist) async {
    if (favoritePlaylistNotifier.value.contains(playlist)) {
      await deleteFavoriteCourse(playlist.playlistId);
    } else {
      await addFavoritePlaylist(playlist.playlistId);
    }
    await getAllFavorites();
    notifyListeners();
  }

  bool isExist(TutorialPlayList playlist) {
    final isExist = favoritePlaylistNotifier.value.contains(playlist);
    return isExist;
  }

  static FavouriteProvider of(context, {bool listen = true}) {
    return Provider.of<FavouriteProvider>(context, listen: listen);
  }
}
