

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mt_assignment/di/injection.config.dart';

final serviceLocator = GetIt.instance;

@InjectableInit()
void configureDependencies(String? env) => serviceLocator.init(environment: env);