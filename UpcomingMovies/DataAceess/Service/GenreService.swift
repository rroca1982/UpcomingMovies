//
//  GenreService.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/27/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import Foundation

struct GenreService {
    
    func fetchGenres(completion: @escaping (Result<[Genre]>) -> Void) {
        manager.dispatcher.request(.allGenres) { (data, response, error) in
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
                guard let responseData = data, let genresCollection = try? decoder.decode(GenreCollection.self, from: responseData) else {
                    completion(Result.Failure(InternalError.decodingError))
                    return
                }
                completion(Result.Success(genresCollection.genres))
                
            case .Failure(let error):
                print(error.localizedDescription)
                completion(Result.Failure(SwiftyRestKitError.lostConnection))
            }
        }
        
    }
    
}

extension GenreService: Service {
    typealias EndPoint = TMDbAPI
}

extension GenreService: Gettable { }

