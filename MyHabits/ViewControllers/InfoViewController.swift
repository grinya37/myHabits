//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Николай Гринько on 15.03.2023.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Информация"


        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        let firstString = NSAttributedString(string: "Привычка за 21 день\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold),
            NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let secondString = NSAttributedString(string: """
Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:

1. Провести 1 день без обращения
к старым привычкам, стараться вести себя так, как будто цель, загаданная
в перспективу, находится на расстоянии шага.

2. Выдержать 2 дня в прежнем состоянии самоконтроля.

3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче,
с чем еще предстоит серьезно бороться.

4. Поздравить себя с прохождением первого серьезного порога в 21 день.
За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.

5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.

6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.

""", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
                  NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let result = NSMutableAttributedString()
        result.append(firstString)
        result.append(secondString)
        
        
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.attributedText = result
        tv.textAlignment = .left
        
        self.view.addSubview(tv)
        
        tv.textContainerInset = UIEdgeInsets(top: 22, left: 16, bottom: 0, right: 16)
        
        
        NSLayoutConstraint.activate([
        
            tv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tv.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tv.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tv.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    

    

}
