//
//  UITableView+ext.swift
//  FlickyPhotos
//
//  Created by Abdallah Ehab on 19/05/2022.
//

import UIKit

extension UITableView{
    
    
    func registerNib<Cell:UITableViewCell>(cell:Cell.Type){
        
        let nibName = String(describing: Cell.self)
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    
    func dequeue<Cell:UITableViewCell>()->Cell{
        let identifier = String(describing:Cell.self)
        
        guard let cell = dequeueReusableCell(withIdentifier:identifier) as? Cell else {
            fatalError("Error in Cell")
        }
        
        return cell
    }
    
    
}
