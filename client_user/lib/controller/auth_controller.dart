import 'package:client_user/modal/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final box = GetStorage();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /* Sign In */
  Future<void> register(Users user, String password) async {
    try {
      // Đăng ký tài khoản Firebase bằng email và password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: user.Email!,
        password: password,
      );

      await _firestore
          .collection("Wailting")
          .doc(userCredential.user!.uid)
          .set({
        "id": userCredential.user!.uid,
        'name': user.Name,
        'email': user.Email,
        'phone': user.Phone,
        'address': user.Address,
        'avatar': user.Avatar,
        'packageType': user.PackageType,
        'status': user.Status,
        'activeAt': user.ActiveAt,
        'createdAt': user.CreateAt,
      });

      // box.write('user', user.toJson());
      // final user = box.read('user');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Password is not strong enough', e.toString());
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Email already used for another account', e.toString());
      } else {
        Get.snackbar('Registration failed', e.toString());
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  /* User:
    void signUp(User user, String password) async {
      await signUpWithEmailPassword(user, password);
    }
  */

  /* Login */
  Future<void> login(String email, String password) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //* Lưu Storage Info User
      box.write('email', email);
      box.write('idCredential', userCredential.user!.uid);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  /* Sign In With Google */
  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Thực hiện đăng nhập vào Firebase với credential của Google
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Lấy thông tin user từ UserCredential và lưu vào collection
      final userc = userCredential.user;
      final newUser = Users(
        Id: userc!.uid,
        Name: userc.displayName,
        Email: userc.email,
        Avatar: userc.photoURL,
        Status: false,
        CreateAt: DateTime.now().millisecondsSinceEpoch,
      );
      await _firestore.collection('users').doc(userc.uid).set(newUser.toJson());
    } catch (e) {
      // Handle lỗi nếu có
      // ignore: avoid_print
      print(e);
    }
  }

  // Gửi email để reset password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // ignore: avoid_print
      print('Gửi email thành công');
    } catch (e) {
      // ignore: avoid_print
      print('Lỗi khi gửi email: $e');
      rethrow;
    }
  }

  // Xác nhận mã xác nhận và thiết lập mật khẩu mới
  Future<void> confirmPasswordReset(String code, String newPassword) async {
    try {
      await _auth.confirmPasswordReset(
        code: code,
        newPassword: newPassword,
      );
      // ignore: avoid_print
      print('Thiết lập mật khẩu mới thành công');
    } catch (e) {
      // ignore: avoid_print
      print('Lỗi khi thiết lập mật khẩu mới: $e');
      rethrow;
    }
  }

  /*
    User user = User(
      Name: 'Nguyen Van A',
      Email: 'nguyenvana@example.com',
      Password: 'password123',
    );

    await AuthController().sendPasswordResetEmail(user.Email);

    await AuthController()
    .confirmPasswordReset(code, newPassword);

  */

  /* Update InfoMation User */
  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    try {
      final userRef = _firestore.collection('Wailting').doc(userId);
      await userRef.update(data);
    } catch (e) {
      // ignore: avoid_print
      print('Error updating user: $e');
      rethrow;
    }
  }

  /*
    final data = {'status': 'active'};
    await updateUser(userId, data);
  */
}
