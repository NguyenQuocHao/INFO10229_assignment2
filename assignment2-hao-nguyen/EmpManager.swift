// This code was written by Hao Nguyen, 991521091
class EmpManager {
    private static var _employeeList: [Int: Employee] = [:]
    
    static func getEmployeeList() -> [Employee] {
        return Array(_employeeList.values)
    }
    
    static func getEmployee(id: Int) -> Employee? {
        return _employeeList[id]
    }
    
    static func containsEmployee(id: Int) -> Bool {
        return _employeeList[id] != nil
    }
    
    static func addFullTimeEmployee(employee: FullTimeEmployee) {
        if (containsEmployee(id: employee.id)) {
            print("Employee with id \(employee.id) already exists");
            return
        }
        
        _employeeList[employee.id] = employee
    }
    
    static func addPartTimeEmployee(employee: PartTimeEmployee) {
        if (containsEmployee(id: employee.id)) {
            print("Employee with id already exists")
            return
        }
        
        _employeeList[employee.id] = employee
    }
 
     static func removeEmployee(id: Int) {
        if (!containsEmployee(id: id)) {
            print("Employee with id \(id) doesn't exist")
            return
        }
        
        _employeeList.removeValue(forKey: id)
        print("Employee with id \(id) was deleted successfully")
    }
}
