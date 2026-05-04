class Item {
  const Item({
    required this.id,
    required this.title,
    this.description,
    this.createdAt,
  });

  final int id;
  final String title;
  final String? description;
  final DateTime? createdAt;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      description: json['description'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.tryParse(json['created_at'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description};
  }

  Item copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? createdAt,
  }) {
    return Item(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
