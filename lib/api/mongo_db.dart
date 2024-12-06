

import 'package:app/api/constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDB {
  // static connect() async {
  //   // Initates a new connection to the database
  //   var database = await Db.create(MONGO_URL);
  //   await database.open();

  //   // Display database configuration
  //   inspect(database);

  //   var status = database.serverStatus();
  //   print(status);

  //   // Declare collection name
  //   var collection = database.collection(COLLECTION_NAME);

  //   print(await collection.find().toList());
  // }

  static Db? database;
  static DbCollection? missingPersonsCollection;

  static Future<void> connect() async {
    try {
      database = await Db.create(MONGO_URL);
      await database!.open();
      missingPersonsCollection = database!.collection(COLLECTION_NAME);
      print('Connection to MongoDB established');
    } catch (e) {
      print('Unable to establish connection with MongoDB: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrayData = await missingPersonsCollection!.find().toList();

    // print('Data in collection: ${arrayData.toString()}');
    return arrayData;
  }
}