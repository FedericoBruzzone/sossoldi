import 'package:flutter_test/flutter_test.dart';

import 'package:sossoldi/model/bank_account.dart';
import 'package:sossoldi/model/base_entity.dart';

void main() {
  test('Test Copy BankAccount', () {
    BankAccount b = BankAccount(
        id: 2,
        name: "name",
        value: 100,
        createdAt: DateTime.utc(2022),
        updatedAt: DateTime.utc(2022));

    BankAccount bCopy = b.copy(id: 10);

    assert(bCopy.id == 10);
    assert(bCopy.name == b.name);
    assert(bCopy.value == bCopy.value);
    assert(bCopy.createdAt == b.createdAt);
    assert(bCopy.updatedAt == b.updatedAt);
  });

  test("Test fromJson BankAccount", () {
    Map<String, Object?> json = {
      BaseEntityFields.id: 0,
      BankAccountFields.name: "Home",
      BankAccountFields.value: 100,
      BaseEntityFields.createdAt: DateTime.utc(2022).toIso8601String(),
      BaseEntityFields.updatedAt: DateTime.utc(2022).toIso8601String(),
    };

    BankAccount b = BankAccount.fromJson(json);

    assert(b.id == json[BaseEntityFields.id]);
    assert(b.name == json[BankAccountFields.name]);
    assert(b.value == json[BankAccountFields.value]);
    assert(b.createdAt?.toUtc().toIso8601String() ==
        json[BaseEntityFields.createdAt]);
    assert(b.updatedAt?.toUtc().toIso8601String() ==
        json[BaseEntityFields.updatedAt]);
  });

  test("Test toJson BankAccount", () {
    BankAccount b = BankAccount(
        id: 2,
        name: "Home",
        value: 100,
        createdAt: DateTime.utc(2022),
        updatedAt: DateTime.utc(2022));

    Map<String, Object?> json = b.toJson();

    assert(b.id == json[BaseEntityFields.id]);
    assert(b.name == json[BankAccountFields.name]);
    assert(b.value == json[BankAccountFields.value]);
    assert(b.createdAt?.toUtc().toIso8601String() ==
        json[BaseEntityFields.createdAt]);
    assert(b.updatedAt?.toUtc().toIso8601String() ==
        json[BaseEntityFields.updatedAt]);
  });
}
