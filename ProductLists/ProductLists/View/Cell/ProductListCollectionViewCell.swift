//
//  ProductListCollectionViewCell.swift
//  ProductLists
//
//  Created by Valter Louro on 11/04/2024.
//

import UIKit

class ProductListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var cellViewModel: ProductCellViewModel? {
        didSet {
            nameLbl.text = cellViewModel?.title ?? ""
            if let rating = cellViewModel?.rating {
                ratingLbl.text = "Rating: \(rating)"
            } else {
                ratingLbl.text = "No Rating"
            }
            
            if let imgUrl = cellViewModel?.icon {
                iconImageView.imageFromServerURL(urlString: imgUrl, PlaceHolderImage: UIImage())
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLbl.text = nil
        ratingLbl.text = nil
        iconImageView.image = nil
    }

}
