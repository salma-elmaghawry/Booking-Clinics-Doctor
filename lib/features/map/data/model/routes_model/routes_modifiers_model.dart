class RoutesModifiersModel {
  bool? avoidTolls;
  bool? avoidHighways;
  bool? avoidFerries;

  RoutesModifiersModel({
    this.avoidTolls = false,
    this.avoidFerries = false,
    this.avoidHighways = false,
  });

  // factory RoutesModifiersModel.fromJson(Map<String, dynamic> json) {
  //   return RoutesModifiersModel(
  //     avoidTolls: json['avoidTolls'] as bool?,
  //     avoidHighways: json['avoidHighways'] as bool?,
  //     avoidFerries: json['avoidFerries'] as bool?,
  //   );
  // }

  Map<String, dynamic> toJson() => {
        'avoidTolls': avoidTolls,
        'avoidHighways': avoidHighways,
        'avoidFerries': avoidFerries,
      };
}
