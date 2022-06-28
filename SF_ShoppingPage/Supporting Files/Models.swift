import Foundation

protocol AddressInformationProtocol {
    var addressInformation: AddressInformation? { get set }
}

struct Product {
    let id: String
}

struct User {
    let id: String
}

struct CartItem {
    let product: Product
    var quantity: Int
}

struct Order {
    var userId: String = String()
    var cartItems: [CartItem] = []
    var total: Double = 0.0
    var subtotal: Double = 0.0
    var shippingInformation: ShippingInformation? = ShippingInformation()
    var billingInformation: BillingInformation? = BillingInformation()
    
    init() {}
    
    init(cartItems: [CartItem]) {
        self.cartItems = cartItems
    }
}

struct ShippingInformation: AddressInformationProtocol {
    var addressInformation: AddressInformation?
    var shippingOption: ShippingOption?
    
    init() {
        addressInformation = AddressInformation()
        shippingOption = ShippingOption()
    }
}

struct BillingInformation: AddressInformationProtocol {
    var addressInformation: AddressInformation?
    var paymentInformation: PaymentInformation?
    
    init() {
        addressInformation = AddressInformation()
        paymentInformation = PaymentInformation()
    }
}

struct ShippingOption {
    init() {}
}

struct DiscountCampaign {
    init() {}
}

