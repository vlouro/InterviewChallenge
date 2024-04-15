//
//  Product.swift
//  ProductLists
//
//  Created by Valter Louro on 11/04/2024.
//

import Foundation

typealias Products = [Product]

// MARK: - Api Response
struct ProductApiResponse: Codable {
    let products: [Product]?
    let total, skip, limit: Int
}

struct Product : Codable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String?
    let images: [String]?
}
