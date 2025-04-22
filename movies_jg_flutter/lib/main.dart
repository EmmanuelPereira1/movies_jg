import 'core/core.dart';
import 'my_material_app.dart';

Future <void> main() async {
  AppGetIt().setupProviders();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyMaterialApp());
}