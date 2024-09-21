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
    match selection {
         
        "1" => {
            Programme prg = {};
            prg.programmeCode = io:readln("Enter code of the programme to be added: ");
            prg.title= io:readln("Enter the title of Programme "+<string>prg.programmeCode+" : ");
            prg.nqfLevel = io:readln("Enter the NQF Level of Programme "+<string>prg.programmeCode+" : ");
            prg.faculty=io:readln("Enter the faculty "+<string>prg.programmeCode+" belongs to: ");
            prg.department=io:readln("Enter the department the programme "+<string>prg.programmeCode+" belongs to:");
            string input=io:readln("Enter year the programme was registered: ");
            prg.registrationYear = checkpanic int:fromString(input);
            string[] courseNames = addCourses();
            prg.courses_taken = courseNames;
            check addProgramme(cli, prg);
        }
        "3" => {
            Programme prg = {};
            prg.programmeCode = io:readln("Enter code of the programme to be updated: ");
            prg.title= io:readln("Enter the new title of Programme "+<string>prg.programmeCode+" : ");
            prg.nqfLevel = io:readln("Enter the new NQF Level of Programme "+<string>prg.programmeCode+" : ");
            prg.faculty=io:readln("Enter the new faculty "+<string>prg.programmeCode+" belongs to: ");
            prg.department=io:readln("Enter the department the programme "+<string>prg.programmeCode+" belongs to:");
            string input=io:readln("Enter year the programme was registered: ");
            prg.registrationYear = checkpanic int:fromString(input);
            string[] courseNames = addCourses();
            prg.courses_taken = courseNames;
            check updateProgramme(cli, prg);
        }
        "5" => {
            string prgCode = io:readln("Enter Programme Code for record to be deleted: ");
            check deleteProgramme(cli, prgCode);
        }
        "2" => {
            check getAllProgrammes(cli);
        }
        "6" => {
            string faculty = io:readln("Enter Faculty to view programmes: ");
            check getByFaculty(cli, faculty);
        }
        "4" => {
            string prgCode = io:readln("Enter Programme Code to view record: ");
            check getByCode(cli, prgCode);
        }
        "7" => {
            check due(cli);
        }
        _ => {
            io:println("Invalid Key");
            check main();
        }
    }
}
public function addCourses() returns string[] {
    string[] courses = [];
    boolean addMoreCourses = true;
    
    while addMoreCourses {
        string courseName = io:readln("Enter Courses Under Programme: ");
        courses.push(courseName);
        
        string userInput = io:readln("Do you want to add another course? (yes/no): ");
        if userInput.toLowerAscii() != "yes" {
            addMoreCourses = false;
        }
    }
    
    return courses;
}
public function addProgramme(http:Client http, Programme prg) returns error? {
    if (http is http:Client) {
        string resp = check http->/addProgramme.post(prg);
        io:println(resp);
        string exitSys = io:readln("Press 0 to go back");

        if (exitSys === "0") {
            error? rerun = main();
            if rerun is error {
                io:println("Error, You can't go back to options page.");
            }
        }
    }
}
public function updateProgramme(http:Client http, Programme updt) returns error? {
    
     if (http is http:Client) {
        string resp = check http->/updateProgramme.put(updt);
        io:println(resp);
        string exitSys = io:readln("Press 0 to go back");

        if (exitSys === "0") {
            error? rerun = main();
            if rerun is error {
                io:println("Error, You can't go back to options page.");
            }
        }
    }
    io:println(updt);
}
public function deleteProgramme(http:Client http, string prgCode) returns error? {
    if (http is http:Client) {
        string message = check http->/deleteProgramme.delete(programmeCode=prgCode);
        io:println(message);
        io:println("--------------------------");
        string exitSys = io:readln("Press 0 to go back");
        if (exitSys == "0") {
            error? rerun = main();
            if rerun is error {
                io:println("Error, You can't go back.");
            }
        }
    }
}
