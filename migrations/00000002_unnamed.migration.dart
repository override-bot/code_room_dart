import 'dart:async';
import 'package:aqueduct/aqueduct.dart';   

class Migration2 extends Migration { 
  @override
  Future upgrade() async {
   		database.addColumn("_Post", SchemaColumn("imageUrl", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false));
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {
     await database.store.execute(
      "INSERT INTO _POST (displayName, conversation) VALUES (zilla, i hate this)"
      

      );
  }
}
    