//
//  PhotoCell.swift
//  FlickyPhotos
//
//  Created by Abdallah Ehab on 19/05/2022.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var flickerImage: UIImageView!
    
    let cache  = NSCache<NSString,UIImage>()

    
    func getImageFromUrl(for urlString:String){
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey:cacheKey)  {
            self.flickerImage.image = image
            return
        }
        guard let imageUrl = URL(string: urlString) else { return}

        let task = URLSession.shared.dataTask(with: imageUrl) { [weak self] data, response, error in
            
            guard let self = self else {return}
            if error != nil {return}
            guard let response = response as? HTTPURLResponse ,response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else {return}
    
            self.cache.setObject(image , forKey: cacheKey)
            DispatchQueue.main.async { self.flickerImage.image = image}
            
        }
        task.resume()
    }

    
}
