import '../code_room_dart.dart';
import 'post.dart';

class Comment extends ManagedObject<_Comment> implements _Comment{}
class _Comment{
  @primaryKey
  int id;
  String displayName;
  String contribution;
  @Column(indexed: true)
  DateTime contributionTime;

  @Relate(#contributions)
  Post post;
}