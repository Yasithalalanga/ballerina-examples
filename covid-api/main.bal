import ballerina/http;

service /covid/status on new http:Listener(9000) {
    resource function get countries() returns CovidEntry[] {
        return covidTable.toArray();
    }

    resource function post countries(@http:Payload CovidEntry[] covidEntries) returns CovidEntry[] | ConflictingIsoCodesError {

        // Check whether a record is available for the iso_code
        string[] conflictingISOs = from CovidEntry covidEntry in covidEntries
            where covidTable.hasKey(covidEntry.iso_code)
            select covidEntry.iso_code;

        if conflictingISOs.length() > 0 {
            return {
                body: {
                    errmsg: string:'join(" ", "Conflicting ISO Codes:", ...conflictingISOs)
                }
            };
        } else {
            covidEntries.forEach(CovidEntry => covidTable.add(CovidEntry));
            return covidEntries;
        }
    }

    resource function get countries/[string iso_code]() returns CovidEntry | InvalidIsoErrorCode {
        CovidEntry? covidEntry = covidTable[iso_code];
        
        if covidEntry is () {
            return {
                body: {
                    errmsg: string `Invalid ISO Code: ${iso_code}`
                }
            };
        } else {
            return covidEntry;
        }
    }
}

public type ConflictingIsoCodesError record {|
    *http:Conflict;
    ErrorMsg body;
|};

public type InvalidIsoErrorCode record {|
    *http:NotFound;
    ErrorMsg body;
|};

public type ErrorMsg record {|
    string errmsg;
|};
