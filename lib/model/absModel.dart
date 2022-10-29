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

  String get getQuantity {
    return imagePath;
  }

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(imagePath: json["image"].toString());
  }
}
