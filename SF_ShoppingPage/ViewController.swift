//
//  ViewController.swift
//  SOLID Foundations: ShoppingPage
//
//  Created by Deyvidy Salvino on 26/06/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let introduction: String = {
        var text = String()
        text.append(contentsOf: "Hello!\n\nThis is a companion app for the SOLID Foundations presentation given on the 35th CocoaHeads Campinas.\n\nThe premise here is that this is Shopping App that has its Cart and Order Creation sections on the same page, as a way of giving the user a more fluid experience, according to the business area.\n\nOn this project, you'll find a partial refactor of this part of the app.\n\nThe objective is to illustrate the gains you can have when keeping SOLID principles in mind when you're coding or refactoring production implementations, whithout necessarily overworking your code to be 100% compliant with all of them.\n\nHere, I applied the MVVM Pattern to the Spaghetti Code, while also changing the code to be somewhat the SOLID principles.\n\nHave fun on exploring it!\nIf you have any questions or suggestions, just hit me up!\n\nMy contact information is on my GitHub Page.\n\nAll the best,\nDeyvidy")
        return text
    }()
    
    let userActions: String = {
        var text = String()
        text.append(contentsOf: "User Actions:\n- Removes Product ABC from the Cart\n")
        text.append(contentsOf: "- Adds (2) Product 001 to the Cart\n")
        text.append(contentsOf: "- Checks Shipping Options\n- Selects One\n")
        text.append(contentsOf: "- Press Checkout Button\n")
        text.append(contentsOf: "- Fills Shipping Zip Code\n- Fills Address Info\n")
        text.append(contentsOf: "- Checks Shipping and Billing Address are the same\n")
        text.append(contentsOf: "- Fills Payment Info\n")
        text.append(contentsOf: "- Places Order\n\n")
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textView.text = introduction
    }
    
    @IBAction func segmentedControlClicked(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            textView.text = introduction
        case 1:
            textView.text = emulateNonSolidExample()
        case 2:
            textView.text = emulateSolidExample()
        default:
            break
        }
    }
    
    func emulateNonSolidExample() -> String {
        let logger = Logger()
        let nsShoppingExperienceViewModel = NSShoppingExperienceViewModel(logger: logger)
        
        nsShoppingExperienceViewModel.cart = [CartItem(product: Product(id: "ABC"), quantity: 1)]
        
        let cartItemToBeRemoved = nsShoppingExperienceViewModel.cart[0]
        let productToBeAdded = Product(id: "0001")
        
        var text = userActions
        
        text.append(contentsOf:
        "Project Components:\n-ShoppingExperienceViewController (emulated)\n-ShoppingExperienceViewModel\n-ShoppingExperienceView (not implemented)\n\nImported Sources:\n-LocationHandler\n-PaymentHandler\n\n")
                
        //Performing User Actions
        nsShoppingExperienceViewModel.removeFromCart(cartItem: cartItemToBeRemoved)
        nsShoppingExperienceViewModel.addToCart(product: productToBeAdded, quantity: 2)
        _ = nsShoppingExperienceViewModel.getShippingOptions(zipCode: "000-0000")
        nsShoppingExperienceViewModel.closeCart()
        nsShoppingExperienceViewModel.getPaymentOptions()
        nsShoppingExperienceViewModel.getShippingInformationFromZipCode(zipCode: "000-0000")
        nsShoppingExperienceViewModel.setSameShippingBillingAddress()
        _ = nsShoppingExperienceViewModel.validatesPaymentInformation()
        nsShoppingExperienceViewModel.placeOrder()
        
        text.append(contentsOf: "Debug Logging:\n")
        text.append(contentsOf: logger.fullLog)
        return text
    }
    
    func emulateSolidExample() -> String {
        let logger = Logger()
        let shoppingExperienceViewModel = ShoppingExperienceViewModel(logger: logger)
        let cartViewModel = CartViewModel(logger: logger, delegate: shoppingExperienceViewModel)
        let ordersViewModel = OrderViewModel(logger: logger, delegate: shoppingExperienceViewModel)
        
        shoppingExperienceViewModel.cart = [CartItem(product: Product(id: "ABC"), quantity: 1)]
        
        
        let productToBeAdded = Product(id: "0001")
        
        var text = userActions
        text.append(contentsOf: "Project Components:\n- ViewControllers:\n-- ShoppingExperienceViewController (emulated)\n- ViewModels:\n-- ShoppingExperienceViewModel\n-- CartViewModel\n-- OrderViewModel\n- Views:\n-- ShoppingExperienceView (not implemented)\n-- CartView (not implemented)\n-- OrderView (not implemented)\n- UseCases:\n-- CartUseCase\n-- OrderUseCase\n\nImported Sources:\n- LocationHandler\n- PaymentHandler\n\n")
        
        //Performing User Actions
        if let _ = shoppingExperienceViewModel.cart?[0] {
            cartViewModel.removeFromCart(index: 0)

        }
        cartViewModel.addToCart(product: productToBeAdded, quantity: 2)
        _ = cartViewModel.getShippingOptions(zipCode: "000-0000")
        cartViewModel.closeCart()
        
        ordersViewModel.getPaymentOptions()
        ordersViewModel.getShippingInformationFromZipCode(zipCode: "000-0000")
        ordersViewModel.setSameShippingBillingAddress()
        _ = ordersViewModel.confirmPaymentInformation()
        ordersViewModel.closeOrder()
        
        text.append(contentsOf: "Debug Logging:\n")
        text.append(contentsOf: logger.fullLog)
        return text
    }
}

