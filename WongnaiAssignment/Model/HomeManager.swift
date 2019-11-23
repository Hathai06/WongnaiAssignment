//
//  HomeManager.swift
//  WongnaiAssignment
//
//  Created by Nuan on 21/11/2562 BE.
//  Copyright © 2562 Hathairat. All rights reserved.
//

import Foundation
struct HomeManager {
    
    let homeUrl = "https://api.500px.com/v1/photos?feature=popular&page=1"
    
    func performRequest(page: String = "1",completion: @escaping(HomeData?, Error?)->()) {
        
        if let url = URL(string: homeUrl) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error)
                in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJson(data: safeData, completion: completion)
                }
            }
            task.resume()
        }
    }
    
    func parseJson(data: Data?,completion: @escaping(HomeData?, Error?)->()) {
        
        var decodeData: HomeData?
        var error: Error?
        
        guard let homeData = data else {
            return
        }
        
        do {
            decodeData = try JSONDecoder().decode(HomeData.self, from: homeData)
            
        } catch let err {
            error = err
            debugPrint(err)
        }
        
        completion(decodeData, error)
    }
}
