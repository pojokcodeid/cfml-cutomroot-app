component {

    function begin() {
        app = new fw.App();
        app.setDefaultController("controllers.Default");
        app.setDefaultControllerMethod("index");
        app.get("/employee/say-hay", { controller: "controllers.Employee", method: "sayHay"});
        app.get("/employee", { controller: "controllers.Employee", method: "getAll"});
        app.get("/employee/:id", { controller: "controllers.Employee", method: "getById"});
        app.post("/employee", { controller: "controllers.Employee", method: "createData"});
        app.put("/employee/:id", { controller: "controllers.Employee", method: "updateData"});
        app.delete("/employee/:id", { controller: "controllers.Employee", method: "deleteData"});
        return app.run();
    }
}
