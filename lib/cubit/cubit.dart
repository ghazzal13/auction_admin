import 'dart:io';

import 'package:auction_admin/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import 'user.dart' as model2;

class AuctionCubit extends Cubit<AuctionStates> {
  AuctionCubit() : super(AuctionInitialState());

  static AuctionCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;
  void onItemTapped(int index) {
    selectedIndex = index;
  }

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(AuctionProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AuctionProfileImagePickedErrorState());
    }
  }

  File? postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(AuctionPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(AuctionPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(AuctionRemovePostImageState());
  }

  void deletDoc(String colection, String postId) {
    FirebaseFirestore.instance.collection(colection).doc(postId).delete();
  }

  void acceptPost({
    required String? postId,
    required String? colection,
  }) {
    FirebaseFirestore.instance.collection(colection!).doc(postId).set({
      'isaccept': true,
      'isWaiting': false,
    }, SetOptions(merge: true));
  }

  void cancelPost({
    required String? postId,
    required String? colection,
  }) {
    FirebaseFirestore.instance.collection(colection!).doc(postId).set({
      'isWaiting': false,
    }, SetOptions(merge: true));
  }

  Future cancelReport({
    required String? postId,
    required String? colection,
  }) async {
    FirebaseFirestore.instance.collection(colection!).doc(postId).set({
      'cancelReport': true,
    }, SetOptions(merge: true));
  }

  model2.UserModel usermodel = model2.UserModel();
  Future<model2.UserModel> getUserProfile(id) async {
    emit(AuctionGetUserLoadingState());
    String? uid;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .get()
        .then((value) {
      print(value.data());

      usermodel = model2.UserModel.fromMap(value.data());

      emit(AuctionGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AuctionGetUserErrorState(error.toString()));
    });
    return usermodel;
  }
//
}

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 20.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}
