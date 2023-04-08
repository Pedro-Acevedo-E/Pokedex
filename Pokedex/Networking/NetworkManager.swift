//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Pedro Acevedo on 08/04/23.
//

import Foundation

final class NetworkManager<T: Codable> {
    static func fetch(for url: URL) async -> Result<T, NetworkError> {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return processResponse(statusCode: httpResponse.statusCode, data: data, decoder: decoder)
        } catch {
            return .failure(.unknownError)
        }
    }
    
    static func processResponse(statusCode: Int, data: Data, decoder: JSONDecoder) -> Result<T, NetworkError> {
        switch statusCode {
        case(500...599) :
            print("Server error")
            return .failure(.serverError(statusCode))
        case(400...499) :
            print("Client error")
            return .failure(.clientError(statusCode))
        case(300...399) :
            print("Invalid status code error")
            return .failure(.invalidStatusCode(statusCode))
        case(200...299) :
            guard let decodedResponse = try? decoder.decode(T.self, from: data) else {
                print("Decoding error")
                return .failure(.decodingError)
            }
            return .success(decodedResponse)
        case(100...103) :
            print("Invalid status code error")
            return .failure(.invalidStatusCode(statusCode))
        default :
            return .failure(.unknownError)
        }
    }
}

enum NetworkError: Error {
    case error(err: String)
    case clientError(Int)
    case serverError(Int)
    case invalidStatusCode(Int)
    case unknownError
    case noResponse
    case decodingError
    
    var localizedDescription: String {
        switch self {
        case .error(err: let err):
            return err
        case .clientError(let code):
            return "Something went wrong :/ \nClient error\nCode: \(code)"
        case .serverError(let code):
            return "Couldn't connect to server :/ \nServer error\nCode: \(code)"
        case .invalidStatusCode(let code):
            return "This shouldn't happen 🤔 \nStatus error\nCode: \(code)"
        case .unknownError:
            return "This shouldn't happen 🤔 \nUnknown error"
        case .noResponse:
            return "Something went wrong :/ \nNo response"
        case .decodingError:
            return "Something went wrong :/ \nData couldn't be converted"
        }
    }
}
