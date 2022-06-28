import Foundation

class NSShoppingExperienceViewModel {
    
    let locationHandler: LocationHandler
    let paymentHandler: PaymentHandler
    
    var cart: [CartItem] = []
    var order: Order = Order()
    var paymentOptions: [PaymentOption]?
    var logger: Logger
    
    init(logger: Logger){
        self.logger = logger
        locationHandler = LocationHandler(logger: logger)
        paymentHandler = PaymentHandler(logger: logger)
    }
    
    func addToCart(product: Product, quantity: Int) {
        print("NSShoppingExperienceViewModel.addToCart: Checks if Item has any discounts, adds Item to Cart", to: &logger)
        var cartItem = CartItem(product: product, quantity: quantity)
        if let discountCampaign = getDiscountCampaign(productId: cartItem.product.id) {
            cartItem = updateCartItemWithDiscount(cartItem: cartItem, campaign: discountCampaign)
        }
        
        cart.append(cartItem)
    }
    
    func getDiscountCampaign(productId: String) -> DiscountCampaign? {
        print("NSShoppingExperienceViewModel.getDiscountCampaign: Returns Discount Campaing for the Product Id on Current Date", to: &logger)
        return DiscountCampaign()
    }
    
    func updateCartItemWithDiscount(cartItem: CartItem, campaign: DiscountCampaign) -> CartItem {
        print("NSShoppingExperienceViewModel.updateCartItemWithDiscount: Applies discount if valid based on the Campaign Parameters and Quantity Of Items", to: &logger)
        return cartItem
    }
    
    func removeFromCart(cartItem: CartItem) {
        print("NSShoppingExperienceViewModel.removeFromCart: Removes the specified item of the cart", to: &logger)
    }

    func getShippingOptions(zipCode: String) -> [ShippingOption]? {
        print("NSShoppingExperienceViewModel.getShippingOptions: Returns ShippingOptions for the informed zipCode via service call", to: &logger)
        return [ShippingOption()]
    }
    
    func closeCart() {
        print("NSShoppingExperienceViewModel.closeCart: Creates Order Object based on cartItems and User", to: &logger)
        order = Order()
        order.userId = "ABCDE"
    }
    
    func getShippingInformationFromZipCode(zipCode: String) {
        print("NSShoppingExperienceViewModel.getShippingInformationFromZipCode: Fills the Shipping Information - Address Information field", to: &logger)
        order.shippingInformation?.addressInformation = getAddressFromZipCode(zipCode: zipCode)
    }
    
    func getBillingInformationFromZipCode(zipCode: String) {
        print("NSShoppingExperienceViewModel.getBillingInformationFromZipCode: Fills the Billing Information - Address Information field", to: &logger)
        order.billingInformation?.addressInformation = getAddressFromZipCode(zipCode: zipCode)
    }
    
    func setSameShippingBillingAddress() {
        print("NSShoppingExperienceViewModel.setSameShippingBillingAddress: Fills the Billing Information - Address Information based on the Shipping Information", to: &logger)
        
        if let shippingAddressInformation = order.shippingInformation?.addressInformation {
            order.billingInformation?.addressInformation = shippingAddressInformation
        }
    }
    
    func getPaymentOptions() {
        print("NSShoppingExperienceViewModel.getPaymentOptions: Gets the Available Payment Options from backend microsservice", to: &logger)
        paymentOptions = paymentHandler.getPaymentOptions(queryParameters: PaymentOptionQueryParameters(userId: order.userId, subtotal: order.subtotal))
    }
    
    func validatesPaymentInformation() -> Bool {
        print("NSShoppingExperienceViewModel.validatesPaymentInformation: Validates the Payment Information", to: &logger)
        if (!isPaymentInformationValid(paymentInformation: order.billingInformation?.paymentInformation)){
            return false
        }
        return true
    }
    
    func isPaymentInformationValid(paymentInformation: PaymentInformation?) -> Bool {
        print("NSShoppingExperienceViewModel.isPaymentInformationValid: Validates the Payment Information via backend microsservice", to: &logger)
        guard let paymentInformation = paymentInformation else { return false }
        return paymentHandler.validadePaymentInfo(paymentInfo: paymentInformation)
    }
    
    func placeOrder() {
        print("NSShoppingExperienceViewModel.placeOrder: Places order to backend service", to: &logger)
    }
    
    func getAddressFromZipCode(zipCode: String) -> AddressInformation {
        print("NSShoppingExperienceViewModel.getAddressFromZipCode: Calls other module for getting address over zipCode", to: &logger)
        return locationHandler.getAddressFromZipCode(zipCode: zipCode)
    }
}
