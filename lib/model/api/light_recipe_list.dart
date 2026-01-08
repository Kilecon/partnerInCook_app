import 'package:partner_in_cook/model/api/light_user.dart';
import 'package:partner_in_cook/model/api/tag.dart';

class LightRecipe {
  final String id;
  final String name;
  final int? globalTime;
  final bool isFavorite;
  final String? pictureUrl;
  final LightUser author;
  final int notationsCount;
  final double averageNotation;
  final List<Tag>? tags;

  LightRecipe({
    required this.id,
    required this.name,
    this.globalTime,
    required this.isFavorite,
    this.pictureUrl,
    required this.author,
    required this.notationsCount,
    required this.averageNotation,
    this.tags,
  });

  factory LightRecipe.fromJson(Map<String, dynamic> json) {
    return LightRecipe(
      id: json['id'] as String,
      name: json['name'] as String,
      globalTime: json['global_time'] as int?,
      isFavorite: json['is_favorite'] as bool? ?? false,
      pictureUrl: json['pic_url'] as String?,
      author: LightUser.fromJson(json['author']),
      notationsCount: json['notation_count'] as int,
      averageNotation: (json['average_notation'] as num).toDouble(),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((tagJson) => Tag.fromJson(tagJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'global_time': globalTime,
      'is_favorite': isFavorite,
      'pic_url': pictureUrl,
      'author': author.toJson(),
      'notation_count': notationsCount,
      'average_notation': averageNotation,
      'tags': tags?.map((tag) => tag.toJson()).toList(),
    };
  }
}
