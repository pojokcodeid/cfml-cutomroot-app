
component extends="core.BaseController" {
    variables.emp = model("em.Employee");
    variables.rules = {
        name  : "required|min:3|max:20",
        email : "required|is_email|max:50",
        age: "required|is_numeric"
    }

    public function init() {
        return this;
    }

    public struct function sayHay(id){
        return emp.sayHay(id);
    }

    public struct function getAll(){
        try{
            return { 
                code: 200,
                success=true,
                message="Get All Data Success", 
                data = emp.getAllData()
            };
        } catch (any e) {
            return {
                success: false,
                code: 500,
                message: e.message,
                data: []
            };
        }
    }

    public struct function getById(id){
        try{
            return { 
                code: 200,
                success=true,
                message="Get Data Success", 
                data = emp.getById(id)
            };
        } catch (any e) {
            return {
                success: false,
                code: 500,
                message: e.message,
                data: {}
            };
        }
    }

    public struct function createData(content={}){
        try{
            var result = validate(content, rules);
            if(not result.success){
                return {
                    success: false,
                    code: 400,
                    message:  result.errors[1],
                    data: {}
                };
            }
            return { 
                code: 200,
                success=true,
                message="Create Data Success", 
                data = emp.createData(content)
            };
        } catch (any e) {
            return {
                success: false,
                code: 500,
                message: e.message,
                data: {}
            };
        }
    }

    public struct function updateData(id, content={}){
        try{
            content.id = id;
            var result = validate(content, rules);
            if(not result.success){
                return {
                    success: false,
                    code: 400,
                    message:  result.errors[1],
                    data: {}
                };
            }
            var personal = emp.getById(id);
            if (!structKeyExists(personal, "id")) {
                return {
                    code: 404,
                    success: false,
                    message: "Not Found",
                    data: {}
                };
            }
            return { 
                code: 200,
                success=true,
                message="Update Data Success", 
                data = emp.updateData(content)
            };
        } catch (any e) {
            return {
                success: false,
                code: 500,
                message: e.message,
                data: {}
            };
        }
    }
    public struct function deleteData(id){
        try{
            var personal = emp.getById(id);
            if (!structKeyExists(personal, "id")) {
                return {
                    code: 404,
                    success: false,
                    message: "Not Found",
                    data: {}
                };
            }
            if(emp.deleteData(id).id != id){
                personal = {};
            }
            return { 
                code: 200,
                success=true,
                message="Delete Data Success", 
                data = personal
            };
        } catch (any e) {
            return {
                success: false,
                code: 500,
                message: e.message,
                data: {}
            };
        }
    }
    
}