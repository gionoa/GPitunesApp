//
//  MediaTableViewCell.swift
//  GPitunesApp
//
//  Created by gnoa001 on 3/3/19.
//  Copyright © 2019 Giovanni Noa. All rights reserved.
//

import UIKit
import SDWebImage

class MediaTableViewCell: UITableViewCell {
    
    static let reuseID = String(describing: MediaTableViewCell.self)
    
    private lazy var mediaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()

    private lazy var mediaTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.adjustsFontForContentSizeCategory = true
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, mediaTypeLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(mediaImageView)
        contentView.addSubview(stackView)
        
        let inset: CGFloat = 16.0
        contentView.addConstraints([
            mediaImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            mediaImageView.widthAnchor.constraint(equalToConstant: 64.0),
            mediaImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            mediaImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.leadingAnchor.constraint(equalTo: mediaImageView.trailingAnchor, constant: (inset - 4)),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
            ])
    }
    
    func configure(_ mediaItem: MediaItem?) {
        guard let mediaItem = mediaItem else { return }
        
        let url = URL(string: mediaItem.imageURL)
        mediaImageView.sd_setImage(with: url)
        
        titleLabel.text = mediaItem.title
        mediaTypeLabel.text = mediaItem.mediaType.rawValue
        
        contentView.layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        mediaImageView.image = nil
        mediaImageView.sd_cancelCurrentImageLoad()
    }
    
}
