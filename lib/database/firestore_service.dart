import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/design.dart';

class FirestoreService {
  static final FirestoreService instance = FirestoreService._init();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  FirestoreService._init();

  // Stream of designs from Cloud Firestore
  Stream<List<Design>> get designsStream {
    return _db.collection('designs').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Design(
          id: data['id'] as int? ?? 0,
          title: (data['title'] as String?) ?? '',
          text: (data['text'] as String?) ?? '',
          bottomText: data['bottomText'] as String?,
          backgroundColorValue: (data['backgroundColorValue'] as int?) ?? 0xFF673AB7,
          textColorValue: (data['textColorValue'] as int?) ?? 0xFFFFFFFF,
          fontSize: (data['fontSize'] as num?)?.toDouble() ?? 28.0,
        );
      }).toList();
    });
  }

  Future<void> insertDesign(Design design) async {
    final int uniqueId = DateTime.now().millisecondsSinceEpoch;
    await _db.collection('designs').doc(uniqueId.toString()).set({
      'id': uniqueId,
      'title': design.title,
      'text': design.text,
      'bottomText': design.bottomText,
      'backgroundColorValue': design.backgroundColorValue,
      'textColorValue': design.textColorValue,
      'fontSize': design.fontSize,
    });
  }

  Future<List<Design>> getDesigns() async {
    final snapshot = await _db.collection('designs').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Design(
        id: data['id'] as int? ?? 0,
        title: (data['title'] as String?) ?? '',
        text: (data['text'] as String?) ?? '',
        bottomText: data['bottomText'] as String?,
        backgroundColorValue: (data['backgroundColorValue'] as int?) ?? 0xFF673AB7,
        textColorValue: (data['textColorValue'] as int?) ?? 0xFFFFFFFF,
        fontSize: (data['fontSize'] as num?)?.toDouble() ?? 28.0,
      );
    }).toList();
  }

  Future<void> deleteDesign(int id) async {
    final query = await _db.collection('designs').where('id', isEqualTo: id).get();
    for (var doc in query.docs) {
      await doc.reference.delete();
    }
  }
}
