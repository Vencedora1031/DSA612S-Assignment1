import ballerina/grpc;
import ballerina/protobuf;

public const string SHOPPING_DESC = "0A0E73686F7070696E672E70726F746F22A6010A0750726F6475637412120A046E616D6518012001280952046E616D6512200A0B6465736372697074696F6E180220012809520B6465736372697074696F6E12140A0570726963651803200128015205707269636512250A0E73746F636B5F7175616E74697479180420012805520D73746F636B5175616E7469747912100A03736B751805200128095203736B7512160A067374617475731806200128085206737461747573225B0A1455706461746550726F647563745265717565737412100A03736B751801200128095203736B7512310A0F757064617465645F70726F6475637418022001280B32082E50726F64756374520E7570646174656450726F64756374224F0A0F50726F64756374526573706F6E736512180A076D65737361676518012001280952076D65737361676512220A0770726F6475637418022001280B32082E50726F64756374520770726F64756374221D0A0950726F64756374494412100A03736B751801200128095203736B75223B0A1350726F647563744C697374526573706F6E736512240A0870726F647563747318012003280B32082E50726F64756374520870726F6475637473223D0A10416464546F436172745265717565737412170A07757365725F6964180120012809520675736572496412100A03736B751802200128095203736B7522280A0C43617274526573706F6E736512180A076D65737361676518012001280952076D65737361676522710A0D4F72646572526573706F6E736512190A086F726465725F696418012001280952076F72646572496412240A0870726F647563747318022003280B32082E50726F64756374520870726F6475637473121F0A0B746F74616C5F7072696365180320012801520A746F74616C5072696365223B0A114F726465724C697374526573706F6E736512260A066F726465727318012003280B320E2E4F72646572526573706F6E736552066F7264657273223E0A0455736572120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D6512120A04726F6C651803200128095204726F6C6522180A06557365724944120E0A02696418012001280952026964222F0A134372656174655573657273526573706F6E736512180A076D65737361676518012001280952076D65737361676522070A05456D70747932BC030A0F53686F7070696E675365727669636512280A0A41646450726F6475637412082E50726F647563741A102E50726F64756374526573706F6E736512380A0D55706461746550726F6475637412152E55706461746550726F64756374526571756573741A102E50726F64756374526573706F6E736512310A0D52656D6F766550726F64756374120A2E50726F6475637449441A142E50726F647563744C697374526573706F6E736512280A0A4C6973744F726465727312062E456D7074791A122E4F726465724C697374526573706F6E736512350A154C697374417661696C61626C6550726F647563747312062E456D7074791A142E50726F647563744C697374526573706F6E7365122D0A0D53656172636850726F64756374120A2E50726F6475637449441A102E50726F64756374526573706F6E7365122D0A09416464546F4361727412112E416464546F43617274526571756573741A0D2E43617274526573706F6E736512250A0A506C6163654F7264657212072E5573657249441A0E2E4F72646572526573706F6E7365122C0A0B437265617465557365727312052E557365721A142E4372656174655573657273526573706F6E73652801620670726F746F33";

