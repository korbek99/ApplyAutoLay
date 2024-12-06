//
//  HitsViewController.swift
//  ApplyAutoLay
//
//  Created by Jose Preatorian on 04-12-24.
//

import UIKit

class HitsViewController: UIViewController {
    
    private let viewModel = HitsViewModel()
    private var refreshControl: UIRefreshControl!
     var routers: RoutingMV?
    
    lazy var tableView: UITableView = {
        let table: UITableView = .init()
        table.delegate = self
        table.dataSource = self
        table.register(HitsTableViewCell.self, forCellReuseIdentifier: "HitsTableViewCell")
        table.rowHeight = 125.0
        table.separatorColor = UIColor.gray
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hits"
        routers = RoutingMV()
        routers?.assignViewController(self)
        setupTableView()
        setupRefreshControl()
        bindViewModel()
        
    }
   
    private func bindViewModel() {
        viewModel.fetchArticules()
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.showError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.showAlert(message: errorMessage)
            }
        }
    
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
 
}

extension HitsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.hits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HitsTableViewCell", for: indexPath) as? HitsTableViewCell else {
            fatalError(NSLocalizedString("TABLE_ERROR_IDENTI", comment: "error message"))
        }
        let hit = viewModel.hits[indexPath.row]
        cell.configure(HitsViewCellModel(name: hit.author ?? NSLocalizedString("HIT_VC_ERROR_AUTOR", comment: "error message"),
                                         title: hit.storyTitle ?? NSLocalizedString("HIT_VC_ERROR_CONTEXT", comment: "error message"), dates: hit.createdAt!))
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.hits.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = viewModel.hits[indexPath.row]
        guard let urlString = selected.storyURL, URL(string: urlString) != nil else {
            print(NSLocalizedString("TABLE_ERROR_URL", comment: "error message"))
            showErrorAlert()
            return
        }
        routers?.goToDetailWeb(with: selected)
    }
}

extension HitsViewController {
    private func setupRefreshControl() {
           refreshControl = UIRefreshControl()
           refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
           tableView.refreshControl = refreshControl
       }
       
       @objc private func refreshData() {
           viewModel.fetchArticules()
           DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
               self.refreshControl.endRefreshing()
           }
       }
    
    private func showAlert(message: String) {
        routers?.goToError(error: message)
    }
    
    private func showErrorAlert() {
        routers?.goToError(error: NSLocalizedString("TABLE_ERROR_URL", comment: "error message"))
    }
}
