import '../../domain/entities/cat_breed_weight_entity.dart';

class WeightModel extends WeightEntity {
  WeightModel({
    required super.imperial,
    required super.metric,
  });

  factory WeightModel.fromJson(Map<String, dynamic> json) => WeightModel(
        imperial: json["imperial"],
        metric: json["metric"],
      );

  Map<String, dynamic> toJson() => {
        "imperial": imperial,
        "metric": metric,
      };
}
