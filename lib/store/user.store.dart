import 'package:mobx/mobx.dart';

import '../models/person.model.dart';

part 'user.store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  @readonly
  Person? _person;

  @action
  loadPerson(Person person) {
    _person = person;
  }
}
