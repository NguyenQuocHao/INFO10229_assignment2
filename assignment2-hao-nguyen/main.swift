// Employee.swift
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

// FullTimeEmployee.swift
// This code was written by Hao Nguyen, 991521091
class FullTimeEmployee : Employee {
    var monthlySalary: Double
    override var salary: Double {
        get {
            return self.monthlySalary
        }
    }
        
    init(id: Int, name: String, monthlySalary: Double) {

        self.monthlySalary = monthlySalary
        
        super.init(id: id, name: name)
    }
    
    func calculateTax() -> Double {
        return salary * 20 / 100
    }
    
    override func displayDetails() {
        super.displayDetails()
        
        print("Tax: \(calculateTax())")
    }
}

// PartTimeEmployee.swift
// This code was written by Hao Nguyen, 991521091
class PartTimeEmployee : Employee, Taxable {
    var hourlyRate: Double
    var hoursWorked: Int
    override var salary: Double {
        get {
            return self.hourlyRate * Double(self.hoursWorked)
        }
    }

    init(id: Int, name: String, hourlyRate: Double, hoursWorked: Int) {
        self.hourlyRate = hourlyRate
        self.hoursWorked = hoursWorked
        
        super.init(id: id, name: name)
    }
    
    static func validateHoursWorked(hours: Int) -> Bool {
        if (hours < 0) {
            print("Hours cannot be less than 0")
            return false
        }
        
        return true
    }
    
    func calculateTax() -> Double {
        return salary * 10 / 100
    }

    override func displayDetails() {
        super.displayDetails()
        
        print("Hourly Rate: \(hourlyRate) Hours Worked: \(hoursWorked) Tax: \(calculateTax())")
    }
}

// Taxable.swift
// This code was written by Hao Nguyen, 991521091
protocol Taxable {
    func calculateTax() -> Double
}

// EmployeeManager.swift
// This code was written by Hao Nguyen, 991521091
class EmployeeManager {
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
        print("Employee with id id \(id) doesn't exist")
    }
}

// Program.swift
// This code was written by Hao Nguyen, 991521091
func showAddFullTimeEmployeeMenu() {
    let employeeId = promptEmployeeId()
    
    let employeeName = promptName()
    
    let monthlySalary = promptMonthlySalary()

    EmployeeManager.addFullTimeEmployee(employee: FullTimeEmployee(id: employeeId, name: employeeName, monthlySalary: monthlySalary))
    
    printDelimeter()
}

func showAddPartTimeEmployeeMenu() {
    let employeeId = promptEmployeeId()
    
    let employeeName = promptName()
    
    let hourlyRate = promptHourlyRate()
    
    let hoursWorked = promptHoursWorked()

    EmployeeManager.addPartTimeEmployee(employee: PartTimeEmployee(id: employeeId, name: employeeName, hourlyRate: hourlyRate, hoursWorked: hoursWorked))
    
    printDelimeter()
}

func promptEmployeeId() -> Int {
    print("Enter employee's ID:")
    var employeeId = 0
    while (employeeId == 0) {
        let id = getIntFromPrompt()
        
        if Employee.validateId(id: id) {
            if EmployeeManager.containsEmployee(id: id) {
                print("There's already an employee with ID \(id)")
            }
            else {
                employeeId = id
                break;
            }
        }
        
        print("Please try again.")
    }
    
    return employeeId
}

func promptName() -> String {
    print("Enter employee's name:")

    while true {
        guard let name = readLine(), !name.isEmpty else {
            print("Employee name cannot be empty")
            continue
        }
        return name
    }
}

func promptMonthlySalary() -> Double {
    print("Enter monthly salary:")
    return promptSalaryOrRate()
}

func promptHourlyRate() -> Double {
    print("Enter hourly rate:")
    return promptSalaryOrRate()
}

func promptSalaryOrRate() -> Double {
    var salary: Double = 0
    
    while true {
        let input: String = readLine() ?? ""

        if let unwrapped = Double(input), Employee.validateSalary(salary: unwrapped) {
            salary = unwrapped
            break
        }
        
        print("Invalid value. Please try again.")
    }
    
    return salary
}

func promptHoursWorked() -> Int {
    print("Enter hours worked:")
    var hoursWorked: Int = 0
    
    while true {
        let input: String = readLine() ?? ""

        if let unwrapped = Int(input), PartTimeEmployee.validateHoursWorked(hours: unwrapped) {
            hoursWorked = unwrapped
            break
        }
        
        print("Invalid value. Please try again.")
    }
    
    return hoursWorked
}

func viewEmployees() {
    let employees = EmployeeManager.getEmployeeList()
    
    print("Employee List [Count: \(employees.count)]")
    
    for employee in employees {
        print("-------")
        employee.displayDetails();
    }
    printDelimeter()
}

func getIntFromPrompt() -> Int {
    var id = 0
    if let unwrappedId = Int(readLine() ?? "") {
        id = unwrappedId
    }
    else {
        print("Invalid interger")
    }
    
    return id
}

func searchEmployeeMenu() {
    print("Enter employee's ID:")
    
    searchEmployeeId(id: getIntFromPrompt())
    
    printDelimeter()
}

func searchEmployeeId(id: Int) {
    let employee = EmployeeManager.getEmployee(id: id)
    
    if let unwrapped = employee {
        unwrapped.displayDetails()
        return
    }
    
    print ("Can't find employee with id \(id)")
}

func removeEmployeeMenu() {
    print("Enter employee's ID:")
    
    removeEmployeeId(id: getIntFromPrompt())
    
    printDelimeter()
}

func removeEmployeeId(id: Int) {
    EmployeeManager.removeEmployee(id: id)
}

func userQuits (input: String?) -> Bool {
    return input?.lowercased() == "q"
}

func printDelimeter() {
    print("----------------------------------")
}

func printInstructions() {
    print("Enter 1 to add Full-Time employee")
    print("      2 to add Part-Time employee")
    print("      3 to display all employees")
    print("      4 to remove employee by ID")
    print("      5 to search employee by ID")
    print("      q to quit")
    printDelimeter()
}

var input: String = ""
while (!userQuits(input: input)) {
    printInstructions()
    input = readLine() ?? ""
    
    switch input {
        case "q":
            print("Thanks for using! Exiting...")
            break
        case "1":
            showAddFullTimeEmployeeMenu()
        case "2":
            showAddPartTimeEmployeeMenu()
        case "3":
            viewEmployees()
        case "4":
            removeEmployeeMenu()
        case "5":
            searchEmployeeMenu()
        default:
            print("Invalid menu option. Please try again.")
            printDelimeter()
    }
}
