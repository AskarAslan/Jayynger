class Posts {
  final int id;
  final String author;
  final String image;
  final String publication_date;
  final String title;
  final String text;

  Posts({this.id, this.author, this.image, this.publication_date, this.title, this.text});

  factory Posts.formJson(Map <String, dynamic> json){
    return new Posts(
      id: json["id"],
      author: json["author"],
      image: json["image"],
      publication_date: json["publication_date"],
      title: json["title"],
      text: json["text"],
    );
  }
}