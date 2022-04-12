class Message {
  bool fromMe;
  String body;

  Message(this.body, this.fromMe);
}

List<Message> messages = [
  Message("Hello Maria 😀", false),
  Message("I’ve been following your content for a while now and I must say they’ve been insightful.", false),
  Message("Hi Daniel Thanks", true),
  Message("Expect more", true),

];