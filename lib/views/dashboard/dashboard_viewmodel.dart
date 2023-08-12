import 'package:stacked/stacked.dart';

class DashboardViewModel extends ReactiveViewModel {

  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }


  void setup () {

  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [];

}