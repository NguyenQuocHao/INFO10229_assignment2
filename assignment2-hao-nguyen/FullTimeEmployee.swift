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
