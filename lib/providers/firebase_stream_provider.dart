import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseStreamProvider = StreamProvider.autoDispose.family<QuerySnapshot<Map<String, dynamic>>, String>(
    (_, area) => FirebaseFirestore.instance.collection(area).snapshots());
