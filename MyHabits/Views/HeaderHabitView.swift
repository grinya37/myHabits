//
//  CollectionReusableView.swift
//  MyHabits
//
//  Created by Николай Гринько on 15.03.2023.
//

import UIKit

class HeaderHabitView: UICollectionReusableView {

    @IBOutlet private weak var procentLabel: UILabel!
    @IBOutlet private weak var progressView: UIProgressView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
    }
    
    func setProgress(with value: Float) {
        self.procentLabel.text = "\(value * 100)%"
        self.progressView.setProgress(value, animated: true)
    }
    
}
