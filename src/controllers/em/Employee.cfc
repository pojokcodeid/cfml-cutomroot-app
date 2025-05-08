
component extends="core.BaseController" {
    variables.emp = model("em.Employee");

    public function init() {
        return this;
    }

    public struct function sayHay(id){
        return emp.sayHay(id);
    }

    public struct function getAll(){
        return emp.getAllData();
    }

    public struct function getById(id){
        return emp.getById(id);
    }

    public struct function createData(content={}){
        return emp.createData(content);
    }

    public struct function updateData(id){
        return emp.updateData(id);
    }
    public struct function deleteData(id){
        return emp.deleteData(id);
    }
    
}