import ballerina/http;
import ./controller/user_controller;

// Initialize the API listener and attach controllers (routes)
public function initRoutes() {
    // Attach user controller routes
    _ = new user_controller;
}
