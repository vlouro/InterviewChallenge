//
//  ImageView+Extension.swift
//  ProductLists
//
//  Created by Valter Louro on 11/04/2024.
//

import Foundation
import UIKit

/*
 Extension for UIImageView to download Image from URL
 */

var imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    public func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage) {
        
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            DispatchQueue.main.async {
                self.image = cacheImage
                return
            }
        }
    
        DispatchQueue.main.async {
            if self.image == nil {
                self.image = PlaceHolderImage
            }
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                DispatchQueue.main.async {
                    self.image = UIImage(named: "error")
                }
                return
            }
            
            guard let data = data else { return }
            let image = UIImage(data: data)
            imageCache.setObject(image!, forKey: urlString as AnyObject)
            
            DispatchQueue.main.async {
                self.image = image
            }
            
        }).resume()
    }
}
