//
//  APIConfiguration.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 23/11/22.
//

import Foundation
import Alamofire

public enum APIConfiguration: URLRequestConvertible {

    case getAllPairs
    
    var baseURL: String {
        return "https://indodax.com"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .getAllPairs:
            return "/api/pairs"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        default:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding(destination: .queryString)
    }
    
    
    public func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        
        request.httpMethod = method.rawValue
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
    
}
