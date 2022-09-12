//
//  NetworkError.swift
//  NasaImages
//
//  Created by Noel Obaseki on 10/09/2022.
//

import Foundation

enum NetworkError: Error {
    case invalidImageUrl
    case networkFailureError(String)
    case decodingError
    case badRequest
    case dataLoadingError(statusCode: Int, data: Data)
    case serverErrorResponse(code: Int)
    case URLErrorNotConnectedToInternet
    case ErrorNetworkLost
    case URLErrorTimedOut
    case serviceUnavailable
    case notFound
    case server
    case other(Error)
    case unknown
}

extension NetworkError {
    
    static func mapConnectivityError(_ error: Error) -> NetworkError {
        switch error {

        case URLError.timedOut:
            return .URLErrorTimedOut
        case is Swift.DecodingError:
            return .decodingError
        default:
            return .other(error)
        }
    }

    

    static func mapHTTPStatusError(statusCode: Int) -> NetworkError {
        switch statusCode {
        case 400:
            return .badRequest
        case 404:
            return .notFound
        case 503:
            return .serviceUnavailable
        case 500 ... 599:
            return .server
        default:
            return .unknown
        }
    }
    
    static func getErrorMsg(_ error: NetworkError) -> String {
        var message = ""
        
        switch error {
        case .badRequest:
            message = "API bad request"
        case .notFound:
            message = "API route not found"
        case .server:
            message = "API server unreachable"
        case .decodingError:
            message = "codable decoding error"
        case .other(let error):
            message = error.localizedDescription
        case .URLErrorTimedOut:
            message = "API timed out"
        case .unknown:
            message = "unknown error"
        default:
            message = "unknown error"
        }
        
        return message
    }
}