public isolated client class ShoppingServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, SHOPPING_DESC);
    }

    isolated remote function AddProduct(Product|ContextProduct req) returns ProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/AddProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductResponse>result;
    }

    isolated remote function AddProductContext(Product|ContextProduct req) returns ContextProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        Product message;
        if req is ContextProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/AddProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductResponse>result, headers: respHeaders};
    }

    isolated remote function UpdateProduct(UpdateProductRequest|ContextUpdateProductRequest req) returns ProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        UpdateProductRequest message;
        if req is ContextUpdateProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/UpdateProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductResponse>result;
    }

    isolated remote function UpdateProductContext(UpdateProductRequest|ContextUpdateProductRequest req) returns ContextProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        UpdateProductRequest message;
        if req is ContextUpdateProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/UpdateProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductResponse>result, headers: respHeaders};
    }

    isolated remote function RemoveProduct(ProductID|ContextProductID req) returns ProductListResponse|grpc:Error {
        map<string|string[]> headers = {};
        ProductID message;
        if req is ContextProductID {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/RemoveProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductListResponse>result;
    }

    isolated remote function RemoveProductContext(ProductID|ContextProductID req) returns ContextProductListResponse|grpc:Error {
        map<string|string[]> headers = {};
        ProductID message;
        if req is ContextProductID {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/RemoveProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductListResponse>result, headers: respHeaders};
    }

    isolated remote function ListOrders(Empty|ContextEmpty req) returns OrderListResponse|grpc:Error {
        map<string|string[]> headers = {};
        Empty message;
        if req is ContextEmpty {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/ListOrders", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <OrderListResponse>result;
    }

    isolated remote function ListOrdersContext(Empty|ContextEmpty req) returns ContextOrderListResponse|grpc:Error {
        map<string|string[]> headers = {};
        Empty message;
        if req is ContextEmpty {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/ListOrders", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <OrderListResponse>result, headers: respHeaders};
    }

    isolated remote function ListAvailableProducts(Empty|ContextEmpty req) returns ProductListResponse|grpc:Error {
        map<string|string[]> headers = {};
        Empty message;
        if req is ContextEmpty {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/ListAvailableProducts", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductListResponse>result;
    }

    isolated remote function ListAvailableProductsContext(Empty|ContextEmpty req) returns ContextProductListResponse|grpc:Error {
        map<string|string[]> headers = {};
        Empty message;
        if req is ContextEmpty {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/ListAvailableProducts", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductListResponse>result, headers: respHeaders};
    }

    isolated remote function SearchProduct(ProductID|ContextProductID req) returns ProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        ProductID message;
        if req is ContextProductID {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/SearchProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductResponse>result;
    }

    isolated remote function SearchProductContext(ProductID|ContextProductID req) returns ContextProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        ProductID message;
        if req is ContextProductID {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/SearchProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductResponse>result, headers: respHeaders};
    }

    isolated remote function AddToCart(AddToCartRequest|ContextAddToCartRequest req) returns CartResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddToCartRequest message;
        if req is ContextAddToCartRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/AddToCart", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CartResponse>result;
    }

    isolated remote function AddToCartContext(AddToCartRequest|ContextAddToCartRequest req) returns ContextCartResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddToCartRequest message;
        if req is ContextAddToCartRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/AddToCart", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CartResponse>result, headers: respHeaders};
    }

    isolated remote function PlaceOrder(UserID|ContextUserID req) returns OrderResponse|grpc:Error {
        map<string|string[]> headers = {};
        UserID message;
        if req is ContextUserID {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/PlaceOrder", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <OrderResponse>result;
    }

    isolated remote function PlaceOrderContext(UserID|ContextUserID req) returns ContextOrderResponse|grpc:Error {
        map<string|string[]> headers = {};
        UserID message;
        if req is ContextUserID {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/PlaceOrder", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <OrderResponse>result, headers: respHeaders};
    }

    isolated remote function CreateUsers() returns CreateUsersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("ShoppingService/CreateUsers");
        return new CreateUsersStreamingClient(sClient);
    }
}

public isolated client class CreateUsersStreamingClient {
    private final grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendUser(User message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextUser(ContextUser message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveCreateUsersResponse() returns CreateUsersResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <CreateUsersResponse>payload;
        }
    }

    isolated remote function receiveContextCreateUsersResponse() returns ContextCreateUsersResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <CreateUsersResponse>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public type ContextUserStream record {|
    stream<User, error?> content;
    map<string|string[]> headers;
|};

public type ContextUser record {|
    User content;
    map<string|string[]> headers;
|};

public type ContextOrderListResponse record {|
    OrderListResponse content;
    map<string|string[]> headers;
|};

public type ContextProduct record {|
    Product content;
    map<string|string[]> headers;
|};

public type ContextProductID record {|
    ProductID content;
    map<string|string[]> headers;
|};

public type ContextOrderResponse record {|
    OrderResponse content;
    map<string|string[]> headers;
|};

public type ContextUpdateProductRequest record {|
    UpdateProductRequest content;
    map<string|string[]> headers;
|};

public type ContextAddToCartRequest record {|
    AddToCartRequest content;
    map<string|string[]> headers;
|};

public type ContextCartResponse record {|
    CartResponse content;
    map<string|string[]> headers;
|};

public type ContextProductListResponse record {|
    ProductListResponse content;
    map<string|string[]> headers;
|};

public type ContextEmpty record {|
    Empty content;
    map<string|string[]> headers;
|};

public type ContextUserID record {|
    UserID content;
    map<string|string[]> headers;
|};

public type ContextProductResponse record {|
    ProductResponse content;
    map<string|string[]> headers;
|};

public type ContextCreateUsersResponse record {|
    CreateUsersResponse content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type User record {|
    string id = "";
    string name = "";
    string role = "";
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type OrderListResponse record {|
    OrderResponse[] orders = [];
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type Product record {|
    string name = "";
    string description = "";
    float price = 0.0;
    int stock_quantity = 0;
    string sku = "";
    boolean status = false;
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type ProductID record {|
    string sku = "";
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type OrderResponse record {|
    string order_id = "";
    Product[] products = [];
    float total_price = 0.0;
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type UpdateProductRequest record {|
    string sku = "";
    Product updated_product = {};
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type AddToCartRequest record {|
    string user_id = "";
    string sku = "";
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type CartResponse record {|
    string message = "";
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type ProductListResponse record {|
    Product[] products = [];
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type Empty record {|
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type UserID record {|
    string id = "";
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type ProductResponse record {|
    string message = "";
    Product product = {};
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type CreateUsersResponse record {|
    string message = "";
|};

