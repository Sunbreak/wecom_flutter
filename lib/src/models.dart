mixin WeComShareBaseModel {
  Map toMap();
}

class WeComShareWebPageModel implements WeComShareBaseModel {
  final String url;
  final String? title;

  WeComShareWebPageModel(
    this.url, {
    this.title,
  });

  @override
  Map toMap() {
    return {
      'url': url,
      'title': title,
    };
  }
}
