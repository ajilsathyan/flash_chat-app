import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataServices {
  final fireStore = FirebaseFirestore.instance;
  User user = FirebaseAuth.instance.currentUser;

  // Add User Messages to the Cloud FireStore
  Future<void> addUserData({messages}) async {
    fireStore.collection('message').add({
      'sender': user.email,
      'message': messages,
    });
  }

  // // Read Data From Cloud FireStore
  // Future<DocumentSnapshot> getUserData({id}) async {
  //   var result = await fireStore.collection('message').doc(id).get();
  //   return result;
  // }
  //
  // // Automatically Reads every user Data immediately
  // Future<void> messageStream() async {
  //   await for (var snapShots in fireStore.collection('message').snapshots()) {
  //     for (var messages in snapShots.docs) {
  //       print(messages.data());
  //     }
  //   }
  // }
}
