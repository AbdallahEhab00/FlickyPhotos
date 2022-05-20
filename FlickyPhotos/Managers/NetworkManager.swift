//
//  NetworkManager.swift
//  FlickyPhotos
//
//  Created by Abdallah Ehab on 19/05/2022.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private init(){}
    
    let basUrl = "https://www.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=50&text=Color&"
    let apiKey = "&api_key=d17378e37e555ebef55ab86c4180e8dc"
    
    
    private func createRequest(url:URL?,completion:(URLRequest)->Void){
        guard let apiUrl = url else{ return }
        let request = URLRequest(url: apiUrl)
        completion(request)
    }
    
    
    public func getPhotos(completion:@escaping(Result<[Photo],FLICKError>)->Void){
        
        createRequest(url:URL(string: basUrl+"page=1&per_page=20"+apiKey)) { request in
            
            let task = URLSession.shared.dataTask(with: request) { data, response , error in
                if let _ = error {
                    completion(.failure(.unableToComplete))
                    return
                }
                guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                do
                {
                    let result = try JSONDecoder().decode(PhotosModel.self, from: data)
                    completion(.success(result.photos.photo))
                }catch{
                    completion(.failure(.invalidData))
                }
                
            }
            task.resume()
        }
    }
    
   
}
