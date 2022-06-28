import Foundation

class OrderViewModel {
    
    private let orderUseCase: OrderUseCase
    
    var delegate: OrderDelegate?
    var paymentOptions: [PaymentOption]?
    var logger: Logger
    
    init(logger: Logger, delegate: OrderDelegate?){
        self.logger = logger
        self.delegate = delegate
        orderUseCase = OrderUseCase(logger: logger)
    }
    
    func getShippingInformationFromZipCode(zipCode: String) {
        print("OrderViewModel.getShippingInformationFromZipCode: Fills the Shipping Information - Address Information field", to: &logger)
        delegate?.order?.shippingInformation?.addressInformation = orderUseCase.getAddressFromZipCode(zipCode: zipCode)
    }
    
    func getBillingInformationFromZipCode(zipCode: String) {
        print("OrderViewModel.getBillingInformationFromZipCode: Fills the Billing Information - Address Information field", to: &logger)
        delegate?.order?.billingInformation?.addressInformation = orderUseCase.getAddressFromZipCode(zipCode: zipCode)
    }
    
    func setSameShippingBillingAddress() {
        print("OrderViewModel.setSameShippingBillingAddress: Fills the Billing Information - Address Information based on the Shipping Information", to: &logger)
        if let shippingAddressInformation = delegate?.order?.shippingInformation?.addressInformation {
            delegate?.order?.billingInformation?.addressInformation = shippingAddressInformation
        }
    }
    
    func getPaymentOptions() {
        print("OrderViewModel.getPaymentOptions: Gets the Available Payment Options from backend microsservice", to: &logger)
        guard let order = delegate?.order else { return }
        paymentOptions = orderUseCase.getPaymentOptions(userId: order.userId, subtotal: order.subtotal)
    }
    
    func confirmPaymentInformation() -> Bool {
        print("OrderViewModel.confirmPaymentInformation: Validates the Payment Information", to: &logger)
        guard let paymentInformation = delegate?.order?.billingInformation?.paymentInformation else { return false }
        
        if(!orderUseCase.isPaymentInformationValid(paymentInformation: paymentInformation)){
            return false
        }
        return true
    }
    
    func closeOrder() {
        print("OrderViewModel.closeOrder: Point of entry for Order Closing on ShoppingExperienceViewModel", to: &logger)
        delegate?.placeOrder()
    }

}
