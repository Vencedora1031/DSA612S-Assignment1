import ballerina/io;

// Declare a client for communicating with the gRPC service.
// 'ShoppingServiceClient' is generated from the gRPC service definition.
// 'check' ensures that any potential errors are handled.
ShoppingServiceClient cli = check new ("http://localhost:9090");

public function main() returns error? {
    // Infinite loop to keep displaying the menu options
    while true {
        // Display a list of options for the user to choose from
        io:println("_______________________________________");
        io:println("1.   Add a new product.");
        io:println("2.   List all available products.");
        io:println("3.   Search for a product by SKU.");
        io:println("4.   Update an existing product.");
        io:println("5.   Add a product to the cart.");
        io:println("6.   Remove a product.");
        io:println("7.   Create multiple users.");
        io:println("8.   Place an order.");
        io:println("9.   List all orders.");
        io:println("0.   Exit");

        // Read the user's selection from the terminal
        string selection = io:readln("Choose an option (0-9): ");
        io:println("_______________________________________");

        // 'match' block to handle the user's selection based on the entered option
        match selection {
            "1" => {
                // Create an empty 'Product' record to store product information
                Product prd = {};

                // Prompt the user for product details
                prd.sku = io:readln("Enter SKU of the product to be added: ");
                prd.name = io:readln("Enter the name of the product: ");
                prd.description = io:readln("Enter description of the product " + prd.name + ": ");

                // Read the product price and convert it to a float
                string priceInput = io:readln("Enter the price of the product: ");
                prd.price = checkpanic float:fromString(priceInput);

                // Read the stock quantity and convert it to an integer
                string stockInput = io:readln("Enter the stock quantity of the product: ");
                prd.stock_quantity = checkpanic int:fromString(stockInput);

                // Read the product status (available/unavailable) and set the boolean value accordingly
                string statusInput = io:readln("Enter the status of the product (available/unavailable): ");
                if statusInput.toLowerAscii() == "available" {
                    prd.status = true;
                } else if statusInput.toLowerAscii() == "unavailable" {
                    prd.status = false;
                } else {
                    io:println("Invalid input. Setting default status as unavailable.");
                    prd.status = false; // default to unavailable if input is invalid
                }

                // Call the 'AddProduct' method on the gRPC client and pass the product data
                ProductResponse response = check cli->AddProduct(prd);
                io:println(response.message); // Print the response message from the server
            }

            // Option 4: Update an existing product
            "4" => {
                // Create an empty 'UpdateProductRequest' and populate it with updated details
                UpdateProductRequest request = {};
                io:println("_______________________________________");

                // Get the SKU of the product to update
                request.sku = io:readln("Enter SKU of the product to be updated: ");

                // Populate a new 'Product' object with updated information
                Product updatedProduct = {};
                updatedProduct.sku = request.sku;
                updatedProduct.name = io:readln("Enter the new name of the product: ");
                updatedProduct.description = io:readln("Enter new description of the product " + updatedProduct.name + ": ");

                // Convert and assign new price and stock values
                string priceInput = io:readln("Enter the new price of the product: ");
                updatedProduct.price = checkpanic float:fromString(priceInput);
                string stockInput = io:readln("Enter the new stock quantity of the product: ");
                updatedProduct.stock_quantity = checkpanic int:fromString(stockInput);

                // Get the updated status and set the corresponding boolean value
                string statusInput = io:readln("Enter the new status of the product (available/unavailable): ");
                if statusInput.toLowerAscii() == "available" {
                    updatedProduct.status = true;
                } else if statusInput.toLowerAscii() == "unavailable" {
                    updatedProduct.status = false;
                } else {
                    io:println("Invalid input. Setting default status as unavailable.");
                    updatedProduct.status = false; // default to unavailable if input is invalid
                }
                // Assign the updated product data to the request and send it
                request.updated_product = updatedProduct;
                ProductResponse response = check cli->UpdateProduct(request);
                io:println(response.message);
                io:println("_______________________________________");
            }
            // Option 6: Remove a product by its SKU
            "6" => {
                // Create a 'ProductID' record to identify the product to remove
                ProductID productID = {};
                productID.sku = io:readln("Enter SKU of the product to be removed: ");

                // Call the 'RemoveProduct' method on the client and pass the product ID
                ProductListResponse response = check cli->RemoveProduct(productID);
                io:println("_______________________________________");

                // Display the remaining products after removal
                io:println("Remaining products:");
                foreach Product product in response.products {
                    io:println("SKU: ", product.sku);
                    io:println("Name: ", product.name);
                    io:println("Description: ", product.description);
                    io:println("Price: ", product.price);
                    io:println("Stock Quantity: ", product.stock_quantity);
                    io:println("Status: ", product.status);
                    io:println("_______________________________________");
                }
            }
            // Option 2: List all available products
            "2" => {
                // Call the 'ListAvailableProducts' method to retrieve available products
                ProductListResponse response = check cli->ListAvailableProducts({});

                // Display the details of each available product
                io:println("_______________________________________");
                io:println("Available products:");
                foreach Product product in response.products {
                    io:println("SKU: ", product.sku);
                    io:println("Name: ", product.name);
                    io:println("Description: ", product.description);
                    io:println("Price: ", product.price);
                    io:println("Stock Quantity: ", product.stock_quantity);
                    io:println("Status: ", product.status);
                    io:println("_______________________________________");
                }
            }
            // Option 3: Search for a product by SKU
            "3" => {
                ProductID productID = {};
                io:println("_______________________________________");
                productID.sku = io:readln("Enter SKU to search for the product: ");
                ProductResponse response = check cli->SearchProduct(productID);
                io:println(response.message);
                if (response.product.sku is string) {
                    io:println("SKU: ", response.product.sku);
                    io:println("Name: ", response.product.name);
                    io:println("Description: ", response.product.description);
                    io:println("Price: ", response.product.price);
                    io:println("Stock Quantity: ", response.product.stock_quantity);
                    io:println("Status: ", response.product.status);
                    io:println("_______________________________________");
                }
            }
            // Option 5: Add a product to the user's cart
            "5" => {
                AddToCartRequest request = {};
                request.user_id = io:readln("Enter User ID: ");
                request.sku = io:readln("Enter SKU of the product to add to cart: ");
                CartResponse response = check cli->AddToCart(request);
                io:println(response.message);
            }
            // Option 8: Place an order for a user
            "8" => {

                // Get the user ID and place the order
                UserID userID = {};
                io:println("_______________________________________");
                // Display order details such as ID, total price, and products
                userID.id = io:readln("Enter User ID to place the order: ");
                OrderResponse response = check cli->PlaceOrder(userID);
                io:println("Order ID: ", response.order_id);
                io:println("Total Price: ", response.total_price);
                io:println("Products:");
                foreach Product product in response.products {
                    io:println("SKU: ", product.sku);
                    io:println("Name: ", product.name);
                    io:println("Description: ", product.description);
                    io:println("Price: ", product.price);
                    io:println("Stock Quantity: ", product.stock_quantity);
                    io:println("Status: ", product.status);
                    io:println("_______________________________________");
                }
            }
            // Option 9: List all orders placed
            "9" => {
                // Call 'ListOrders' to retrieve all orders
                OrderListResponse response = check cli->ListOrders({});
                io:println("_______________________________________");
                // Display each order's details
                io:println("Orders:");
                foreach OrderResponse newOrder in response.orders {
                    io:println("Order ID: ", newOrder.order_id);
                    io:println("Total Price: ", newOrder.total_price);
                    io:println("Products:");
                    foreach Product product in newOrder.products {
                        io:println("SKU: ", product.sku);
                        io:println("Name: ", product.name);
                        io:println("Description: ", product.description);
                        io:println("Price: ", product.price);
                        io:println("Stock Quantity: ", product.stock_quantity);
                        io:println("Status: ", product.status);
                    }
                    io:println("_______________________________________");
                }
            }
            "7" => {
                io:println("_______________________________________");
                io:println("Enter user details (one per line):");
                string id = io:readln("User ID: ");
                string name = io:readln("User Name: ");
                string role = io:readln("User Role: "); // Assuming role is also required

                User user = {id: id, name: name, role: role}; // Create User object with all required fields

                // Initialize the streaming client
                CreateUsersStreamingClient createUsersStreamingClient = check cli->CreateUsers();

                // Send the User object
                check createUsersStreamingClient->sendUser(user);

                // Complete the streaming request
                check createUsersStreamingClient->complete();

                // Receive the response
                CreateUsersResponse? createUsersResponse = check createUsersStreamingClient->receiveCreateUsersResponse();

                // Print the response message
                io:println(createUsersResponse);
                io:println("_______________________________________");
            }
            "0" => {
                io:println("Exiting the program.");
                return; // Exit the main function
            }
            _ => {
                io:println("Invalid option. Please choose a number between 0 and 9.");
            }
        }
    }

}
