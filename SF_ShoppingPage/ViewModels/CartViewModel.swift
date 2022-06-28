import Foundation

class CartViewModel {
    private let cartUseCase: CartUseCase
    
    var logger: Logger
    var delegate: CartDelegate?
    
    var cart: [CartItem]?
    
    init(logger: Logger, delegate: CartDelegate){
        self.logger = logger
        self.delegate = delegate
        cart = delegate.cart
        
        cartUseCase = CartUseCase(logger: logger)
        
    }
    
    func addToCart(product: Product, quantity: Int) {
        print("CartViewModel.addToCart: Checks if Item has any discounts, adds Item to Cart", to: &logger)
        var cartItem = CartItem(product: product, quantity: quantity)
        if let discountCampaign = cartUseCase.getDiscountCampaign(productId: cartItem.product.id) {
            cartItem = cartUseCase.updateCartItemWithDiscount(cartItem: cartItem, campaign: discountCampaign)
        }
        cart?.append(cartItem)
    }
    
    func removeFromCart(index: Int) {
        print("CartViewModel.removeFromCart: Removes the specified item of the cart via UseCase", to: &logger)
        delegate?.removeFromCart(index: index)
    }
    
    func getShippingOptions(zipCode: String) -> [ShippingOption]? {
        print("CartViewModel.getShippingOptions: Returns ShippingOptions for the informed zipCode via service call", to: &logger)
        return cartUseCase.getShippingOptions(zipCode: zipCode)
    }
    
    func closeCart() {
        print("CartViewModel.closeCart: Point of entry for Order Creation on ShoppingExperienceViewModel", to: &logger)
        delegate?.closeCart()
    }
}
