import ballerina/http;
import ballerina/io;
import ballerina/lang.'string;

listener http:Listener httpListener = new (8080);

// Define a record to represent a course
type Course readonly & record {
    string courseName;
    string courseCode;
    string nqfLevel;
};

// Define a record to represent a programme
type Programme readonly & record {
    string programmeCode;
    string nqfLevel;
    string faculty;
    string department;
    string title;
    string[] courses_taken;
    int registrationYear;
};

table<Programme> key(programmeCode) programmes = table [];
service /programmedev on httpListener {

    // Add a new programme
    resource function post addProgramme(Programme prog) returns string {
        io:println(prog);
        error? err = programmes.add(prog);
        if (err is error) {
            return string `Error, ${err.message()}`;
        }
        return string `${prog.programmeCode} saved successfully`;
    }
     }