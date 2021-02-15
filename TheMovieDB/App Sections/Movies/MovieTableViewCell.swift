//
//  MovieTableViewCell.swift
//  MovieDatabase
//
//  Created by Mattia on 10/02/21.
//

import UIKit
import SnapKit
import SDWebImage

class MovieTableViewCell: UITableViewCell, DequeueableCell {
    
    // MARK: - Views
    
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepare()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepare()
    }
    
    /// When we reuse the cell we need to cancel pending image loads.
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.sd_cancelCurrentImageLoad()
    }
    
    // MARK: - Prepare UI
    
    private func prepare() {
        backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        selectionStyle = .none
        
        prepareImage()
        prepareTitle()
    }
    
    private func prepareImage() {
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        
        posterImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.45)
        }
    }
    
    private func prepareTitle() {
        titleLabel.font = .systemFont(ofSize: 17)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.trailing.bottom.lessThanOrEqualTo(-16)
        }
    }
    
    /// Sets up the cell with the passed movie, if the movie has image data associated with it, we load that, otherwise we load it from the internet
    ///
    /// - Parameter movie: the movie to display
    func setup(with movie: Movie) {
        titleLabel.text = movie.title
        posterImageView.sd_setImage(with: movie.bannerUrl)
    }
    
}
