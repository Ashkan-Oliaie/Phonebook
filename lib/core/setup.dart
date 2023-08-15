import 'package:get_it/get_it.dart';
import 'package:phonebook/services/contact_manager/contact_manager.dart';
import 'package:phonebook/services/api_service.dart';
import 'package:phonebook/UI/UI.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton(() => ApiService());
  getIt.registerLazySingleton(() => ContactManager(getIt<ApiService>()));

  getIt.registerFactory(() => ContactListViewModel(getIt<ContactManager>()));
  getIt.registerFactory(() => AddContactViewModel(getIt<ContactManager>()));
  getIt.registerFactory(() => ContactDetailViewModel());
}
