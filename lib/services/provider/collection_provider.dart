import 'package:flutter/material.dart';
import 'package:home_app/models/collections.dart';


class CollectionProvider with ChangeNotifier {
  String _error;
  bool _isLoading =true;
  Collection _collection;
  Future<List<Collection>> _collections;
  // UnmodifiableListView<Collection> get allCollection => UnmodifiableListView(_collections);
  ///get one collection
  Collection get collection => _collection;
  Future<List<Collection>> get collections => _collections;

  bool get loading => _isLoading;
  String get error => _error;

  setError(String error) {
    this._error = error;
    notifyListeners();
  }

  setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  ///set one collection and notifi listeners
  setCollection(Collection collection) {
    print("set collection " + "${collection.name}");
    this._collection = collection;
    notifyListeners();
  }

  ///get collections

  ///set collections and notifi listeners
  setCollections(Future<List<Collection>> collections) {
    this._collections = collections;
    notifyListeners();
  }

    fetchCollections(Future<List<Collection>> collections){
    this._collections = collections ;
    notifyListeners();
  }

}
