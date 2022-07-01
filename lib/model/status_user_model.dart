class StatusUserModel {
  final String urlProfile,
      userName,
      uploadTime,
      urlStatusImage,
      caption,
      numberOfLikes,
      idStatus,
      numberOfComments;

  StatusUserModel(
      {this.userName,
      this.uploadTime,
      this.urlProfile,
      this.urlStatusImage,
      this.caption,
      this.idStatus,
      this.numberOfLikes,
      this.numberOfComments});
}
