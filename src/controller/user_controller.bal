import ballerina/http;
import ballerina/log;
import sportizza_backend.models.user as user; // Import the User model to handle business logic

// Define the User controller
service /users on new http:Listener(8081) {

    // Fetch all users
    resource function get .() returns json|error {
        json[] users = check user:getAllUsers();
        return users; // Directly return the users
    }

    // Create a new user
    resource function post .(http:Caller caller, http:Request req) returns error? {
        json payload = check req.getJsonPayload();
        // Use a try-catch block to handle potential errors
        json result = check user:createUser(payload);
        // Send a success response
        check caller->respond({ message: "User created successfully", user: result });
    }
}
