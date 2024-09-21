import ballerina/grpc;
import ballerina/time;

listener grpc:Listener ep = new (9090);

//table<Product> key(code) productTable = table [];
// Data structures to hold products, users, and orders

// Define the Cart type
type Cart record {
    Product[] products;
    float total_price;
};

map<Product> products = {};
map<Cart> carts = {};
map<OrderResponse> orders = {};
map<User> users = {};

@grpc:Descriptor {value: SHOPPING_DESC}
service "ShoppingService" on ep{
     // Admin: Add a product
    remote function AddProduct(Product product) returns ProductResponse {
        products[product.sku] = product;
        return {message: "Product added successfully", product: product};
    }

    // Admin: Update a product
    remote function UpdateProduct(UpdateProductRequest request) returns ProductResponse {
        if products.hasKey(request.sku) {
            products[request.sku] = request.updated_product;
            return {message: "Product updated successfully", product: request.updated_product};
        } else {
            return {message: "Product not found", product: {}};
        }
    }
// Admin: Remove a product
    remote function RemoveProduct(ProductID productID) returns ProductListResponse {
        if products.hasKey(productID.sku) {
            _ = products.remove(productID.sku);
        }
        return {products: products.toArray()};
    }

    // Admin: List orders
    remote function ListOrders(Empty empty) returns OrderListResponse {
        return {orders: orders.toArray()};
    }
// Customer: List available products
    remote function ListAvailableProducts(Empty empty) returns ProductListResponse {
        Product[] availableProducts = [];
        foreach var [_, product] in products.entries() {
            if product.status == true {
                availableProducts.push(product);
            }
        }
        return {products: availableProducts};
    }

    // Customer: Search product by SKU
    remote function SearchProduct(ProductID productID) returns ProductResponse {
        if products.hasKey(productID.sku) {
            return {message: "Product found", product: products[productID.sku] ?: {}};
        } else {
            return {message: "Product not found", product: {}};
        }
    }
  // Customer: Add to cart
    remote function AddToCart(AddToCartRequest request) returns CartResponse {
        // Retrieve the user's cart if it exists; otherwise, initialize a new one
        Cart? cartOpt = carts[request.user_id]; // This will return Cart? (nullable Cart)

        // Initialize the cart if it is null (user has no existing cart)
        Cart cart = cartOpt ?: {products: [], total_price: 0};

        // Fetch the product using SKU, which might be null
        Product? productOpt = products[request.sku];

        // Check if the product exists and if it is available and in stock
        if productOpt is Product && productOpt.status && productOpt.stock_quantity > 0 {
            // Add the product to the cart and update the total price
            cart.products.push(productOpt);
            cart.total_price += productOpt.price;

            // Update the cart for the user in the carts map
            carts[request.user_id] = cart;

            return {message: "Product added to cart"};
        } else if productOpt is Product {
            return {message: "Product out of stock"};
        } else {
            return {message: "Product not found"};
        }
    }
// Customer: Place an order

    remote function PlaceOrder(UserID userID) returns OrderResponse|error {
        // Retrieve the user's cart, which might be null
        Cart? cartOpt = carts[userID.id];

        // If the cart is null (user has no cart), return an error
        if cartOpt is Cart {
            // Get the current time
            time:Utc currentTime = time:utcNow();

            // Convert the current time to a string format (e.g., ISO 8601 format)
            string formattedTime = time:utcToString(currentTime);

            // Create the order response
            OrderResponse newOrder = {
                order_id: userID.id + "-" + formattedTime,
                products: cartOpt.products,
                total_price: cartOpt.total_price
            };

            // Save the order
            orders[newOrder.order_id] = newOrder;

            // Remove the cart after placing the order
            _ = carts.remove(userID.id);

            // Return the order
            return newOrder;
        } else {
            return error("Cart not found for user ID: " + userID.id);
        }
    }
}
