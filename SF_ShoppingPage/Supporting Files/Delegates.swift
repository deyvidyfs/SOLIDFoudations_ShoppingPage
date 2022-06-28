//
//  Delegates.swift
//  SF_ShoppingPage
//
//  Created by Deyvidy Salvino on 26/06/22.
//

import Foundation

protocol CartDelegate {
    var cart: [CartItem]? { get set }
    
    func removeFromCart(index: Int)
    func updateCart(cartItems: [CartItem]?)
    func closeCart()
}

protocol OrderDelegate {
    var order: Order? { get set }
    
    func placeOrder()
}
