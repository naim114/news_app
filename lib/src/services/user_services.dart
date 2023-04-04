import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country/country.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_base/src/model/user_model.dart';
import 'package:flutter_base/src/services/role_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('User');

  Future<List<Future<UserModel?>>> getAll() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List of Role Model
    final allData = querySnapshot.docs
        .map((doc) => UserServices().fromQueryDocumentSnapshot(doc))
        .toList();

    return allData;
  }

  Future<UserModel?> get(String id) async {
    return _collectionRef.doc(id).get().then((DocumentSnapshot doc) async {
      if (doc.exists) {
        return UserServices().fromDocumentSnapshot(doc);
      } else {
        print('Document does not exist on the database');
        return null;
      }
    });
  }

  Future<List<UserModel?>> getBy(String fieldName, String value) async {
    List<UserModel?> dataList = List.empty(growable: true);

    QuerySnapshot querySnapshot = await _collectionRef.get();

    final List<QueryDocumentSnapshot<Object?>> allDoc =
        querySnapshot.docs.toList();

    for (var doc in allDoc) {
      if (doc.get(fieldName) == value) {
        UserModel? user = await UserServices().fromDocumentSnapshot(doc);

        if (user != null) {
          dataList.add(user);
        }
      }
    }

    return dataList;
  }

  //create an userModel object based on Firebase User object
  Future<UserModel?> getUserModelFromFirebase(User? user) async {
    if (user != null) {
      String email = user.email.toString();

      final users = await UserServices().getBy('email', email);

      return users.first;
    } else {
      return null;
    }
  }

  Future<UserModel?> fromDocumentSnapshot(DocumentSnapshot<Object?> doc) async {
    return UserModel(
      id: doc.get('id'),
      email: doc.get('email'),
      name: doc.get('name'),
      birthday: doc.get('birthday') == null
          ? doc.get('birthday')
          : doc.get('birthday').toDate(),
      phone: doc.get('phone'),
      address: doc.get('address'),
      country: Countries.values
          .firstWhere((country) => country.number == doc.get('country')),
      avatarPath: doc.get('avatarPath'),
      role: await RoleServices().get(doc.get('role')),
      createdAt: doc.get('createdAt').toDate(),
      updatedAt: doc.get('updatedAt').toDate(),
      deletedAt: doc.get('deletedAt') == null
          ? doc.get('deletedAt')
          : doc.get('deletedAt').toDate(),
      password: doc.get('password'),
    );
  }

  Future<UserModel?> fromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Object?> doc) async {
    return UserModel(
      id: doc.get('id'),
      email: doc.get('email'),
      name: doc.get('name'),
      birthday: doc.get('birthday') == null
          ? doc.get('birthday')
          : doc.get('birthday').toDate(),
      phone: doc.get('phone'),
      address: doc.get('address'),
      country: Countries.values
          .firstWhere((country) => country.number == doc.get('country')),
      avatarPath: doc.get('avatarPath'),
      role: await RoleServices().get(doc.get('role')),
      createdAt: doc.get('createdAt').toDate(),
      updatedAt: doc.get('updatedAt').toDate(),
      deletedAt: doc.get('deletedAt') == null
          ? doc.get('deletedAt')
          : doc.get('deletedAt').toDate(),
      password: doc.get('password'),
    );
  }

  Future updateUserDetails({
    required String id,
    required String? name,
    required DateTime? birthday,
    required String? phone,
    required String? address,
    required String countryNumber,
  }) async {
    try {
      dynamic result = _collectionRef
          .doc(id)
          .update({
            'name': name,
            'birthday': birthday,
            'phone': phone,
            'address': address,
            'country': countryNumber,
            'updatedAt': DateTime.now(),
          })
          .then((value) => print("User Updated"))
          .catchError((error) => print('Failed: $error'));

      print(result.toString());

      return true;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());

      return false;
    }
  }
}
