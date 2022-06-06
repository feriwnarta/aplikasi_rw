class StatusUserModel {
  final String urlProfile,
      userName,
      uploadTime,
      urlStatusImage,
      caption,
      numberOfLikes,
      id_status,
      numberOfComments;

  StatusUserModel(
      {this.userName,
      this.uploadTime,
      this.urlProfile,
      this.urlStatusImage,
      this.caption,
      this.id_status,
      this.numberOfLikes,
      this.numberOfComments});
}
