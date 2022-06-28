import Foundation

struct AddressInformation {
    var addressLine1: String
    var addressLine2: String
    var number: String
    var zipCode: String
    
    init() {
        addressLine1 = String()
        addressLine2 = String()
        number = String()
        zipCode = String()
    }
}

class LocationHandler {
    
    var logger: Logger
    
    init(logger: Logger){
        self.logger = logger
    }
    
    func getAddressFromZipCode(zipCode: String) -> AddressInformation {
        print("LocationHandler.getAddressFromZipCode: This function returns the full Address for the zipCode", to: &logger)
        return AddressInformation()
    }
}
