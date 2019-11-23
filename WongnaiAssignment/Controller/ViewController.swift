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
    private var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        requestData()
        configureRefreshControl()
    }
    
    private func configureRefreshControl() {
        
        tableView.register(UINib(nibName: "HomeViewCell", bundle: nil), forCellReuseIdentifier: "HomeViewCell")
        
        refreshControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc
    private func requestData() {
        
        homeManager.performRequest(page: "1") { [weak self] (data, error) in
            guard let weakSelf = self else {
                return
            }
            
            if let data = data {
                
                weakSelf.photosThisView = data.photos
                
                DispatchQueue.main.async {
                    weakSelf.tableView.reloadData()
                    weakSelf.refreshControl.endRefreshing()
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

