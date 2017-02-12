//
//  EventsTableViewController.swift
//  Euphoria
//
//  Created by Annie Tung on 12/14/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController, UISearchBarDelegate {
    
    
    var eventArr = [Event]()
    let endPoint = "http://api.bandsintown.com/artists/kaskade/events.json?api_version=2.0&app_id=annietuna"
    var searchQuery = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Euphoria"
        lookForInitialEndPoint()
        searchbar()
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
    }
    
    func searchBarSearchButtonClicked(_ sender: UISearchBar) {
//        self.searchQuery = (sender.text?.replacingOccurrences(of: " ", with: ""))!
        getSearchBarResults(queryStr: searchQuery)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
