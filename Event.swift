//
//  Event.swift
//  Euphoria
//
//  Created by Annie Tung on 12/14/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import Foundation

class Event {
    let id: Int
    let artistEventID: Int
    let title: String
    let formattedDatetime: String
    let formattedLocation: String
    let ticketUrl: String
    let ticketStatus: String
    let onSaleDatetime: String
    let facebookRSVPurl: String
    let description: String
    let artistName: String
    let thumbnailURL: String
    let fullImageURL: String
    let facebookTourPage: String
    let facebookPageURL: String
    let website: String
    let venueName: String
    let venueCity: String
    let venueRegion: String
    let venueCountry: String
    
    init(id: Int, artistEventID: Int, title: String, formattedDatetime: String, formattedLocation: String, ticketUrl: String, ticketStatus: String, onSaleDatetime: String, facebookRSVPurl: String, description: String, artistName: String, thumbnailURL: String, fullImageURL: String, facebookTourPage: String, facebookPageURL: String, website: String, venueName: String, venueCity: String, venueRegion: String, venueCountry: String) {
        self.id = id
        self.artistEventID = artistEventID
        self.title = title
        self.formattedDatetime = formattedDatetime
        self.formattedLocation = formattedLocation
        self.ticketUrl = ticketUrl
        self.ticketStatus = ticketStatus
        self.onSaleDatetime = onSaleDatetime
        self.facebookRSVPurl = facebookRSVPurl
        self.description = description
        self.artistName = artistName
        self.thumbnailURL = thumbnailURL
        self.fullImageURL = fullImageURL
        self.facebookTourPage = facebookTourPage
        self.facebookPageURL = facebookPageURL
        self.website = website
        self.venueName = venueName
        self.venueCity = venueCity
        self.venueRegion = venueRegion
        self.venueCountry = venueCountry
    }
    
    static func parseData(data: Data) -> [Event]? {
        var arrOfArtists: [Event] = []
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] {
                
                for jsonDict in json {
                    guard
                        let ID = jsonDict["id"] as? Int,
                        let artistEventID = jsonDict["artist_event_id"] as? Int,
                        let title = jsonDict["title"] as? String,
                        let formattedDatetime = jsonDict["formatted_datetime"] as? String,
                        let formattedLocation = jsonDict["formatted_location"] as? String,
                        let ticketStatus = jsonDict["ticket_status"] as? String,
                        let facebookRSVPurl = jsonDict["facebook_rsvp_url"] as? String else {
                            print("Error parsing jsondict objects")
                            return nil
                    }
                    let ticketUrl = jsonDict["ticket_url"] as? String ?? "No tickets available at this time"
                    let description = jsonDict["description"] as? String ?? "No description available"
                    let onSaleDatetime = jsonDict["on_sale_datetime"] as? String ?? "Not available yet"
                    guard let venue = jsonDict["venue"] as? [String:Any] else {
                        print("Error casting venue at top layer")
                        return nil
                    }
                    guard let venueName = venue["name"] as? String,
                        let venueCity = venue["city"] as? String,
                        let venueRegion = venue["region"] as? String,
                        let venueCountry = venue["country"] as? String else {
                            print("Error parsing venue objects")
                            return nil
                    }
                    guard let artists = jsonDict["artists"] as? [[String:Any]] else {
                        print("Error casting artists at top layer")
                        return nil
                    }
                    for artist in artists {
                        guard
                            let artistName = artist["name"] as? String,
                            let thumbnailURL = artist["thumb_url"] as? String,
                            let fullImageURL = artist["image_url"] as? String else {
                                print("Error parsing artist objects")
                                return nil
                        }
                        let website = artist["website"] as? String ?? "No website page available"
                        let facebookPageURL = artist["facebook_page_url"] as? String ?? "No facebook page available"
                        let facebookTourPage = artist["facebook_tour_dates_url"] as? String ?? "No Facebook tour dates URL available at the moment"
                        
                        let eventObject = Event(id: ID, artistEventID: artistEventID, title: title, formattedDatetime: formattedDatetime, formattedLocation: formattedLocation, ticketUrl: ticketUrl, ticketStatus: ticketStatus, onSaleDatetime: onSaleDatetime, facebookRSVPurl: facebookRSVPurl, description: description, artistName: artistName, thumbnailURL: thumbnailURL, fullImageURL: fullImageURL, facebookTourPage: facebookTourPage, facebookPageURL: facebookPageURL, website: website, venueName: venueName, venueCity: venueCity, venueRegion: venueRegion, venueCountry: venueCountry)
                        arrOfArtists.append(eventObject)
//                        dump(arrOfArtists)
                    }
                }
            }
        }
        catch {
            print("Error parsing data: \(error)")
            return nil
        }
        return arrOfArtists
    }
}












