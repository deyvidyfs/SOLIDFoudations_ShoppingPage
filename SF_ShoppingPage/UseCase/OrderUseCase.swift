import Foundation

class OrderUseCase {
    
    private let locationHandler: LocationHandler
    private let paymentHandler: PaymentHandler
    
    var logger: Logger
    
    init(logger: Logger){
        self.logger = logger
        locationHandler = LocationHandler(logger: logger)
        paymentHandler = PaymentHandler(logger: logger)
    }
    
    func getAddressFromZipCode(zipCode: String) -> AddressInformation {
        print("OrderUseCase.getAddressFromZipCode: Returns Address from LocationHandler", to: &logger)
        return locationHandler.getAddressFromZipCode(zipCode: zipCode)
    }
    
    func getPaymentOptions(userId: String, subtotal: Double) -> [PaymentOption] {
        print("OrderUseCase.getPaymentOptions: Returns Payment Options from PaymentHandler", to: &logger)
        return paymentHandler.getPaymentOptions(queryParameters: PaymentOptionQueryParameters(userId: userId, subtotal: subtotal))
    }
    
    func isPaymentInformationValid(paymentInformation: PaymentInformation) -> Bool {
        print("OrderUseCase.isPaymentInformationValid: Checks if the Payment information is valid", to: &logger)
        return true
    }
}
