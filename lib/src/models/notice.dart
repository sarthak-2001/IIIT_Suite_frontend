class Notice {
  final String attention, date, id_link, posted_by, title, content, attachment;
  final int id;
  int db_id;
  Notice(
      {this.title,
      this.attachment,
      this.content,
      this.posted_by,
      this.id_link,
      this.attention,
      this.date,
      this.id});

  Map<String, dynamic> toMap() {
    return {
      'attention': attention,
      'date': date,
      'id_link': id_link,
      'posted_by': posted_by,
      'title': title,
      'content': content,
      'attachment': attachment,
      'id': id,
    };
  }

  static Notice fromMap(Map<String, dynamic> map) {
    return Notice(
        attention: map['attention'],
        date: map['date'],
        id_link: map['id_link'],
        posted_by: map['posted_by'],
        title: map['title'],
        content: map['content'],
        attachment: map['attachment'],
        id: map['id']);
  }
}
