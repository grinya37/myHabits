//
//  HabitViewCell.swift
//  MyHabits
//
//  Created by Николай Гринько on 15.03.2023.
//

import UIKit

class HabitViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var stateButton: UIButton!
    
    private var habit: Habit!
    private var onStateBtnClick: (() -> Void)!
    
    let checkedImage = UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysTemplate)
    let uncheckedImage = UIImage(systemName: "circle")?.withRenderingMode(.alwaysTemplate)
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        self.contentView.layer.cornerRadius = 8
        
        // Initialization code
    }
    func setupCell(with habit: Habit, onStateBtnClick: @escaping () -> Void) {
        self.habit = habit
        self.onStateBtnClick = onStateBtnClick
        
        self.titleLabel.text = habit.name
        self.titleLabel.textColor = habit.color
        self.subTitleLabel.text = habit.dateString
        self.counterLabel.text = "Счетчик: \(habit.trackDates.count)"
        
        if habit.isAlreadyTakenToday {
            self.stateButton.setImage(checkedImage, for: .normal)
        } else {
            self.stateButton.setImage(uncheckedImage, for: .normal)
        }
        self.stateButton.tintColor = habit.color
    }
    
    @IBAction private func clickOnStateButton(sender: UIButton) {
        if !habit.isAlreadyTakenToday { self.stateButton.setImage(checkedImage, for: .normal)
            HabitsStore.shared.track(habit)
            self.onStateBtnClick()
        }
    }
}
