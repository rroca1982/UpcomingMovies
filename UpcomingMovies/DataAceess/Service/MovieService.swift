//
//  MovieService.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/27/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import Foundation

struct MovieService {
    
    func fetchNowPlayingMovies(page: Int, completion: @escaping (Result<MovieCollection>) -> Void) {
        manager.dispatcher.request(.inTheaters(page: page)) { (data, response, error) in
            let result = self.processResult(data, response, error)
            completion(result)
        }
        
    }
    
    func fetchUpcomingMovies(page: Int, completion: @escaping (Result<MovieCollection>) -> Void) {
        manager.dispatcher.request(.upcomingMovies(page: page)) { (data, response, error) in
            
            let result = self.processResult(data, response, error)
            completion(result)
            
        }
    }
    
    func fetchMovieDetails(withID movieID: Int, append extras: String, completion: @escaping (Result<Movie>) -> Void) {
        manager.dispatcher.request(.movieDetails(movieID: movieID, appendToResponse: extras)) { (data, response, error) in
            
            if let error = error {
                let networkError = ErrorHandler.sharedInstance.convertNSURLError(error)
                completion(Result.Failure(networkError))
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(Result.Failure(SwiftyRestKitError.decodingFailed))
                return
            }
            
            let result = self.manager.handleNetworkResponse(response)
            
            switch result {
            case .Success:
                let decoder = JSONDecoder()
                guard let responseData = data, let movie = try? decoder.decode(Movie.self, from: responseData) else {
                    completion(Result.Failure(InternalError.decodingError))
                    return
                }
                
                completion(Result.Success(movie))
                
            case .Failure(let error):
                print(error.localizedDescription)
                completion(Result.Failure(SwiftyRestKitError.lostConnection))
            }
            
        }
    }
    
    fileprivate func processResult(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Result<MovieCollection> {
        if let error = error {
            let networkError = ErrorHandler.sharedInstance.convertNSURLError(error)
            return Result.Failure(networkError)
        }
        
        guard let response = response as? HTTPURLResponse else {
            return Result.Failure(SwiftyRestKitError.decodingFailed)
        }
        
        let result = self.manager.handleNetworkResponse(response)
        
        switch result {
        case .Success:
            let decoder = JSONDecoder()
            guard let responseData = data, let movieCollection = try? decoder.decode(MovieCollection.self, from: responseData) else {
                return Result.Failure(InternalError.decodingError)
            }
            
            return Result.Success(movieCollection)
            
        case .Failure(let error):
            print(error.localizedDescription)
            return Result.Failure(SwiftyRestKitError.lostConnection)
        }
    }
    
    
}

extension MovieService: Service {
    typealias EndPoint = TMDbAPI
}

extension MovieService: Gettable { }

