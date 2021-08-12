//
//  ViewController.swift
//  NewsFeed
//
//  Created by Vishwanath on 11/08/21.
//

import UIKit

class ViewController: UIViewController {
    
    let cellId = "cellId"
    var rowsTableView = UITableView()
    var safeArea: UILayoutGuide!
    var articlesVM: ArticlesViewModel?
    
    var navTitle: String = "" {
        didSet {
            updateNavTitle()
        }
    }
    
    func updateNavTitle() {
        navigationItem.title = navTitle
    }
    
    override func loadView() {
        super.loadView()
        articlesVM = ArticlesViewModel()
        setupTableView()
        articlesVM?.vc = self
        articlesVM?.getRowsInfoFromAPI()
        self.title = "World News Feed"
        let backBarBtn = UIBarButtonItem()
        backBarBtn.title = "Back"
        navigationItem.backBarButtonItem = backBarBtn
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshButtonClicked))
    }
    
    @objc func refreshButtonClicked() {
        articlesVM?.articleArray = [Articles]()
        articlesVM?.getRowsInfoFromAPI()
    }
    
    private func setupTableView() {
        view.addSubview(rowsTableView)
        rowsTableView.translatesAutoresizingMaskIntoConstraints = false
        rowsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        rowsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rowsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        rowsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        rowsTableView.dataSource = self
        rowsTableView.delegate = self
        rowsTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articlesVM?.articleArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard var cell = tableView.dequeueReusableCell(withIdentifier: cellId) else {
            return UITableViewCell()
        }
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let rowModel = articlesVM?.articleArray[indexPath.row]
        cell.textLabel?.text = rowModel?.title
        cell.detailTextLabel?.text = rowModel?.publishedAt
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
}

extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "detailView") as? DetailNewsViewController {
            detailVC.article = articlesVM?.articleArray[indexPath.row]
            self.navigationController?.pushViewController(detailVC, animated: false)
        }
    }
}

