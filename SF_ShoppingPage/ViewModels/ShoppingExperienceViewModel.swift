//
//  ShoppingExperienceViewModel.swift
//  SF_ShoppingPage
//
//  Created by Deyvidy Salvino on 26/06/22.
//

import Foundation

class ShoppingExperienceViewModel: OrderDelegate, CartDelegate {
    var cart: [CartItem]?
    var order: Order?
    var logger: Logger
    
    init(logger: Logger){
        self.logger = logger
    }
    
    func removeFromCart(index: Int){
        print("ShoppingExperienceViewModel.removeFromCart: Removes Item from Cart", to: &logger)
        cart?.remove(at: index)
    }
    
    func updateCart(cartItems: [CartItem]?) {
        self.cart = cartItems
    }
    
    func closeCart() {
        guard let cart = cart else {
            print("ShoppingExperienceViewModel.closeCart: The cart is empty", to: &logger)
            return
        }

        order = Order(cartItems: cart)
        print("ShoppingExperienceViewModel.closeCart: Creates Order Object based on cartItems and User", to: &logger)
    }
    
    func placeOrder() {
        print("ShoppingExperienceViewModel.placeOrder: Places Order via Backend Service", to: &logger)
    }
}
