//
//  ProductListViewController.swift
//  ProductLists
//
//  Created by Valter Louro on 11/04/2024.
//

import Foundation
import UIKit

class ProductListViewController: UIViewController {
    
    let cellIdentifier = "ProductListCollectionViewCell"
    var pageNumber = 0
    var isLoading = false
    var isGridLayout = false
    
    let productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.alwaysBounceVertical = true
        collectionview.showsVerticalScrollIndicator = false
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        return collectionview
    }()
    
    lazy var viewModel = {
        ProductViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupNavigationBarLayout()
        self.setupViews()
        self.initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Product List"
    }
    
    //MARK: SETUP NAVIGATION BAR LAYOUT
    func setupNavigationBarLayout() {
        navigationController?.appearanceNavigation()
    }
    
    //MARK: SETUP VIEW
    func setupViews() {
        self.view.backgroundColor = .white
        self.productCollectionView.delegate = self
        self.productCollectionView.dataSource = self
        self.productCollectionView.register(UINib(nibName: "ProductListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        self.view.addSubview(productCollectionView)
        
        NSLayoutConstraint.activate([
            productCollectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            productCollectionView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
            productCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            productCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    func initViewModel() {
        
        viewModel.getProducts()
        viewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.productCollectionView.reloadData()
            }
        }
    }
    
}

//MARK: COLLECTIONVIEW DELEGATE
extension ProductListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! ProductListCollectionViewCell
            cell.cellViewModel = self.viewModel.productsCellViewModels[indexPath.row]
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetail = ProductDetailViewController()
        productDetail.product = self.viewModel.product[indexPath.row]
        productDetail.setupTexts()
        self.navigationController?.pushViewController(productDetail, animated: false)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == viewModel.product.count - 10 {
            viewModel.getProducts()
            viewModel.reloadCollectionView = { [weak self] in
                DispatchQueue.main.async {
                    self?.productCollectionView.reloadData()
                }
            }
        }
    }
}

//MARK: COLLECTIONVIEW DATA SOURCE
extension ProductListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.product.count
    }
}

//MARK: COLLECTIONVIEW DELEGATEFLOWLAYOUT
extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = CGFloat(UIScreen.main.bounds.size.width)
            let height = CGFloat(100)
            
            return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}
