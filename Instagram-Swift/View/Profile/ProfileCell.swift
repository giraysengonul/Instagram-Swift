//
//  ProfileCell.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 1.09.2022.
//

import UIKit
import SDWebImage
class ProfileCell: UICollectionViewCell{
    // MARK: - Properties
    var viewModel: PostViewModel? {
        didSet{ configure() }
    }
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        let image = #imageLiteral(resourceName: "venom-7")
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        imageView.clipsToBounds = true
        return imageView
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
// MARK: - Helpers
extension ProfileCell{
    private func style(){
        //imageView Style
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
    }
    private func layout(){
        //imageView Layout
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    private func configure(){
        guard let viewModel = viewModel else { return }
        imageView.sd_setImage(with: viewModel.imageUrl)
    }
}
