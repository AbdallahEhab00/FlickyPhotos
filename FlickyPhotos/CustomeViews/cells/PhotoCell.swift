//
//  PhotoCell.swift
//  FlickyPhotos
//
//  Created by Abdallah Ehab on 19/05/2022.
//

import UIKit

class PhotoCell: UITableViewCell {

    @IBOutlet weak var flickerImage: UIImageView!
    
    
    func getImageFromUrl(for urlString:String){
        guard let imageUrl = URL(string: urlString) else { return}

        let task = URLSession.shared.dataTask(with: imageUrl) { [weak self] data, response, error in
            
            guard let self = self else {return}
            if error != nil {return}
            guard let response = response as? HTTPURLResponse ,response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else {return}
    
            DispatchQueue.main.async {  self.flickerImage.image = image }
        }
       
        task.resume()
    }

    
}
