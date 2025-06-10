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
