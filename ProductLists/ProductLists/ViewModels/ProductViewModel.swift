//
//  ProductViewModel.swift
//  ProductLists
//
//  Created by Valter Louro on 11/04/2024.
//

import Foundation

class ProductViewModel: NSObject {
    
    var reloadCollectionView: (() -> Void)?
    var product = Products()
    var nextProducts = 0
    var isLoading = false
    var endOfPages = false
    
    var productsCellViewModels = [ProductCellViewModel]() {
        didSet {
            reloadCollectionView?()
        }
    }
    
    private var productService: ProductProtocol
    
    init(productService: ProductProtocol = NetworkRequests()) {
        self.productService = productService
    }
    
    //MARK: Get Products
    func getProducts() {
        if endOfPages {
            return
        }
        
        if getProductsLocally() {
            //
        } else {
            NetworkRequests.shared.getProductList { result in
                switch result {
                    
                case let .success(productList):
                    self.decodeProducts(productsData: productList)
                    break
                case .error(_):
                    print("There was an error")
                }
            }
        }
    }
    
    func decodeProducts(productsData: ProductApiResponse) {
        guard let products = productsData.products, nextProducts < products.count else {
            return
        }
        
        let result = products.enumerated().filter { $0.offset >= nextProducts && $0.offset < nextProducts+10 }.map { $0.element }
        
        var vms = [ProductCellViewModel]()
        
        if nextProducts == 0 {
            self.product = result
            
            for product in result {
                vms.append(self.createProductCellModel(product: product))
            }
            self.productsCellViewModels = vms
        } else {
            self.product.append(contentsOf: result)
           
            for product in result {
                vms.append(self.createProductCellModel(product: product))
            }
            self.productsCellViewModels.append(contentsOf: vms)
            
            if nextProducts >= products.count {
                endOfPages = true
            }
        }

        nextProducts += 10
    }
    
    func createProductCellModel(product: Product) -> ProductCellViewModel {
        
        var icon = ""
        let rating = product.rating
        if let images = product.images, images.count > 0 {
            if rating < 3 {
                icon = images.first ?? ""
            } else if (rating >= 3) && (rating <= 4) {
                icon = images[1]
            } else {
                icon = images.last ?? ""
            }
        } else {
            icon = ""
        }
        let title = product.title
        let price = product.price
        let discount = product.discountPercentage
        let stock = product.stock
        
        return ProductCellViewModel(icon: icon, rating: rating, title: title, price: price, discount: discount, stock: stock)
    }
    
    func getProductViewModel(at indexPath: IndexPath) -> ProductCellViewModel {
        return productsCellViewModels[indexPath.section]
    }
    
    //MARK: Get Products Locally
    func getProductsLocally() -> Bool {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let productURL = documentsURL.appendingPathComponent("productJsonData.json")
        
        do {
            let data = try Data(contentsOf: productURL)
            let response = try JSONDecoder().decode(ProductApiResponse.self, from: data)
            self.decodeProducts(productsData: response)
            return true
        } catch {
            print("Error reading file: \(error)")
            return false
        }
    }
    
}
