//
//  ViewController.swift
//  GPitunesApp
//
//  Created by gnoa001 on 3/3/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import UIKit

class MediaViewController: UIViewController {
    
    var modelController = MediaModelController()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 56
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MediaTableViewCell.self, forCellReuseIdentifier: MediaTableViewCell.reuseID)
        return tableView
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: MediaType.allTypes)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        return segmentedControl
    }()

    var selectedMediaType: MediaType? {
        return MediaType.index(at: segmentedControl.selectedSegmentIndex)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchData()
    }
    
    func setupUI() {
        navigationItem.titleView = segmentedControl
        
        view.addSubview(tableView)
        view.addConstraints([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    @objc func indexChanged() {
        fetchData()
    }
    
    func fetchData() {
        guard let mediaType = selectedMediaType else { return }
        
        self.tableView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.tableView.alpha = 0.5
        }
        
        modelController.fetchData(mediaType: mediaType) { (error) in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    self.tableView.alpha = 1.0
                }
                
                self.tableView.isUserInteractionEnabled = true
                self.tableView.reloadSections(IndexSet(integer:0), with: .fade)
            }
        }
    }
}

extension MediaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mediaType = selectedMediaType else { return 0 }
        
        return modelController.count(for: mediaType)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.reuseID, for: indexPath) as! MediaTableViewCell
        
        let item = modelController.mediaItem(for: selectedMediaType, at: indexPath.row)
        cell.configure(item)
        
        return cell
    }
}
