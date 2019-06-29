//
//  TMDbAPI.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/27/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import Foundation

//MARK: -
enum TMDbAPI {
    //MARK: Genres
    case allGenres
    
    //MARK: Movies
    case inTheaters(page: Int)
    case upcomingMovies(page: Int)
    case movieDetails(movieID: Int, appendToResponse: String)
    
    //MARK: Search
    case searchMovies(searchTerm: String, page: Int)
}

//MARK: -
extension TMDbAPI: EndPointType {
    var apiClientKey: String? {
        return "1f54bd990f1cdfb230adb312546d765d"
    }
    
    var apiClientSecret: String? {
        return nil
    }
    
    var baseURLString : String {
        return "https://api.themoviedb.org/3/"
    }
    
    var baseURL: URL {
        guard let url = URL(string: baseURLString) else {
            fatalError("baseURL could not be configured.")}
        return url
    }
    
    //MARK: -
    var path: String {
        switch self {
        //MARK: Genres
        case .allGenres:
            return "genre/movie/list"
            
        //MARK: Movies
        case .inTheaters:
            return "movie/now_playing"
            
        case .upcomingMovies:
            return "movie/upcoming"
            
        case .movieDetails(let movieID, _):
            return "movie/\(movieID)"
            
        //MARK: Search
        case .searchMovies:
            return "search/movie"
        }
    }
    
    //MARK: -
    var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    //MARK: -
    var task: HTTPTask {
        switch self {
        //MARK: Genres
        case .allGenres:
            let urlParameters: Parameters = ["language" : defaultLanguage, "api_key" : apiClientKey!]
            return .requestWith(bodyParameters: nil, urlParameters: urlParameters)
            
        //MARK: Movies
        case .inTheaters(let page):
            let urlParameters: Parameters = ["language" : defaultLanguage, "api_key" : apiClientKey!, "page" : "\(page)"]
            return .requestWith(bodyParameters: nil, urlParameters: urlParameters)
            
        case .upcomingMovies(let page):
            let urlParameters: Parameters = ["language" : defaultLanguage, "api_key" : apiClientKey!, "page" : page]
            return .requestWith(bodyParameters: nil, urlParameters: urlParameters)
          
        case .movieDetails(_, let appendToResponse):
            let urlParameters: Parameters = ["language" : defaultLanguage, "api_key" : apiClientKey!, "append_to_response" : appendToResponse]
            return .requestWith(bodyParameters: nil, urlParameters: urlParameters)
            
        //MARK: Search
        case .searchMovies(let searchTerm, let page):
            let urlParameters: Parameters = ["language" : defaultLanguage, "api_key" : apiClientKey!, "query" : searchTerm, "page" : "\(page)", "include_adult" : false]
            return .requestWith(bodyParameters: nil, urlParameters: urlParameters)
        }
    }
    
    //MARK: -
    var headers: HTTPHeader? {
        switch self {
            
        default:
            return nil
        }
    }
}

//MARK: -
extension TMDbAPI {
    var defaultLanguage: String {
        return "en-US"
    }
    
    var defaultRegion: String {
        return "US"
    }
    
    var currentLanguage: String? {
        guard let language = Locale.current.languageCode, let region = Locale.current.regionCode else {
            return nil
        }
        return "\(language)-\(region)"
    }
    
    var currentRegion: String? {
        return Locale.current.regionCode
    }
}
