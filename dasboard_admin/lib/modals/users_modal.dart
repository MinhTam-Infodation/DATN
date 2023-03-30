import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  // ignore: non_constant_identifier_names
  String? Address, Avatar, Name, Email, PackageType, Password, Phone;
  // ignore: non_constant_identifier_names
  bool? Status;
  // ignore: non_constant_identifier_names
  int? ActiveAt, CreateAt;
  User(
      // ignore: non_constant_identifier_names
      {this.Address,
      // ignore: non_constant_identifier_names
      this.Avatar,
      // ignore: non_constant_identifier_names
      this.Name,
      // ignore: non_constant_identifier_names
      this.Email,
      // ignore: non_constant_identifier_names
      this.PackageType,
      // ignore: non_constant_identifier_names
      this.Phone,
      // ignore: non_constant_identifier_names
      this.Password,
      // ignore: non_constant_identifier_names
      this.Status,
      // ignore: non_constant_identifier_names
      this.ActiveAt,
      // ignore: non_constant_identifier_names
      this.CreateAt});

  Map<String, dynamic> toJson() {
    return {
      'Address': Address,
      'Avatar': Avatar,
      'Name': Name,
      'Email': Email,
      'PackageType': PackageType,
      'Phone': Phone,
      'Password': Password,
      'Status': Status,
      'ActiveAt': ActiveAt,
      'CreateAt': CreateAt
    };
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      Address: map['Address'],
      Avatar: map['Avatar'],
      Name: map['Name'],
      Email: map['Email'],
      PackageType: map['PackageType'],
      Phone: map['Phone'],
      Password: map['Password'],
      Status: map['Status'],
      ActiveAt: map['ActiveAt'],
      CreateAt: map['CreateAt'],
    );
  }
}

class UserSnapshot {
  User? user;
  DocumentReference? documentReference;

  UserSnapshot({
    required this.user,
    required this.documentReference,
  });

  factory UserSnapshot.fromSnapshot(DocumentSnapshot docSnapUser) {
    return UserSnapshot(
        user: User.fromJson(docSnapUser.data() as Map<String, dynamic>),
        documentReference: docSnapUser.reference);
  }
  Future<void> capNhat(User user) async {
    return documentReference!.update(user.toJson());
  }

  Future<void> xoa() async {
    return documentReference!.delete();
  }

  static Future<DocumentReference> themMoi(User sv) async {
    return FirebaseFirestore.instance.collection("Users").add(sv.toJson());
  }

  static Stream<List<UserSnapshot>> dsUserTuFirebase() {
    Stream<QuerySnapshot> qs =
        FirebaseFirestore.instance.collection("Users").snapshots();
    // ignore: unnecessary_null_comparison
    if (qs == null) return const Stream.empty();
    Stream<List<DocumentSnapshot>> listDocSnap =
        qs.map((querySn) => querySn.docs);
    return listDocSnap.map((listDocSnap) => listDocSnap
        .map((docSnap) => UserSnapshot.fromSnapshot(docSnap))
        .toList());
  }

  static Future<List<UserSnapshot>> dsUserTuFirebaseOneTime() async {
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection("Users").get();
    return qs.docs
        .map((docSnap) => UserSnapshot.fromSnapshot(docSnap))
        .toList();
  }
}
