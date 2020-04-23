import 'package:coronavirus/network/models/complete_data.dart';
import 'package:coronavirus/viewmodels/base_model.dart';
import 'package:flutter/cupertino.dart';

class HomeModel extends BaseModel {

  CompleteData _completeData;

  CompleteData get completeData => _completeData;

  set completeData(CompleteData completeData) {
    _completeData = completeData;
    notifyListeners();
  }

  Country _country;

  Country get country => _country;

  set country(Country country) {
    _country = country;
    notifyListeners();
  }

  bool _showSearchItemList = false;

  bool get showSearchItemList => _showSearchItemList;

  set showSearchItemList(bool showSearchItemList) {
    _showSearchItemList = showSearchItemList;
    notifyListeners();
  }

  onSearchCountryTap(Country item) {
    country = item;
    showSearchItemList = false;
    wordController.text = country.country;
  }

  TextEditingController _wordController = TextEditingController();

  TextEditingController get wordController => _wordController;

  set wordController(TextEditingController wordController) {
    _wordController = wordController;
    notifyListeners();
  }
  List<Country> _searchList = List();

  List<Country> get searchList => _searchList;

  set searchList(List<Country> searchList) {
    _searchList = searchList;
    notifyListeners();
  }

  String _searchWord;

  String get searchWord => _searchWord;

  set searchWord(String searchWord) {
    _searchWord = searchWord;
    onWordChanged(searchWord);
    notifyListeners();
  }

  onWordChanged(String word) {
    showSearchItemList = true;
    List<Country> itemList = List();
    completeData.countries.map((item) {
      if (item.country.toLowerCase().startsWith(word))
        itemList.add(item);
      else
        print('not starts');
    }).toList();
    if ((searchList.length ?? 0) > 0) {
      searchList.clear();
      searchList.addAll(itemList);
    } else
      searchList.addAll(itemList);
  }

  Future<void> init(CompleteData data) async {
    completeData = data;
  }
}
