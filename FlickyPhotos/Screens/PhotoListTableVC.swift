//
//  ViewController.swift
//  FlickyPhotos
//
//  Created by Abdallah Ehab on 19/05/2022.
//

import UIKit

class PhotoListTableVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var photo: [Photo]      = []
    var pagination: [Photo] = []
    var page                = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(cell: PhotoCell.self)
        tableView.registerNib(cell: AdCell.self)
        getFlickerPhotos(page: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false

    }
   

    private func getFlickerPhotos(page:Int){
        showLoadingView()
        NetworkManager.shared.getPhotos(page: page) { [weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            switch result {
            case .success(let photo):
                self.pagination.append(contentsOf: photo)
                self.updateTableView(with: self.pagination)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorAlertMessage(with: error.rawValue)

                }
            }
        }
    }
    
    func updateTableView(with photo : [Photo]){
        DispatchQueue.main.async {
            self.photo = photo
            self.tableView.reloadData()
        }
       
    }
    
    func errorAlertMessage(with message:String){
        let alert = UIAlertController(title: "Somthing Wrong", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true,completion: nil)
    }

}

extension PhotoListTableVC: UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pagination.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if (indexPath.row % 6 == 0) {
            let cell = tableView.dequeue() as AdCell
            return cell
        } else {
            let cell = tableView.dequeue() as PhotoCell
            cell.getImageFromUrl(for: configureImageData(indexPath: indexPath) )
            return cell
            
        }
    }
    
    
    func configureImageData(indexPath:IndexPath)->String{
        var farm     = pagination[indexPath.row].farm
        let server   = pagination[indexPath.row].server
        let id       = pagination[indexPath.row].id
        let secret   = pagination[indexPath.row].secret
        if farm == 0 {farm = 66}
        let imageUrl = "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
        
        return imageUrl
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.height
        
        if offsetY > contentHeight-height {
            page += 1
            getFlickerPhotos(page: page)
        }
            
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let PhotoDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoDetailsVC") as! PhotoDetailsVC
        let AdViewController = self.storyboard?.instantiateViewController(withIdentifier: "AdViewController") as! AdViewController
        if (indexPath.row % 6 == 0) {
            navigationController?.pushViewController(AdViewController, animated: true)

        } else {
            
            PhotoDetailsVC.imageUrl          = configureImageData(indexPath: indexPath)
            PhotoDetailsVC.imageDescribtion  = pagination[indexPath.row].title
            navigationController?.pushViewController(PhotoDetailsVC, animated: true)

        }
        
    }
    
}
