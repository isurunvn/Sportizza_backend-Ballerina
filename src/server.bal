import ballerina/log;
import ./routes/user_routes.bal;

public function main() {
    // Initialize routes and start the server
    routes:initRoutes();
    log:printInfo("Server is running on port 8080");
}
