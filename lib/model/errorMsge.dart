import 'dart:convert';

class ErrorMessage{
  dynamic statusCode;
  String error;
  List<Messages> messages;
  List<Messages> data;

ErrorMessage({
  this.statusCode,
  this.error,
  this.messages,
  this.data
});

factory ErrorMessage.fromJson(Map<String, dynamic> json) => ErrorMessage(
statusCode: json["statusCode"],
error: json["error"],
messages: json["messages"] == null ? null: List<Messages>.from(json["messages"].map((x) => Messages.fromJson(x))),
data: json["data"] == null ? null: List<Messages>.from(json["data"].map((x) => Messages.fromJson(x))),

    );

}

class Messages{
  List<Message> messages;

  Messages({
    this.messages
  });

factory Messages.fromJson(Map<String, dynamic> json) => Messages(
messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x)))
);

}

class Message{
  String id;
  String message;

  Message({
    this.id,
    this.message
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
  id: json["id"],
  message: json["message"], );
}
