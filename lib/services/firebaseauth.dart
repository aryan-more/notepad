// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:notes/services/firestore.dart';

// class FireBaseService {
//   static final FirebaseAuth _auth = FirebaseAuth.instance;

//   static FireBaseFirestore? _userModelFromFirebase(User? newUser) {
//     return newUser != null ? FireBaseFirestore(uid: newUser.uid) : null;
//   }

//   static Future<void> create({required String uid}) async {
//     if (!(await FirebaseFirestore.instance.collection("/notes").doc(uid).get()).exists) {
//       await FirebaseFirestore.instance.collection("/notes").doc(uid).set(
//         {
//           "notes": [],
//         },
//       );
//     }
//   }

//   static Future<void> signInAnonymuosly() async {
//     try {
//       UserCredential credential = await _auth.signInAnonymously();
//       if (credential.user != null) {
//         await create(uid: credential.user!.uid);
//       }
//     } catch (_) {}
//   }

//   static Future<void> signOut() => _auth.signOut();

//   static Future<void> signInOrSignUpWithEmail({
//     required String email,
//     required String password,
//     required bool signIn,
//   }) async {
//     try {
//       String uid;
//       if (FirebaseAuth.instance.currentUser != null) {
//         uid = (await FirebaseAuth.instance.currentUser!.linkWithCredential(EmailAuthProvider.credential(email: email, password: password))).user!.uid;
//       } else if (signIn) {
//         uid = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user!.uid;
//       } else {
//         uid = (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user!.uid;
//       }
//       create(uid: uid);
//     } catch (_) {
//       rethrow;
//     }
//   }

//   static Stream<FireBaseFirestore?> get onAuthStateChanged {
//     return _auth.authStateChanges().map(_userModelFromFirebase);
//   }
// }
