//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Николай Гринько on 16.03.2023.
//

import UIKit


    enum HabitVCState {
        case create, edit
    }
    
    class HabitViewController: UIViewController {
        var habit: Habit?
        var habitState: HabitVCState = .create
        var guide: UILayoutGuide!
        private var titleLabel: UILabel!
        private var titleTF: UITextField!
        private var colorBtnLabel: UILabel!
        private var colorBtn: UIButton!
        private var dateLabel: UILabel!
        private var datePickerLabel: UILabel!
        private var datePicker: UIDatePicker!
        private var deleteHabitBtn: UIButton!
        
        private var currentTitle: String = ""
        private var currentColor: UIColor = .orange
        private var currentDate: Date = Date()
        
        private let picker = UIColorPickerViewController()
    
        
        let img = UIImage(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))!.withRenderingMode(.alwaysTemplate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "dBackground")
        
        if let habit{
            currentDate = habit.date
            currentColor = habit.color
            currentTitle = habit.name
        }
        
        setupView()
        setupNavigationController()
        
    }
        
        func setupNavigationController() {
            self.navigationItem.largeTitleDisplayMode = .never
            self.navigationItem.hidesBackButton = true
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(goBack(_:)))
            self.navigationItem.title = self.habitState == .create ? "Создать" : "Править"
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cохранить", style: .plain, target: self, action: #selector(saveHabit(_:)))
        }
        
        
        func setupView() {
            guide = view.safeAreaLayoutGuide
            self.picker.delegate = self
            self.picker.selectedColor = currentColor
            createTitleLabel()
            createTitleTF()
            createColorBtnLabel()
            createColorBtn()
            createDateLabel()
            createDatePickerLabel()
            createDatePicker()
            if habitState == .edit {
                createDeleteButton()
            }
            
        }
        
        @objc func goBack(_ sender: UIBarButtonItem) {
            self.navigationController?.popViewController(animated: true)
        }
        
        @objc func saveHabit(_ sender: UIBarButtonItem) {
            if self.habitState == .create {
                HabitsStore.shared.habits.append(Habit(name: currentTitle, date: currentDate, color: currentColor)
                )
                self.navigationController?.popViewController(animated: true)
            } else {
                let h = HabitsStore.shared.habits.first {
                    $0 == habit
                }
                if let h {
                    h.name = currentTitle
                    h.date = currentDate
                    h.color = currentColor
                }
                let vcs = self.navigationController!.viewControllers
                self.navigationController?.popToViewController(vcs[vcs.count - 3], animated: true)
            }
        }
        
}

extension HabitViewController: UITextFieldDelegate {
    
    func createTitleLabel() {
        titleLabel = UILabel()
        self.view.addSubview(titleLabel)
        titleLabel.text = "Название"
        titleLabel.font = titleLabel.font.withSize(13)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 21),
            titleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16)
        ])
        
    }
    
    func createTitleTF() {
        titleTF = UITextField()
        titleTF.translatesAutoresizingMaskIntoConstraints = false
        titleTF.placeholder = "Бегать по утру, ходить на учебу"
        titleTF.text = currentTitle
        titleTF.delegate = self
        self.view.addSubview(titleTF)
        
        NSLayoutConstraint.activate([
            titleTF.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            titleTF.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 15),
            titleTF.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: 15)
        ])
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.currentTitle = textField.text ?? ""
        
    }
    
    func createColorBtnLabel() {
        colorBtnLabel = UILabel()
        colorBtnLabel.text = "Цвет"
        colorBtnLabel.font = colorBtnLabel.font.withSize(13)
        colorBtnLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(colorBtnLabel)
        
        NSLayoutConstraint.activate([
            colorBtnLabel.topAnchor.constraint(equalTo: titleTF.topAnchor, constant: 30),
            colorBtnLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16)
        ])
    }
    
    func createColorBtn() {
        
        colorBtn = UIButton()
        colorBtn.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(colorBtn)
        colorBtn.setImage(img, for: .normal)
        colorBtn.tintColor = currentColor
        colorBtn.addTarget(self, action: #selector(showPicker(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            colorBtn.topAnchor.constraint(equalTo: colorBtnLabel.bottomAnchor, constant: 20),
            colorBtn.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16)
            
        ])
        
    }
    
    @objc func showPicker(_ sender: UIButton) {
        self.present(picker, animated: true)
    }
    
    func createDateLabel() {
        dateLabel = UILabel()
        dateLabel.text = "Время"
        dateLabel.font = dateLabel.font.withSize(13)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: colorBtn.topAnchor, constant: 40),
            dateLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16)
        ])
    }
    
    func createDatePickerLabel() {
        datePickerLabel = UILabel()
        let dateString = currentDate.formatted(date: .omitted, time: .shortened)
        setTextDatePickerLabel(with: dateString)
        datePickerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(datePickerLabel)
        
        NSLayoutConstraint.activate([
            datePickerLabel.topAnchor.constraint(equalTo: colorBtn.topAnchor, constant: 60),
            datePickerLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16)
        ])
    }
    
    func setTextDatePickerLabel(with value: String) {
        let mutableString = NSMutableAttributedString(string: "Каждый день в \(value)")
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "dPurple")! , range: NSRange(location: 12, length: value.count + 2))
        self.datePickerLabel.attributedText = mutableString
    }
    
    func createDatePicker() {
        datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        datePicker.addTarget(self, action: #selector(setCurrentTime(_:)), for: .valueChanged)
        self.view.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: datePickerLabel.bottomAnchor, constant: 25),
            datePicker.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: guide.trailingAnchor)
        ])
    }
    
    @objc func setCurrentTime(_ sender: UIDatePicker) {
        self.currentDate = sender.date
        setTextDatePickerLabel(with: sender.date.formatted(date: .omitted, time: .shortened))
    }
    
    func createDeleteButton() {
        deleteHabitBtn = UIButton()
        deleteHabitBtn.translatesAutoresizingMaskIntoConstraints = false
        deleteHabitBtn.setTitle("Удалить привычку", for: .normal)
        deleteHabitBtn.setTitleColor(.red, for: .normal)
        deleteHabitBtn.addTarget(self, action: #selector(showAlertVC(_:)), for: .touchUpInside)
        
        self.view.addSubview(deleteHabitBtn)
        
        NSLayoutConstraint.activate([
            deleteHabitBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            deleteHabitBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40)
        ])
    }
    
    @objc func showAlertVC(_ sender: UIButton) {
        let vc = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \(habit!.name)", preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        vc.addAction(UIAlertAction(title: "Удалить", style: .destructive) {_ in HabitsStore.shared.habits.removeAll {
            $0 == self.habit
        }
            let vcs = self.navigationController!.viewControllers
            self.navigationController?.popToViewController(vcs[vcs.count-3], animated: true)
        })
        
        self.present(vc, animated: true)
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
       // self.colorBtn.tintColor = currentColor
        dismiss(animated: true)
    }
    
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        colorBtn.tintColor = currentColor
        self.currentColor = color
    }
}
