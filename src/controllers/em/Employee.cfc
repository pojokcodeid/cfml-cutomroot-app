
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

    private void function uploadAttach(content={}){
        if (structKeyExists(content, "lampiran")) { 
            // Ambil informasi file upload
            fileField = "lampiran";
            uploadDir = expandPath("/public/uploads/");
          
            // Buat folder jika belum ada
            if (!directoryExists(uploadDir)) {
              directoryCreate(uploadDir);
            }
          
            // Upload dan rename
            uploadedFile = fileUpload(
                destination = uploadDir, 
                fileField = fileField, 
                mode = "makeunique"
            );
            // Ambil ekstensi file original
            fileExt = listLast(uploadedFile.serverFile, ".");
          
            // Generate nama UUID
            uuidName = createUUID() & "." & fileExt;
            content.lampiran = uuidName;
            
            // Rename file ke UUID
            fileMove(
              source = uploadedFile.serverDirectory & "/" & uploadedFile.serverFile,
              destination = uploadDir & uuidName
            );

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
            uploadAttach(content);
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
            var data = emp.getById(id);
            if (!structKeyExists(data, "id")) {
                return {
                    code: 404,
                    success: false,
                    message: "Not Found",
                    data: {}
                };
            }
            // cek apakah lampiran ada isinya
            if (structKeyExists(content, "lampiran") && len(trim(content.lampiran)) > 0) {
                // hapus file lama
                if (structKeyExists(data, "attachment")) {
                    var fileToDelete = expandPath("/public/uploads/") & data.attachment;
                    if (fileExists(fileToDelete)) {
                        fileDelete(fileToDelete);
                    }
                }
                // upload file baru
                uploadAttach(content);
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