import ballerina/mongodb;
import ballerina/log;

import ../db/mongo;

public type User record {
    string _id?;
    string name;
    string email;
    int age;
    string status; // Added status field
};

// Business logic to fetch all users from MongoDB
public function getAllUsers() returns json[]|error {
    mongodb:Database db = check mongo:getDatabase("mydb");
    mongodb:Collection usersCollection = check db->getCollection("users");

    // Business logic: filter out inactive users (example of logic within model)
    json[] allUsers = check usersCollection->find();
    json[] activeUsers = [];
    foreach var user in allUsers {
        if user.status == "active" {
            activeUsers.push(user);
        }
    }
    return activeUsers;
}

// Business logic to create a new user
public function createUser(json userPayload) returns json|error {
    // Business validation: Ensure the user is over 18
    if userPayload.age < 18 {
        return error("User must be 18 or older.");
    }

    mongodb:Database db = check mongo:getDatabase("mydb");
    mongodb:Collection usersCollection = check db->getCollection("users");

    // Insert the user into the collection
    json result = check usersCollection->insertOne(userPayload);
    return result;
}


