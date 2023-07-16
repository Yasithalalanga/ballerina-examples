import ballerina/http;

# Http listener -> Opens port 9000
listener http:Listener httpListener = new (9000);

service /api on httpListener {
    resource function get projects() returns ProjectEntry[] {
        return projectTable.toArray();
    }

    resource function post projects(@http:Payload ProjectEntry project) returns ProjectEntry {
        
        // TODO: Check whether a record is available for the given id & Validate
        projectTable.add(project);
        return project;
    }
}
