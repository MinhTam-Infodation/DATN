import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  // ignore: non_constant_identifier_names
  String? Address, Avatar, Name, Email, PackageType, Password, Phone;
  // ignore: non_constant_identifier_names
  bool? Status;
  // ignore: non_constant_identifier_names
  int? ActiveAt, CreateAt;
  String? Id;
  Users(
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
      this.Id,
      // ignore: non_constant_identifier_names
      this.CreateAt});

  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
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

  factory Users.fromJson(Map<String, dynamic> map) {
    return Users(
      Id: map['Id'],
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
  Users? user;
  DocumentReference? documentReference;

  UserSnapshot({
    required this.user,
    required this.documentReference,
  });

  factory UserSnapshot.fromSnapshot(DocumentSnapshot docSnapUser) {
    return UserSnapshot(
        user: Users.fromJson(docSnapUser.data() as Map<String, dynamic>),
        documentReference: docSnapUser.reference);
  }
  Future<void> capNhat(Users user) async {
    return documentReference!.update(user.toJson());
  }

  Future<void> xoa() async {
    return documentReference!.delete();
  }

  static Future<DocumentReference> themMoi(Users sv) async {
    return FirebaseFirestore.instance.collection("Users").add(sv.toJson());
  }

  static Future<void> themMoiAutoId(Users sv) async {
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('Users');
    DocumentReference newDocRef = usersRef.doc();
    sv.Id = newDocRef.id;
    await newDocRef.set(sv.toJson());
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

  // Check đc xem là đã được chuyển qua User hay chưa hay vẫn ở Wailting
  Future<Users> getUserData(String email) async {
    Users? user;
    var querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('Email', isEqualTo: email)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var documentSnapshot = querySnapshot.docs.first;
      user = Users.fromJson(documentSnapshot.data());
    }
    return user!;
  }

  static Future<List<UserSnapshot>> dsUserTuFirebaseOneTime() async {
    QuerySnapshot qs =
        await FirebaseFirestore.instance.collection("Users").get();
    return qs.docs
        .map((docSnap) => UserSnapshot.fromSnapshot(docSnap))
        .toList();
  }
}
