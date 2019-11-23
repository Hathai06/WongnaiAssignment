//
//  Extension.swift
//  WongnaiAssignment
//
//  Created by Nuan on 22/11/2562 BE.
//  Copyright © 2562 Hathairat. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func performImageRequest(imageUrl: String?) {
        
        guard let imageUrl = imageUrl else {
            return
        }
        
        if let url = URL(string: imageUrl) {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error)
                in
                guard error == nil else {
                    print(error!)
                    return
                }
                
                guard response != nil else {
                    print("no response")
                    return
                }
                
                guard let data = data else {
                    print("no data")
                    return
                }
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            task.resume()
        }
    }
}
