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
        fetchData(mediaIndex: sender.selectedSegmentIndex)
    }
    
    func fetchData(mediaIndex: Int) {
        guard let mediaType = MediaType.index(at: mediaIndex) else { return }
        
        modelController.fetchData(mediaType: mediaType) { (error) in
            
        }
    }
}

extension MediaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.reuseID, for: indexPath)
        
        return cell
    }
}
