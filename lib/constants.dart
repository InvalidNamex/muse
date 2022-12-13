import 'package:supabase_flutter/supabase_flutter.dart';

import 'controllers/home_controller.dart';
import 'controllers/result_controller.dart';

HomeController homeController = HomeController.instance;
ResultController resultController = ResultController.instance;
final supabase = Supabase.instance.client;
