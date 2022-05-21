//
//  PhotoDetailsVC.swift
//  FlickyPhotos
//
//  Created by Abdallah Ehab on 21/05/2022.
//

import UIKit
import SDWebImage

class PhotoDetailsVC: UIViewController {

    @IBOutlet weak var photoMovie: UIImageView!
    @IBOutlet weak var photoDescription: UILabel!
    
    var imageUrl:String = ""
    var imageDescribtion: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        photoDescription.text = imageDescribtion
        photoMovie.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named:"plac"))
    }
    

}
