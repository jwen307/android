import 'package:brewcrew/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:brewcrew/screens/home/brew_tile.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    
    final brews = Provider.of<List<Brew>>(context) ?? [];
    
    //For each document in the brews list
    brews.forEach((brew){

    });
    
    //Return a list of widgets for each document in the brewlist
    return ListView.builder(
      itemCount: brews.length,  //Get the number of brews
      itemBuilder: (context, index){
        return BrewTile(brew: brews[index]);  //Custom widget specified in brew_tile.dart
      }
      
    );
  }
}