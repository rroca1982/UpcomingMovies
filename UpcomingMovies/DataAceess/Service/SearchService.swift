//
//  SearchService.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/27/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import Foundation

struct SearchService {
    
    func searchMoviesByTitle(searchTerm: String, page: Int, completion: @escaping (Result<MovieCollection>) -> Void) {
        manager.dispatcher.request(.searchMovies(searchTerm: searchTerm, page: page)) { (data, response, error) in
            let result = self.processResult(data, response, error)
            completion(result)
        }
    }
    
    private func processResult(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Result<MovieCollection> {
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

extension SearchService: Service {
    typealias EndPoint = TMDbAPI
}

extension SearchService: Gettable { }
