//
//  CartDataService.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 1.09.2024.
//

import Foundation
import Combine

// MARK: - CartDataServicing

protocol CartDataServicing {
    var cartItemsPublisher: AnyPublisher<[String], Never> { get }
    var itemCount: Int { get }
    func addToCart(signalId: String)
    func removeFromCart(signalId: String)
    func clearCart()
    func fetchCartItems()
}

// MARK: - CartDataService

final class CartDataService {
    private let userDefaults: UserDefaults
    private let cartItemsSubject = PassthroughSubject<[String], Never>()
    private let cartKey = "cartItems"
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
}

// MARK: - CartDataServicing Implementation

extension CartDataService: CartDataServicing {
    var cartItemsPublisher: AnyPublisher<[String], Never> {
        cartItemsSubject.eraseToAnyPublisher()
    }
    
    var itemCount: Int {
        fetchCurrentCart().count
    }
    
    func addToCart(signalId: String) {
        var currentCart = fetchCurrentCart()
        currentCart.insert(signalId)
        saveCart(currentCart)
        cartItemsSubject.send(Array(currentCart))
    }
    
    func removeFromCart(signalId: String) {
        var currentCart = fetchCurrentCart()
        currentCart.remove(signalId)
        saveCart(currentCart)
        cartItemsSubject.send(Array(currentCart))
    }
    
    func clearCart() {
        saveCart(Set<String>())
        cartItemsSubject.send([])
    }
    
    func fetchCartItems() {
        let currentCart = fetchCurrentCart()
        cartItemsSubject.send(Array(currentCart))
    }
}

// MARK: - Helpers

extension CartDataService {
    private func fetchCurrentCart() -> Set<String> {
        let savedCart = userDefaults.stringArray(forKey: cartKey) ?? []
        return Set(savedCart)
    }
    
    private func saveCart(_ cart: Set<String>) {
        userDefaults.set(Array(cart), forKey: cartKey)
    }
}
