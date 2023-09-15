class ImageModel {
  final String imagePath;
  ImageModel({
    required this.imagePath,
  });
  Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePath,
    };
  }

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(imagePath: json["image"].toString());
  }
}

class ActionModel {
  final String actionName;
  final String actionType;
  final String title;
  final Map mapping;
  final String apilink;
  final String viewType;
  ActionModel(
      {required this.actionName,
      required this.actionType,
      required this.title,
      required this.apilink,
      required this.viewType,
      required this.mapping});

  Map<String, dynamic> toMap() {
    return {
      'actionType': actionType,
      'actionName': actionName,
      'title': title,
      'mapping': mapping,
      'apilink': apilink,
      'viewType': viewType
    };
  }

  factory ActionModel.fromJson(Map<String, dynamic> json) {
    return ActionModel(
      actionName: json["action"].toString(),
      actionType: json["actionType"].toString(),
      title: json["title"].toString(),
      mapping: json.containsKey("mapping") ? json["mapping"] : {},
      apilink: json.containsKey("apilink") ? json["apilink"] : "",
      viewType: json.containsKey("viewType") ? json["viewType"] : "",
    );
  }
}

class BlogModel {
  final String apilink;
  final String title;
  final Map mappingobject;
  BlogModel({
    required this.apilink,
    required this.title,
    required this.mappingobject,
  });

  Map<String, dynamic> toMap() {
    return {'apilink': apilink, 'title': title};
  }

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      apilink: json["apilink"].toString(),
      title: json["title"].toString(),
      mappingobject: json["mappingobject"],
    );
  }
}
