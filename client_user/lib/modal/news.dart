// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  bool? isRead;
  int? CreateAt;
  String? UserCreate, IdUserCreate, Title, Message, Id;

  News(
      {this.Id,
      this.isRead,
      this.CreateAt,
      this.UserCreate,
      this.IdUserCreate,
      this.Message,
      this.Title});

  // hàm tạo từ Json object
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        Id: json['Id'],
        isRead: json['isRead'],
        CreateAt: json['CreateAt'],
        UserCreate: json['UserCreate'],
        IdUserCreate: json['IdUserCreate'],
        Title: json['Title'],
        Message: json['Message']);
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'isRead': isRead,
      'CreateAt': CreateAt,
      'UserCreate': UserCreate,
      'IdUserCreate': IdUserCreate,
      'Title': Title,
      'Message': Message
    };
  }
}

class NewsSnapshot {
  News? orderDetail;
  DocumentReference? documentReference;

  NewsSnapshot({
    required this.orderDetail,
    required this.documentReference,
  });

  factory NewsSnapshot.fromSnapshot(DocumentSnapshot docSnapUser) {
    return NewsSnapshot(
        orderDetail: News.fromJson(docSnapUser.data() as Map<String, dynamic>),
        documentReference: docSnapUser.reference);
  }

  static Future<void> themMoiAutoId(News news) async {
    CollectionReference usersRef = FirebaseFirestore.instance
        .collection('Admin')
        .doc("admin")
        .collection("News");
    DocumentReference newDocRef = usersRef.doc();
    news.Id = newDocRef.id;
    await newDocRef.set(news.toJson());
  }

  static Stream<List<NewsSnapshot>> getListOrder(String idUser) {
    Stream<QuerySnapshot> qs = FirebaseFirestore.instance
        .collection("Admin")
        .doc("admin")
        .collection("News")
        .snapshots();
    // ignore: unnecessary_null_comparison
    if (qs == null) return const Stream.empty();
    Stream<List<DocumentSnapshot>> listDocSnap =
        qs.map((querySn) => querySn.docs);
    return listDocSnap.map((listDocSnap) => listDocSnap
        .map((docSnap) => NewsSnapshot.fromSnapshot(docSnap))
        .toList());
  }
}
