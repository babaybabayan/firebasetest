//
//  Extension.swift
//  noStoryBoardTest
//
//  Created by Fivecode on 07/07/19.
//  Copyright © 2019 Fivecode. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUseCache(urlString: String) {
        //chackImageData
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        let alamat = URL(string: urlString)
        URLSession.shared.dataTask(with: alamat!) { (data, response, err) in
            if err != nil {
                print("Errorakbar \(err!)")
                return
            }
            DispatchQueue.main.async(execute: {
                if let downloadImage = UIImage(data: data!) {
                    imageCache.setObject(downloadImage, forKey: urlString as AnyObject)
                    self.image = downloadImage
                }
                
            })
        }.resume()
    }
}
