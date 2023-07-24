class Video {
  int?  id;
  String name;
  String description;
  int type;
  String ageRestriction;
  int durationMinutes;
  String thumbnailImageId;
  String releaseDate;
  int idUser;

  Video(this.name, this.description, this.type, this.ageRestriction,
      this.durationMinutes, this.thumbnailImageId, this.releaseDate, this.idUser);

  Video.withId(this.id, this.name, this.description, this.type, this.ageRestriction,
      this.durationMinutes, this.thumbnailImageId, this.releaseDate, this.idUser);


}