//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Fulvio A. Moya on 25/6/23.
//

import UIKit

class ViewController: UIViewController {
    
    //TODO: Check this if exists a best practice to manage this reusableCellIdentifier name
    private static let cellIdentifier = "mi_celda"
    
    var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        self.view.backgroundColor = .green
        
        setupTableView(to: self.view)
    }
    
    private func setupTableView(to parent: UIView){
        //
        tableView.dataSource = self
        
        // Activate constraints directly
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: parent.topAnchor, constant: 32*2),
            tableView.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -16),
        ])
    }
}

// - UITableViewDataSource
extension ViewController : UITableViewDataSource {
    
    tableviewde
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 // TODO: change this hardcore number.
    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        return setupDefaulTemporallyCell(for: indexPath)
    }
    
    
    fileprivate func setupDefaulTemporallyCell(for indexPath: IndexPath) -> UITableViewCell {
        //TODO: Change to custom cell
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 350
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: ViewController.cellIdentifier)
        var contentConfig = UIListContentConfiguration.cell()
        contentConfig.text = "celda \(indexPath.row)"
        cell.contentConfiguration = contentConfig
        
        return cell
    }
}
