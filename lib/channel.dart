import 'package:code_room_dart/controller/posts_controller.dart';
import 'package:code_room_dart/controller/comments_controller.dart';
import 'code_room_dart.dart';

class CodeRoomDartChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    final config = coderoomConfig(options.configurationFilePath);
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final store = PostgreSQLPersistentStore.fromConnectionInfo(
      config.database.username,
      config.database.password,
      config.database.host,
      config.database.port,
      config.database.databaseName
    );
     context =  ManagedContext(dataModel, store);
  }
  @override
  Controller get entryPoint {
    final router = Router();
    router
      .route("/posts/[:id]")
      .link(() => postsController(context));

     router
      .route("/comments/[:id]")
      .link(() => commentController(context));

    return router;
  }
}
// ignore: camel_case_types
class coderoomConfig extends Configuration{
  coderoomConfig(String path): super.fromFile(
    File(path)
  );
  DatabaseConfiguration database;
}