import ballerina/http;

# Http listener -> Opens port 9090
listener http:Listener httpListener = new (9090);

service /api on httpListener {
    resource function get projects() returns ProjectEntry[] {
        return projectTable.toArray();
    }

    resource function post projects(@http:Payload ProjectEntry project) returns ProjectEntry {
        projectTable.add(project);
        return project;
    }
}
