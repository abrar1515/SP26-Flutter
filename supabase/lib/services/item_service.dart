import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/item.dart';

class ItemService {
  ItemService(this._client);

  final SupabaseClient _client;

  Stream<List<Item>> watchItems() {
    return _client
        .from('items')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((rows) {
          return rows
              .map((row) => Item.fromJson(row))
              .toList();
        });
  }

  Future<List<Item>> fetchItems() async {
    final rows = await _client
        .from('items')
        .select()
        .order('created_at', ascending: false);

    return (rows as List)
        .map((row) => Item.fromJson(row))
        .toList();
  }

  Future<Item> createItem({required String title, String? description}) async {
    final row = await _client
        .from('items')
        .insert({'title': title, 'description': description})
        .select()
        .single();

    return Item.fromJson(row);
  }

  Future<Item> updateItem({
    required int id,
    required String title,
    String? description,
  }) async {
    final row = await _client
        .from('items')
        .update({'title': title, 'description': description})
        .eq('id', id)
        .select()
        .single();

    return Item.fromJson(row);
  }

  Future<void> deleteItem(int id) async {
    await _client.from('items').delete().eq('id', id);
  }
}
