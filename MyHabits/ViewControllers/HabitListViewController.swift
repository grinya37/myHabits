//
//  HabitListViewController.swift
//  MyHabits
//
//  Created by Николай Гринько on 15.03.2023.
//

import UIKit

private let cellID = "HabitViewCell"
private let headerID = "HeaderHabitView"


class HabitListViewController: UIViewController {

    private var collectionView: UICollectionView!
    private var store = HabitsStore.shared
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    override func loadView() {
        let screenSize = UIScreen.main.bounds
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 12, left: 16, bottom: 0, right: 16)
        layout.headerReferenceSize = CGSize(width: screenSize.width, height: 60)
        layout.itemSize = CGSize(width: screenSize.width - 32, height: 130)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.view = collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavController()
    
        
        store.habits.removeAll()
        store.habits.append(Habit(name: "Погладить кота", date: Date(), color: .purple ))
        
            }
    func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(named: "dBackground")
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
    let cellNib = UINib(nibName: cellID, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: cellID)
    let headerNib = UINib(nibName: headerID, bundle: nil)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
    }
    func setupNavController() {
        self.navigationItem.title = "сегодня"
        self.navigationController?.navigationBar.tintColor = UIColor(named: "dPurple")
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToCreateHabit(_:)))
    }
    
    @objc func goToCreateHabit(_ sender: UIButton) {
        let vc = HabitViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    
}


extension HabitListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HabitDetailViewController()
        vc.habit = store.habits[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        store.habits.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)  as! HabitViewCell
        cell.setupCell(with: store.habits[indexPath.item]) {
            self.collectionView.reloadData()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! HeaderHabitView
        header.setProgress(with: store.todayProgress)
        return header
    }
}
