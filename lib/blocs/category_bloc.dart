import 'dart:async';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc extends BlocBase {

  final _titleControlller = BehaviorSubject<String>();
  final _imageControlller = BehaviorSubject();
  final _deleteControlller = BehaviorSubject<bool>();

  Stream<String> get outTitle => _titleControlller.stream.transform(
    StreamTransformer<String, String>.fromHandlers(
      handleData: (title, sink) {
        if (title.isEmpty) {
          sink.addError('Insira um título!');
        } else {
          sink.add(title);
        }
      }
    )
  );
  Stream get outImage => _imageControlller.stream;
  Stream<bool> get outDelete => _deleteControlller.stream;

  Stream<bool> get submitValid => Observable.combineLatest2(
    outTitle, outImage, (a, b) => true
  );

  DocumentSnapshot category;
  File image;
  String title;

  CategoryBloc(this.category) {
    if (category != null) {
      title = category.data['title'];
      _titleControlller.add(category.data['title']);
      _imageControlller.add(category.data['icon']);
      _deleteControlller.add(true);
    } else {
      _deleteControlller.add(false);
    }
  }

  void setImage(File file) {
    image = file;
    _imageControlller.add(file);
  }

  void setTitle(String title) {
    this.title = title;
    _titleControlller.add(title);
  }

  void delete() {
    category.reference.delete();
  }

  Future saveData() async {
    if (image == null && category != null && title == category.data['title']) {
      return;
    }
    
    Map<String, dynamic> dataToUpdate = {};
    
    if (image != null) {
      StorageUploadTask task = FirebaseStorage.instance.ref().child('icons')
        .child(title).putFile(image);
      StorageTaskSnapshot snap = await task.onComplete;
      dataToUpdate['icon'] = await snap.ref.getDownloadURL();
    }
    
    if (category == null || title != category.data['title']) {
      dataToUpdate['title'] = title;
    }

    if (category == null) {
      await Firestore.instance.collection('products').document(title.toLowerCase())
        .setData(dataToUpdate);
    } else {
      await category.reference.updateData(dataToUpdate);
    }
  }

  @override
  void dispose() {
    _titleControlller.close();
    _imageControlller.close();
    _deleteControlller.close();
  }

}