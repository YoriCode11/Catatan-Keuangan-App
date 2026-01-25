import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> testFirestoreWrite() async {
  await FirebaseFirestore.instance.collection("test").add({
    "created_at": DateTime.now().toString(),
    "source": "web-debug",
  });
}
