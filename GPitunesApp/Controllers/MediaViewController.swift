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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MediaTableViewCell.self, forCellReuseIdentifier: MediaTableViewCell.reuseID)
        return tableView
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: MediaType.allTypes)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(indexChanged(sender:)), for: .valueChanged)
        return segmentedControl
    }()

    var selectedMediaType: MediaType? {
        return MediaType.index(at: segmentedControl.selectedSegmentIndex)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        fetchData(mediaType: segmentedControl.selectedSegmentIndex)
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
    
    @objc func indexChanged(sender: UISegmentedControl) {
        fetchData(mediaType: sender.selectedSegmentIndex)
    }
    
    func fetchData(mediaType: Int) {
        guard let mediaType = MediaType.index(at: mediaType) else { return }
        
        modelController.fetchData(mediaType: mediaType) { (error) in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
            
            DispatchQueue.main.async {
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
        
        let item = modelController.index(mediaType: selectedMediaType, at: indexPath.row)
        cell.configure(item)
        
        return cell
    }
}
