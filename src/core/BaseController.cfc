component extends="core.Message" {
    function init() {
        return this;
    }

    function view(filePath, content={}) {
        // extract content supaya dapat digunakan di cfm file
        for (var key in content) {
            variables[key] = content[key];
        }
        if (fileExists("/views/#replace(filePath, ".", "/", "all")#.cfm")) {
            include "/views/templates/header.cfm";
            include "/views/#replace(filePath, ".", "/", "all")#.cfm";
            include "/views/templates/footer.cfm";
        } else {
            throw("File not found: " & filePath);
        }
    }

    function model(modelFile){
        var modelPath = "/models/#replace(modelFile, ".", "/", "all")#.cfc";
        if (fileExists(expandPath(modelPath))) {
            return createObject("component", "models.#modelFile#");
        }else{
            throw("File not found: " & modelPath);
        }
    }

    function redirect(parhUrl){
        cflocation(url=application.baseURL & parhUrl);
    }

}