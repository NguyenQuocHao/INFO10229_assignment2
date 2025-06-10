// This code was written by Hao Nguyen, 991521091
class Employee {
    var id: Int
    var name: String
    var salary: Double {
        return 0
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    static func validateSalary(salary: Double) -> Bool {
        if (salary < 0) {
            print("Salary/Rate cannot be less than 0")
            return false
        }
        
        return true
    }
    
    static func validateId(id: Int) -> Bool {
        if (id <= 0) {
            print("ID cannot be less than or equal to 0")
            return false
        }
        
        return true
    }
    
    func displayDetails() {
        print("ID: \(id) Name: \(name) Salary: $\(salary)")
    }
}
