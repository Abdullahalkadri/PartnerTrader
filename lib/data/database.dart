import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

/// Every synced table carries these columns so records can be merged across
/// devices: a client-generated UUID, a last-write-wins timestamp, and a soft
/// delete flag (rows are never physically removed until synced).
mixin SyncColumns on Table {
  TextColumn get id => text()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
  BoolColumn get dirty => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

class Habits extends Table with SyncColumns {
  TextColumn get name => text()();
  IntColumn get colorValue => integer()();
  // Target completions per week (1-7).
  IntColumn get targetPerWeek => integer().withDefault(const Constant(7))();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
}

class HabitCheckIns extends Table with SyncColumns {
  TextColumn get habitId => text().references(Habits, #id)();
  // Local calendar day, stored as 'yyyy-MM-dd' so it never shifts with time zones.
  TextColumn get day => text()();
}

class Accounts extends Table with SyncColumns {
  TextColumn get name => text()();
  TextColumn get currency => text().withDefault(const Constant('USD'))();
}

class Categories extends Table with SyncColumns {
  TextColumn get name => text()();
  IntColumn get colorValue => integer()();
  BoolColumn get isIncome => boolean().withDefault(const Constant(false))();
}

class Transactions extends Table with SyncColumns {
  TextColumn get accountId => text().references(Accounts, #id)();
  TextColumn get categoryId => text().nullable().references(Categories, #id)();
  // Minor units (cents) to avoid floating point errors. Negative = expense.
  IntColumn get amountMinor => integer()();
  TextColumn get note => text().withDefault(const Constant(''))();
  DateTimeColumn get occurredAt => dateTime()();
}

class Budgets extends Table with SyncColumns {
  TextColumn get categoryId => text().references(Categories, #id)();
  // Month as 'yyyy-MM'.
  TextColumn get month => text()();
  IntColumn get limitMinor => integer()();
}

@DriftDatabase(
    tables: [Habits, HabitCheckIns, Accounts, Categories, Transactions, Budgets])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'habit_ledger'));
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;
}
