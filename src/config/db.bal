import ballerina/os;
import ballerina/config;
import ballerinax/mongodb;

public function initDatabase() returns mongodb:Database|error {
    // Load environment variables and MongoDB URI
    string mongoUri = os:getEnv("MONGODB_URI", config:getAsString("database.uri"));
    string dbName = os:getEnv("MONGODB_DB", config:getAsString("database.db"));

    mongodb:ClientConfig mongoConfig = {
        uri: mongoUri
    };

    mongodb:Client mongoClient = check new (mongoConfig);
    mongodb:Database db = check mongoClient->getDatabase(dbName);
    return db;
}
