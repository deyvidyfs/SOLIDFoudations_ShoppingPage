import Foundation

struct PaymentOption {
    init() {}
}

struct PaymentInformation {
    init() {}
}

struct PaymentOptionQueryParameters {
    let userId: String
    let subtotal: Double
}

class PaymentHandler {
    
    var logger: Logger
    
    init(logger: Logger){
        self.logger = logger
    }
    
    func getPaymentOptions(queryParameters: PaymentOptionQueryParameters) -> [PaymentOption] {
        print("PaymentHandler.getPaymentOptions: This function returns the available payment options for the order", to: &logger)
        return [PaymentOption()]
    }
        
    func validadePaymentInfo(paymentInfo: PaymentInformation) -> Bool {
        print("PaymentHandler.validadePaymentInfo: This function validates if the payment info is valid", to: &logger)
        return true
    }
}
