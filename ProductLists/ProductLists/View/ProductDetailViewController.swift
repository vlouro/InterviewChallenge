//
//  ProductDetailViewController.swift
//  ProductLists
//
//  Created by Valter Louro on 11/04/2024.
//

import Foundation
import UIKit

class ProductDetailViewController: UIViewController {
    
    var product : Product? = nil
    
    let scrollView : UIScrollView = {
        let scrView = UIScrollView()
        scrView.translatesAutoresizingMaskIntoConstraints = false
        return scrView
    }()
    
    let contentView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let productImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let productRatingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let productPriceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let productDiscountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let productStockLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.appearanceNavigation()
        self.navigationController?.navigationBar.backItem?.title = "Back"
        self.view.backgroundColor = .customBackgroundColor
        setupScrollView()
        setupViews()
    }
    
    //MARK: Add ScrollView
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    //MARK: Add Views
    func setupViews(){
        
        contentView.addSubview(productImageView)
        productImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        productImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive = true
        
        contentView.addSubview(productNameLabel)
        productNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 16).isActive = true
        productNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        contentView.addSubview(productRatingLabel)
        productRatingLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        productRatingLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 25).isActive = true
        productRatingLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        contentView.addSubview(productPriceLabel)
        productPriceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        productPriceLabel.topAnchor.constraint(equalTo: productRatingLabel.bottomAnchor, constant: 25).isActive = true
        productPriceLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        contentView.addSubview(productDiscountLabel)
        productDiscountLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        productDiscountLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 25).isActive = true
        productDiscountLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        productDiscountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        contentView.addSubview(productStockLabel)
        productStockLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        productStockLabel.topAnchor.constraint(equalTo: productDiscountLabel.bottomAnchor, constant: 25).isActive = true
        productStockLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }
    
    //MARK: Information setup
    func setupTexts() {
        if let images = product?.images, let rating = product?.rating {
            var imageUrl = ""
            if rating < 3 {
                imageUrl = images.first ?? ""
            } else if (rating >= 3) && (rating <= 4) {
                imageUrl = images[1]
            } else {
                imageUrl = images.last ?? ""
            }
            productImageView.imageFromServerURL(urlString: imageUrl, PlaceHolderImage: UIImage())
        } else {
            
        }
        
        if let productName = product?.title  {
            productNameLabel.text = "Name: \(productName)"
            self.title = productName
        } else {
            productNameLabel.text = "Name: Unknown"
        }
        
        if let productRating = product?.rating {
            productRatingLabel.text = "Rating: \(productRating)"
        } else {
            productRatingLabel.text = "Rating: N/A"
        }
        
        if let productPrice = product?.price {
            productPriceLabel.text = "Price: \(productPrice)"
        } else {
            productPriceLabel.text = "Price: N/A"
        }
        
        if let productDiscount = product?.discountPercentage {
            productDiscountLabel.text = "Discount: \(productDiscount)%"
        } else {
            productDiscountLabel.text = "Discount: 0%"
        }
        
        if let productStock = product?.stock {
            productStockLabel.text = "Stock: \(productStock)"
        } else {
            productStockLabel.text = "Stock: N/A"
        }
    }

}
