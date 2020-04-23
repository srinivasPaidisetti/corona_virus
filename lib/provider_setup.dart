import 'package:coronavirus/viewmodels/appmodel/app_model.dart';
import 'package:coronavirus/viewmodels/home/home_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildWidget> independentServices = [];

List<SingleChildWidget> dependentServices = [];

List<SingleChildWidget> uiConsumableProviders = [
  ChangeNotifierProvider<AppModel>(
    create: (context) => AppModel(),
  ),
  ChangeNotifierProvider<HomeModel>(
    create: (context) => HomeModel(),
  )
];
