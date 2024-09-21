7import ballerina/http;
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

    // Retrieve a list of all programme within the Programme Development Unit.
    resource function get getAllProgrammes() returns table<Programme> key(programmeCode) {

        return programmes;
    }

    resource function get getProgrammeByCode(string code) returns Programme|string {
        // A flag to check if the programme with the code exists
        boolean isCodeFound = false;
        foreach Programme prg in programmes {
            if (string:equalsIgnoreCaseAscii(prg.programmeCode, code)) {
                isCodeFound = true;
                return prg;

            }
        }

        if (isCodeFound) {
            return "The programme " + code + " has been found.";
        } else {
            return "Programme not found for code: " + code;
        }
    }
//Prgrammes due for review
    resource function get dueReview() returns table<Programme> key(programmeCode)|string {
        int currentYear = 2024;
        table<Programme> key(programmeCode) dueForReviewTable = table []; //  empty table for storing due programmes

        foreach Programme prg in programmes {
            // Check if the programme is 5 years or older
            if ((currentYear - prg.registrationYear) >= 5) {
                // Add the programme to the dueForReviewTable if it's due for review
                dueForReviewTable.add(prg);
            }
        }

        if (dueForReviewTable.length() > 0) {
            // Return only the programmes that are due for review
            return dueForReviewTable;
        }

        // If no programmes are due, return a message
        else {
            return "No courses are due for review!";
        }
    }
            

}
