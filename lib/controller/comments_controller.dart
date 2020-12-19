import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:code_room_dart/model/comment.dart';

// ignore: camel_case_types
class commentController extends ResourceController {
  commentController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllComments({@Bind.query('displayName') String displayName}) async {
    final commentQuery = Query<Comment>(context);
     if(displayName != null){
      commentQuery.where((c) => c.displayName).contains(displayName, caseSensitive:false); 
         }
         final contributions = await commentQuery.fetch();
         return Response.ok(contributions);
     
  }
  @Operation.get('id')
  Future<Response> getPostsById(@Bind.path('id') int id) async{
    final commentQuery = Query<Comment>(context)
      ..where((p) => p.id).equalTo(id);
      //..join((set: (p) => p.contributions);
  final comment = await commentQuery.fetchOne();
  if(comment==null){
    return Response.notFound();
  }
  return Response.ok(comment);
  }

  @Operation.post()
Future<Response> createPost(@Bind.body() Comment inputComment) async {
  final query = Query<Comment>(context)
  ..values = inputComment;
  final insertedComment = await query.insert();
  return Response.ok(insertedComment);
}
}