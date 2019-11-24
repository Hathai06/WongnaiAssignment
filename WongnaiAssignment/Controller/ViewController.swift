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
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestData()
        configureTableControl()
    }
    
    private func configureTableControl() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HomeViewCell", bundle: nil), forCellReuseIdentifier: "HomeViewCell")
        
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func reload () {
        photosThisView.removeAll()
        requestData()
    }
    
    @objc
    private func requestData(x: String = "1") {
        homeManager.performRequest(page: x) { [weak self] (data, error) in
            
            guard let weakSelf = self else {
                return
            }
            
            if let data = data {
                
                weakSelf.photosThisView.append(contentsOf: data.photos)
                
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == photosThisView.count - 1 {
            
            currentPage = currentPage + 1
            let spinner = UIActivityIndicatorView()
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
            requestData(x: String(currentPage))
        }
    }
    
}
