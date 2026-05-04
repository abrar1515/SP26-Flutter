import 'package:flutter/material.dart';

import '../models/item.dart';
import '../services/item_service.dart';
import 'item_form_screen.dart';

class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen({
    super.key,
    required this.service,
    required this.item,
  });

  final ItemService service;
  final Item item;

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  late Item _item;

  @override
  void initState() {
    super.initState();
    _item = widget.item;
  }

  Future<void> _editItem() async {
    final updatedItem = await Navigator.of(context).push<Item>(
      MaterialPageRoute(
        builder: (_) => ItemFormScreen(service: widget.service, item: _item),
      ),
    );

    if (updatedItem != null && mounted) {
      setState(() {
        _item = updatedItem;
      });
    }
  }

  Future<void> _deleteItem() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete item?'),
          content: Text('Are you sure you want to delete "${_item.title}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) {
      return;
    }

    await widget.service.deleteItem(_item.id);
    if (mounted) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: _editItem),
          IconButton(icon: const Icon(Icons.delete), onPressed: _deleteItem),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _item.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              _item.description?.isNotEmpty == true
                  ? _item.description!
                  : 'No description provided.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Text('ID: ${_item.id}'),
            if (_item.createdAt != null) Text('Created: ${_item.createdAt}'),
          ],
        ),
      ),
    );
  }
}
