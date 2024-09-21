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
}