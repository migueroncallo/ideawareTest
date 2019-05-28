//
//  ViewController.swift
//  Ideaware Test
//
//  Created by Miguel Roncallo on 5/27/19.
//  Copyright © 2019 Miguel Roncallo. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SafariServices

class ViewController: UIViewController, NVActivityIndicatorViewable {
    
    //MARK: - Variables
    @IBOutlet weak var tableView: UITableView!
    
    var posts : [Post] = []
    var page = 1
    private let refreshControl = UIRefreshControl()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        refreshControl.addTarget(self, action: #selector(refreshPostsData(_:)), for: .valueChanged)
        configureTableView()
        loadData()
    }
    
    //MARK: - Internal Helpers
    
    func loadData(){
        tableView.isHidden = true
        startAnimating(message: "Loading", type: NVActivityIndicatorType.ballBeat)
        MainAPI.shared.getPosts(page: page) { (posts, error) in
            self.stopAnimating()
            self.refreshControl.endRefreshing()
            if error != nil{
                print(error!)
            }else{
                self.tableView.isHidden = false
                if self.page > 1{
                    self.posts.append(contentsOf: posts!)
                }else{
                    self.posts = posts!
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func configureTableView(){
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: MainViewTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MainViewTableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 73
    }
    
    @objc private func refreshPostsData(_ sender: Any) {
        page = 1
        loadData()
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let link = self.posts[indexPath.row].link!
        if let url = URL(string: link) {
            let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            vc.delegate = self
            
            present(vc, animated: true)
        }
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MainViewTableViewCell.self)) as! MainViewTableViewCell
        
        cell.configure(post: posts[indexPath.row])
        
        if indexPath.row == posts.count - 1{
            page += 1
            self.loadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: SFSafariViewControllerDelegate{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}
