//
//  ViewController.swift
//  WongnaiAssignment
//
//  Created by Nuan on 21/11/2562 BE.
//  Copyright © 2562 Hathairat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var homeManager = HomeManager()
    private var photosThisView = [Photos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        requestData()
        
        tableView.register(UINib(nibName: "HomeViewCell", bundle: nil), forCellReuseIdentifier: "HomeViewCell")
    }
    @objc
    private func requestData() {
        
        homeManager.performRequest(page: "1") { [weak self] (data, error) in
            guard let weakSelf = self else {
                return
            }
            
            if let data = data {
                
                weakSelf.photosThisView = data.photos
//                debugPrint(weakSelf.photosThisView)
                
                DispatchQueue.main.async {
                    weakSelf.tableView.reloadData()
                }
                
            } else {
                print(error!)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return photosThisView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewCell") as! HomeTableViewCell
        
        let photo = photosThisView[indexPath.row]
        cell.productLabel.text = photo.name
        cell.descriptionLabel.text = photo.description
        cell.voteLabel.text = photo.positiveVotesCount.withCommas()
        cell.productImage.performImageRequest(imageUrl: photo.imageUrl?[0])
        
        return cell
        
    }
    
}
extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

