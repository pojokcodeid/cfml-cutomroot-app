component {

    function begin() {
        app = new core.App();
        app.setDefaultController("Default");
        app.setDefaultControllerMethod("index");
        app.get("/employee/say-hay", { controller: "em.Employee", method: "sayHay"});
        app.get("/employee", { controller: "em.Employee", method: "getAll"});
        app.get("/employee/:id", { controller: "em.Employee", method: "getById"});
        app.post("/employee", { controller: "em.Employee", method: "createData"});
        app.put("/employee/:id", { controller: "em.Employee", method: "updateData"});
        app.delete("/employee/:id", { controller: "em.Employee", method: "deleteData"});
        return app.run();
    }
}
