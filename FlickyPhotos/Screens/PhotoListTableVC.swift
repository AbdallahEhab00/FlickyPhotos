//
//  ViewController.swift
//  FlickyPhotos
//
//  Created by Abdallah Ehab on 19/05/2022.
//

import UIKit

class PhotoListTableVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var photo: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(cell: PhotoCell.self)
        getFlickerPhotos()
    }
   

    private func getFlickerPhotos(){
        NetworkManager.shared.getPhotos { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let photo):
                self.updateTableView(with: photo)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateTableView(with photo : [Photo]){
        DispatchQueue.main.async {
            self.photo = photo
            self.tableView.reloadData()
        }
       
    }

}

extension PhotoListTableVC: UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photo.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as PhotoCell
        cell.getImageFromUrl(for: configureImageData(indexPath: indexPath) )
        return cell
    }
    
    
    func configureImageData(indexPath:IndexPath)->String{
        let farm     = photo[indexPath.row].farm
        let server   = photo[indexPath.row].server
        let id       = photo[indexPath.row].id
        let secret   = photo[indexPath.row].secret
        let imageUrl = "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
        
        return imageUrl
    }
}
