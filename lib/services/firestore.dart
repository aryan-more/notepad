import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:notes/models/note.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static FireBaseFirestore? _firebaseFirestore(User? newUser) {
    return newUser != null ? FireBaseFirestore(uid: newUser.uid) : null;
  }

  static Future<void> create({required String uid}) async {
    if (!(await FirebaseFirestore.instance.collection("/notes").doc(uid).get()).exists) {
      await FirebaseFirestore.instance.collection("/notes").doc(uid).set(
        {
          "notes": [],
        },
      );
    }
  }

  static Future<void> signInAnonymuosly() async {
    UserCredential credential = await _auth.signInAnonymously();
    if (credential.user != null) {
      await create(uid: credential.user!.uid);
    }
  }

  static Future<void> signOut() => _auth.signOut();

  static Future<void> signInOrSignUpWithEmail({
    required String email,
    required String password,
    required bool signIn,
  }) async {
    try {
      String uid;
      if (FirebaseAuth.instance.currentUser != null) {
        uid = (await FirebaseAuth.instance.currentUser!.linkWithCredential(EmailAuthProvider.credential(email: email, password: password))).user!.uid;
      } else if (signIn) {
        uid = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user!.uid;
      } else {
        uid = (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user!.uid;
      }
      create(uid: uid);
    } catch (_) {
      rethrow;
    }
  }

  static Stream<FireBaseFirestore?> get onAuthStateChanged {
    return _auth.authStateChanges().map(_firebaseFirestore);
  }
}

class FireBaseFirestore {
  final String uid;
  Stream<DocumentSnapshot<Map<String, dynamic>>> _snapshot;
  FireBaseFirestore({
    required this.uid,
  }) : _snapshot = FirebaseFirestore.instance.collection("/notes").doc(uid).snapshots();

  Stream<List<Note>?> get notes => _snapshot.map((event) {
        if (!event.exists) {
          FireBaseService.create(uid: uid);
          return null;
        }

        return (event["notes"] as Iterable).map((e) => Note.fromMap(e)).toList();
      });

  void add({required Note note}) {
    FirebaseFirestore.instance.collection("/notes").doc(uid).update({
      "notes": FieldValue.arrayUnion([note.toMap()])
    });
  }

  void addMultiple({required List<Note> notes}) {
    FirebaseFirestore.instance.collection("/notes").doc(uid).update({"notes": FieldValue.arrayUnion(notes.map((e) => e.toMap()).toList())});
  }

  void deletes({required List<Note> notesToDelete}) {
    FirebaseFirestore.instance.collection("/notes").doc(uid).update({
      "notes": FieldValue.arrayRemove(
        [
          ...(notesToDelete.map((e) => e.toMap()).toList()),
        ],
      )
    });
  }

  void update({required BuildContext context, required Note note, required String title, required String content}) async {
    add(note: note.applyUpdateCopy(title: title, content: content));
    deletes(notesToDelete: [note]);
  }

  // void add({required Note note}) async {
  //   await FirebaseFirestore.instance.collection("/notes").doc(uid).update({
  //     "notes": FieldValue.arrayUnion([note.toMap()])
  //   });
  // }
}
