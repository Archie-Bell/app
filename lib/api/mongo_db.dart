import 'package:flutter_dotenv/flutter_dotenv.dart';
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
      final dbURL = dotenv.env['MONGO_URL'] ?? 'default_url';
      database = await Db.create(dbURL);
      await database!.open();
      final collectionName = dotenv.env['COLLECTION_NAME'] ?? 'default_collection_name';
      missingPersonsCollection = database!.collection(collectionName);
      print('Connection to MongoDB established');
    } catch (e) {
      print('Unable to establish connection with MongoDB: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    try {
      final arrayData = await missingPersonsCollection!.find().toList();
      return arrayData;
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }
}