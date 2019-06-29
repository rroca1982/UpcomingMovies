//
//  AlertViewModel.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/28/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import Foundation
import UIKit

struct AlertViewModel {
    
    var title: String
    var message: String
    
    var model: Error!
    
    init(model: SwiftyRestKitError) {
        switch model {
        case .timeout:
            title = NSLocalizedString("timeoutAlertTitle", comment: "Connection Timeout")
            message = NSLocalizedString("timeoutAlertMsg", comment: "The connection timed out, please check your internet connection and try again.")
        case .secureConnectionFailed:
            title = NSLocalizedString("secureConnectionAlertTitle", comment: "Could not establish connection")
            message = NSLocalizedString("secureConnectionAlertMsg", comment: "We could not establish a secure connection to the server, please check your internet connection and try again. If the problem persists, please contact support.")
        case .badURL:
            title = NSLocalizedString("badUrlAlertTitle", comment: "Bad URL")
            message = NSLocalizedString("badUrlAlertMsg", comment: "There is something wrong with the URL you are trying to access. Please try again in a few minutes or contact support if the problem persists.")
        case .hostNotFound:
            title = NSLocalizedString("hostNotFoundAlertTitle", comment: "Server not found")
            message = NSLocalizedString("hostNotFoundAlertMsg", comment: "We could not establish a connection to the server, please check your internet connection and try again. If the problem persists, please contact support.")
        case .lostConnection:
            title = NSLocalizedString("lostConnectionAlertTitle", comment: "Lost connection")
            message = NSLocalizedString("lostConnectionAlertMsg", comment: "You are not connected to the Internet, please check your connection and pull to refresh to try again.")
        case .resourceNotFound:
            title = NSLocalizedString("notFoundAlertTitle", comment: "Not found")
            message = NSLocalizedString("notFoundAlertMsg", comment: "The resource you are trying to reach does not exist.")
        default:
            title = NSLocalizedString("unknownErrorAlertTitle", comment: "Unknown error")
            message = NSLocalizedString("unknownNetworkErrorAlertMsg", comment: "An unknown network error occured, please check your internet connection and pull to refresh to try again. If the error persists, please contact support.")
        }
    }
    
    init(model: InternalError) {
        switch model {
        case .noDataError:
            title = NSLocalizedString("notFoundAlertTitle", comment: "Not found")
            message = NSLocalizedString("notFoundInternalErrorAlertMsg", comment: "Your request did not return any data.")
            
        default:
            title = NSLocalizedString("unknownErrorAlertTitle", comment: "Unknown error")
            message = NSLocalizedString("unknownInternalErrorAlertMsg", comment: "An unknown internal error occured, please check your internet connection and pull to refresh to try again. If the error persists, please contact support.")
        }
    }
    
    init(model: Error) {
        if let error = model as NSError? {
            switch error.code {
            
            default:
                title = NSLocalizedString("unknownErrorAlertTitle", comment: "Unknown error")
                message = NSLocalizedString("unknownInternalErrorAlertMsg", comment: "An unknown internal error occured, please check your internet connection and pull to refresh to try again. If the error persists, please contact support.")
            }
        } else {
            title = NSLocalizedString("thereWasAnError", comment: "There was an error")
            message = model.localizedDescription
        }
    }
}

