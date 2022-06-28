import Foundation

class CartUseCase {
    
    var logger: Logger
    
    init(logger: Logger){
        self.logger = logger
    }
    
    func getDiscountCampaign(productId: String) -> DiscountCampaign? {
        print("CartUseCase.getDiscountCampaign: Returns Discount Campaing for the Product Id on Current Date", to: &logger)
        return DiscountCampaign()
    }
    
    func updateCartItemWithDiscount(cartItem: CartItem, campaign: DiscountCampaign) -> CartItem {
        print("CartUseCase.updateCartItemWithDiscount: Applies discount if valid based on the Campaign Parameters and Quantity Of Items", to: &logger)
        return cartItem
    }
    
    func getShippingOptions(zipCode: String) -> [ShippingOption] {
        print("CartUseCase.getShippingOptions(): Returns ShippingOptions for the informed zipCode via service call", to: &logger)
        return [ShippingOption()]
    }
}
