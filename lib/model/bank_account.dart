import '../database/sossoldi_database.dart';
import 'base_entity.dart';

const String bankAccountTable = 'bankAccount';

class BankAccountFields extends BaseEntityFields {
  static String id = BaseEntityFields.getId;
  static String name = 'name';
  static String value = 'value';
  static String mainAccount = 'mainAccount';
  static String createdAt = BaseEntityFields.getCreatedAt;
  static String updatedAt = BaseEntityFields.getUpdatedAt;

  static final List<String> allFields = [
    BaseEntityFields.id,
    name,
    value,
    mainAccount,
    BaseEntityFields.createdAt,
    BaseEntityFields.updatedAt
  ];
}

class BankAccount extends BaseEntity {
  final String name;
  final num value;
  final bool mainAccount;

  const BankAccount(
      {int? id,
      required this.name,
      required this.value,
      required this.mainAccount,
      DateTime? createdAt,
      DateTime? updatedAt})
      : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  BankAccount copy(
          {int? id,
          String? name,
          num? value,
          bool? mainAccount,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      BankAccount(
          id: id ?? this.id,
          name: name ?? this.name,
          value: value ?? this.value,
          mainAccount: mainAccount ?? this.mainAccount,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt);

  static BankAccount fromJson(Map<String, Object?> json) => BankAccount(
      id: json[BaseEntityFields.id] as int?,
      name: json[BankAccountFields.name] as String,
      value: json[BankAccountFields.value] as num,
      mainAccount: json[BankAccountFields.mainAccount] == 1 ? true : false,
      createdAt: DateTime.parse(json[BaseEntityFields.createdAt] as String),
      updatedAt: DateTime.parse(json[BaseEntityFields.updatedAt] as String));

  Map<String, Object?> toJson() => {
        BaseEntityFields.id: id,
        BankAccountFields.name: name,
        BankAccountFields.value: value,
        BankAccountFields.mainAccount: mainAccount,
        BaseEntityFields.createdAt: createdAt?.toIso8601String(),
        BaseEntityFields.updatedAt: updatedAt?.toIso8601String(),
      };
}

class BankAccountMethods extends SossoldiDatabase {
  Future<BankAccount> insert(BankAccount item) async {
    final database = await SossoldiDatabase.instance.database;
    final id = await database.insert(bankAccountTable, item.toJson());
    return item.copy(id: id);
  }


  Future<BankAccount> selectById(int id) async {
    final database = await SossoldiDatabase.instance.database;

    final maps = await database.query(
      bankAccountTable,
      columns: BankAccountFields.allFields,
      where: '${BankAccountFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return BankAccount.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<BankAccount>> selectAll() async {
    final database = await SossoldiDatabase.instance.database;

    final orderByASC = '${BankAccountFields.createdAt} ASC';

    final result = await database.query(bankAccountTable, orderBy: orderByASC);

    return result.map((json) => BankAccount.fromJson(json)).toList();
  }

  Future<int> updateItem(BankAccount item) async {
    final database = await SossoldiDatabase.instance.database;

    // You can use `rawUpdate` to write the query in SQL
    return database.update(
      bankAccountTable,
      item.toJson(),
      where:
      '${BankAccountFields.id} = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> deleteById(int id) async {
    final database = await SossoldiDatabase.instance.database;

    return await database.delete(bankAccountTable,
        where:
        '${BankAccountFields.id} = ?',
        whereArgs: [id]);
  }

}