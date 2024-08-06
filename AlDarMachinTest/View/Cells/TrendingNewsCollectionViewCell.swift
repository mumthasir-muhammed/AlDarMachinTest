//
//  TrendingNewsCollectionViewCell.swift
//  AlDarMachinTest
//
//  Created by Mumthasir VP on 06/08/24.
//

import Foundation
import UIKit

class TrendingNewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configView()
    }
    
    private func configView() {
        self.clipsToBounds = false
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.2
    }
}
