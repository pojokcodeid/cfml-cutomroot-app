component{
    
    public function init() {
        return this;
    }
    
    public struct function sayHay(id){
        return { 
            code: 200,
			success=true,
			message="Get Data Success", 
            key=id,
			data= {
                name="Pojok Code"
            }
		};
    }
    public array function getAllData(){
        local.personals = [];
        local.qPersonal = queryExecute(
            "SELECT id, name, email, age FROM personal"
        );
        for (var p in local.qPersonal) {
            arrayAppend(local.personals, {
                id = p.id,
                name = p.name,
                email = p.email,
                age = p.age
            });
        }
        return local.personals;
    }

    public struct function getById(id){
        local.qPersonal = queryExecute(
            "SELECT id, name, email, age FROM personal WHERE id = ?",
            [id]
        );
        if (local.qPersonal.recordCount) {
            return { 
                id = local.qPersonal.id,
                name = local.qPersonal.name,
                email = local.qPersonal.email,
                age = local.qPersonal.age
            };
        }
        return {}
    }

    public any function createData(content){
        local.dataToInsert = {
            name = {value=content.name, sqltype="CF_SQL_VARCHAR"},
            email = {value=content.email, sqltype="CF_SQL_VARCHAR"},
            age = {value=content.age, sqltype="CF_SQL_INTEGER"}
        };
        local.qInsert = queryExecute(
            "INSERT INTO personal (name, email, age) VALUES (:name, :email, :age)",
            local.dataToInsert,
            {
                result: "insertResult" // penting untuk dapatkan generatedKey
            }
        );
        lastInsertedId = val(insertResult.generatedKey);
        return {id=lastInsertedId, name=content.name, email=content.email, age=content.age};
    }

    public struct function updateData(content){
        local.dataToUpdate = {
            id = {value=content.id, sqltype="CF_SQL_INTEGER"},
            name = {value=content.name, sqltype="CF_SQL_VARCHAR"},
            email = {value=content.email, sqltype="CF_SQL_VARCHAR"},
            age = {value=content.age, sqltype="CF_SQL_INTEGER"}
        };
        local.qUpdate = queryExecute(
            "UPDATE personal SET name = :name, email = :email, age = :age WHERE id = :id",
            local.dataToUpdate
        );
        return { 
            id = content.id,
            name = content.name,
            email = content.email,
            age = content.age
		};
    }

    public struct function deleteData(id){
        local.qDelete = queryExecute(
                "DELETE FROM personal WHERE id = ?",
                [id],
                {
                    result: "deleteResult"
                }
            );
        if (deleteResult.recordCount) {
            return {
                id=id
            };
        } else {
            return {
                id=0
            };
        }
    }
}