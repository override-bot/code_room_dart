import '../code_room_dart.dart';
import 'comment.dart';

class Post extends ManagedObject<_Post> implements _Post{}

class _Post{
  @primaryKey
  int id;
  String displayName;
  String imageUrl;
  String conversation;
  @Column(indexed: true)
  DateTime postDate;

  ManagedSet<Comment> contributions;
  

}