
import 'package:flutter/material.dart';
import 'package:learncode/database/database_funtions.dart';
import 'package:learncode/models/course.dart';
import 'package:provider/provider.dart';

class FavouriteProvider extends ChangeNotifier {
  final List<TutorialPlayList> _favoutitePlaylist = [];
  List<TutorialPlayList> get favouritePlaylist => _favoutitePlaylist;

  void toggleFavourite(TutorialPlayList playlist){
   if (_favoutitePlaylist.contains(playlist)) {
     _favoutitePlaylist.remove(playlist);
   }else{
    _favoutitePlaylist.add(playlist);
    addFavorite(playlist.playlistId);
   }
   notifyListeners();
  }

  bool isExist(TutorialPlayList playlist){
    final isExist = _favoutitePlaylist.contains(playlist);
    return isExist;
  }

 static FavouriteProvider of(context, {bool listen = true}){
  return Provider.of<FavouriteProvider>(context,listen: listen);
 }

}

