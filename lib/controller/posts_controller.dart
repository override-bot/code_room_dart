import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:code_room_dart/model/post.dart';

// ignore: camel_case_types
class postsController extends ResourceController{
  postsController(this.context);
  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllPosts({@Bind.query('displayName') String displayName}) async {
    final postQuery = Query<Post>(context)
      ..join(set: (p) => p.contributions);
    if(displayName != null){
      postQuery.where((p) => p.displayName).contains(displayName, caseSensitive:false); 
         }
         final posts = await postQuery.fetch();
         return Response.ok(posts);
  }

  @Operation.get('id')
  Future<Response> getPostsById(@Bind.path('id') int id) async{
    final postQuery = Query<Post>(context)
      ..where((p) => p.id).equalTo(id);
      //..join((set: (p) => p.contributions);
  final post = await postQuery.fetchOne();
  if(post==null){
    return Response.notFound();
  }
  return Response.ok(post);
  }

@Operation.post()
Future<Response> createPost(@Bind.body() Post inputPost) async {
  final query = Query<Post>(context)
  ..values = inputPost;
  final insertedPost = await query.insert();
  return Response.ok(insertedPost);
}
}