//
//  NetworkHandler.swift
//  MovieDatabase
//
//  Created by Mattia on 10/02/21.
//

import Foundation

/// To be implemented by classes that take care of networking
protocol NetworkHandlerProtocol {
    func getMovies(page: Int, completion: @escaping (Result<MoviesListResponse, Error>) -> Void)
    func getMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetailsResponse, Error>) -> Void)
}

class NetworkHandler: NetworkHandlerProtocol {
    
    static let shared = NetworkHandler()
    
    // MARK: - Dependencies
    
    private let url: URL
    private let urlSession: URLSession
    
    /// Customizable closure used to configure a URLRequest
    var configureUrlRequest: (URLRequest) -> URLRequest = { request in
        var urlRequest = request
        urlRequest.timeoutInterval = 3
        urlRequest.cachePolicy = .reloadIgnoringCacheData
        return urlRequest
    }
    
    init(url: URL = URL(string: "https://api.themoviedb.org/3")!, urlSession: URLSession = .shared) {
        self.url = url
        self.urlSession = urlSession
    }
    
    // MARK: - Functionalities

    /// Calls the specified service which contains the endpoint, method, headers and params for the API call
    private func call<T: Decodable>(service: WebService, completion: @escaping (Result<T, Error>) -> Void) {
        var urlComponents = URLComponents(string: url.absoluteString)
        urlComponents?.path.append(service.endpoint)
        urlComponents?.query = service.query
        
        var urlRequest = configureUrlRequest(URLRequest(url: urlComponents!.url!))
        urlRequest.httpMethod = service.method.rawValue
        urlRequest.allHTTPHeaderFields = service.headers
        
        if let body = service.parameters, let jsonData = try? JSONSerialization.data(withJSONObject: body) {
            urlRequest.httpBody = jsonData
        }
        
        urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.serverError))
                    }
                    return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.unexpectedState))
                }
                return
            }
            
            self?.handleDecoding(type: T.self, from: data, completion: completion)
            }.resume()
    }
    
    /// Decodes the given Data into the given Decodable type and passes the result to either success or failure
    private func handleDecoding<T: Decodable>(type: T.Type, from data: Data, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let object = try jsonDecoder.decode(T.self, from: data)
            DispatchQueue.main.async {
                completion(.success(object))
            }
        } catch let error {
            print("JSON error: \(error.localizedDescription)")
            
            DispatchQueue.main.async {
                completion(.failure(NetworkError.jsonDecodingFailure))
            }
        }
    }
    
    func getMovies(page: Int, completion: @escaping (Result<MoviesListResponse, Error>) -> Void) {
        call(service: MoviesService.getMovies, completion: completion)
    }
    
    func getMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetailsResponse, Error>) -> Void) {
        call(service: MoviesService.getMovieDetails(movieId: movieId), completion: completion)
    }
    
}
