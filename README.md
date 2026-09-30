# Habit Ledger (working name)

Habit tracking, money tracking and budgeting for Android, iOS and Windows, synced across devices, with a monthly premium subscription.

## Stack
Flutter · Drift (local SQLite, offline-first) · Riverpod · go_router · Supabase (planned: auth + sync) · RevenueCat (planned: subscriptions)

## Setup
```
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## Roadmap
1. ~~Scaffold, theme, navigation, sync-ready database schema~~
2. Habit tracking (offline)
3. Money tracking and budgets
4. Supabase auth + sync
5. RevenueCat paywall
6. Store release

Every synced table has `id` (UUID), `updatedAt`, `deleted` (soft delete) and `dirty` columns, so sync can be added without a schema rewrite. Money is stored as integer minor units (cents).

`index.html` is a leftover from before this became the app repo and can be deleted.
