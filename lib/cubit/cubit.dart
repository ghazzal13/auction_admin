import 'dart:io';

import 'package:auction_admin/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
//
}
