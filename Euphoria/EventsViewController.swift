//
//  EventsViewController.swift
//  Euphoria
//
//  Created by Annie Tung on 5/1/17.
//  Copyright © 2017 Annie Tung. All rights reserved.
//

import UIKit
import SnapKit

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var tableView: UITableView!
    
    var eventArr = [Event]()
    let endPoint = "http://api.bandsintown.com/artists/kaskade/events.json?api_version=2.0&app_id=annietuna"
    var searchQuery = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupConstraints()
        self.title = "Euphoria"
        lookForInitialEndPoint()
        searchbar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        self.view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 75
        tableView.register(EventsTableTableViewCell.self, forCellReuseIdentifier: EventsTableTableViewCell.identifier)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { (view) in
            view.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func lookForInitialEndPoint() {
        APIRequestManager.manager.getData(endPpoint: endPoint) { (data: Data?) in
            guard let validData = data else { return }
            if let validObject = Event.parseData(data: validData) {
                self.eventArr = validObject
                self.tableView.reloadData()
            }
        }
    }
    
    func getSearchBarResults(queryStr: String) {
        APIRequestManager.manager.getData(endPpoint: "http://api.bandsintown.com/artists/\(searchQuery)/events.json?api_version=2.0&app_id=annietuna") { (data: Data?) in
            guard let validData = data else { return }
            if let validObject = Event.parseData(data: validData) {
                self.eventArr = validObject
                self.tableView.reloadData()
            }
        }
    }
    
    func searchbar() {
        let searchbar = UISearchBar()
        searchbar.delegate = self
        searchbar.showsCancelButton = false
        searchbar.placeholder = "Enter artist name here"
        self.navigationItem.titleView = searchbar

        searchbar.tintColor = .white
        searchbar.barTintColor = UIColor(red:0.56, green:0.62, blue:0.67, alpha:1.0)
        searchbar.layer.borderWidth = 1
        searchbar.layer.borderColor = UIColor(red:0.56, green:0.62, blue:0.67, alpha:1.0).cgColor
        searchbar.searchBarStyle = UISearchBarStyle.default
        searchbar.isUserInteractionEnabled = true
        searchbar.clipsToBounds = true
    }
    
    func searchBarSearchButtonClicked(_ sender: UISearchBar) {
        //self.searchQuery = (sender.text?.replacingOccurrences(of: " ", with: ""))!
        getSearchBarResults(queryStr: searchQuery)
    }
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventsTableTableViewCell.identifier, for: indexPath) as! EventsTableTableViewCell
        
        let event = eventArr[indexPath.row]
        cell.textLabel?.text = event.venueName
        cell.detailTextLabel?.text = event.title
        let thumbnailImg = event.thumbnailURL
        APIRequestManager.manager.getData(endPpoint: thumbnailImg) { (data: Data?) in
            guard let validData = data else { return }
            cell.imageView?.image = UIImage(data: validData)
            cell.setNeedsLayout()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected at index: \(indexPath)")
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
