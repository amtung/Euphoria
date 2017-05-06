//
//  EventsCollectionViewCell.swift
//  Euphoria
//
//  Created by Annie Tung on 4/26/17.
//  Copyright © 2017 Annie Tung. All rights reserved.
//

import UIKit
import SnapKit

class EventsCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "collectionViewCell"
    var artistName: UILabel!
    var artistImage: UIImageView!
    
    var event: Event? {
        didSet {
            self.setupCell()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        if let event = event {
            
            artistImage = UIImageView(frame:CGRect(x: 0, y: 0, width: 250, height: 500))
            artistImage.contentMode = .scaleAspectFit
            
            if let url = URL(string: event.fullImageURL) {
                if let data = try? Data(contentsOf: url) {
                artistImage.image = UIImage(data: data)
                }
            }
            artistName = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height/3))
            artistName.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
            artistName.textAlignment = .center
            
            artistName.text = event.artistName
            
            self.addSubview(artistName)
            self.addSubview(artistImage)
        }
        else
        {
            artistImage.image = nil
            artistName.text = nil
        }
    }
}
