import ballerina/http;
import ballerina/io;

 public type Programme record {
    string programmeCode?;
    string nqfLevel?;
    string faculty?;
    string department?;
    string title?;
    string []courses_taken?;
    int registrationYear?;
};

public type Course record{
    string courseName?;
    string courseCode?;
    string nqfLevel?;
};
public function main() returns  error?{
    http:Client cli = check new ("localhost:8080/programmedev");

     io:println("1.   Add a new programme. ");
    io:println("2.   Retrieve a list of all programme within the Programme Development Unit. ");
    io:println("3.   Update an existing programme's information according to the programme code.");
    io:println("4.  Retrieve the details of a specific programme by their programme code.");
    io:println("5.   Delete a programme's record by their programme code");
    io:println("6.  Retrieve all the programmes that belong to the same faculty.");
    io:println("7.   Retrieve all the programme that are due for review.");
    string selection = io:readln("Choose an option from(1-7): ");
    
}