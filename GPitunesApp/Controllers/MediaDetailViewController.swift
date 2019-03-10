//
//  MediaDetailViewController.swift
//  GPitunesApp
//
//  Created by gnoa001 on 3/9/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import UIKit

class MediaDetailViewController: UIViewController {
    
    private lazy var mediaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
    private lazy var mediaTypeLabel: UILabel = {
       let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, mediaTypeLabel,mediaImageView])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    init(_ mediaItem: MediaItem, mediaImage: UIImage) {
        super.init(nibName: nil, bundle: nil)
        
        mediaImageView.image = mediaImage
        titleLabel.text = mediaItem.title
        mediaTypeLabel.text = mediaItem.mediaType.rawValue
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
    }
}
