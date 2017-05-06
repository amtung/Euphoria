//
//  HomeViewController.swift
//  Euphoria
//
//  Created by Annie Tung on 4/26/17.
//  Copyright © 2017 Annie Tung. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    var eventArr = [Event]()
    let endPoint = "http://api.bandsintown.com/artists/kaskade/events.json?api_version=2.0&app_id=annietuna"
    let scalingOfCell: CGFloat = 0.8
    let screenSize = UIScreen.main.bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .purple
        setupCollectionView()
        setupConstraints()
        collectionView.dataSource = self
        collectionView.delegate = self
        lookForInitialEndPoint()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollectionView() {
        // calculate padding
        let cellWidth = floor(screenSize.width * scalingOfCell)
        let cellHeight = floor(screenSize.height * scalingOfCell)
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellHeight) / 2.0
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        collectionView.register(EventsCollectionViewCell.self, forCellWithReuseIdentifier: EventsCollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        
        collectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { (view) in
            view.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func lookForInitialEndPoint() {
        APIRequestManager.manager.getData(endPpoint: endPoint) { (data: Data?) in
            guard let validData = data else { return }
            if let validObject = Event.parseData(data: validData) {
                self.eventArr = validObject
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - CollectionView
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventsCollectionViewCell.identifier, for: indexPath as IndexPath) as! EventsCollectionViewCell
        cell.event = eventArr[indexPath.row]
        return cell
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
