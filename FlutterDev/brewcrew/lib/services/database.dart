import 'package:brewcrew/models/brew.dart';
import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/screens/home/brew_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});    //Constructor to add the uid

  // Collection reference (This will create a collection if it does not exist yet)
  final CollectionReference brewCollection = Firestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async{
    String test = 'asfsd';
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
      'random': test,
    });
  }


// Brew List from snapshot. Takes the info from the stream and converts it to our own custom brewlist model
List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.documents.map((doc){
    return Brew(
      name: doc.data['name'] ?? '',
      strength: doc.data['strength'] ?? 0,
      sugars:doc.data['sugars'] ?? '0'
      );
  }).toList();
}

// Get Brew stream (returns a List of brews)
Stream<List<Brew>> get brews{
  return brewCollection.snapshots().map(_brewListFromSnapshot);
}


// User Data from snapshot
UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
  return UserData(
    uid: uid,
    name: snapshot.data['name'],
    sugars: snapshot.data['sugars'],
    strength: snapshot.data['strength'],
  );
}


//Get User doc stream
Stream<UserData> get userData{
  return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
}


}