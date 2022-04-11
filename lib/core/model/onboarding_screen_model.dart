class OnboardingScreenModel {
  String? subtitle;
  String? image;
  String? title;

  OnboardingScreenModel({ this.image,  this.title,  this.subtitle});

  void setSubtitle(String getSubtitle) {
    subtitle = getSubtitle;
  }

  void setImage(String getImage) {
    image = getImage;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  String getSubtitle() {
    return subtitle!;
  }

  String getImage() {
    return image!;
  }

  String getTitle() {
    return title!;
  }
}