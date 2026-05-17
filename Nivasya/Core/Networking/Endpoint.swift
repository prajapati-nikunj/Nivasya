// File: Core/Networking/Endpoint.swift
// Generated: 2026-05-16 | Method: Antigravity Orchestral v1.0

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
    var headers: [String: String]? { get }
}

extension Endpoint {
    public var queryItems: [URLQueryItem]? { nil }
    public var body: Data? { nil }
    public var headers: [String: String]? { ["Content-Type": "application/json"] }
}

public enum NetworkError: LocalizedError {
    case unauthorized, forbidden, notFound, serverError(Int)
    case decodingFailed(Error), invalidURL, invalidResponse
    
    public var errorDescription: String? {
        switch self {
        case .unauthorized: return "Authentication required"
        case .forbidden: return "Access denied"
        case .notFound: return "Resource not found"
        case .serverError(let code): return "Server error: \(code)"
        case .decodingFailed(let error): return "Failed to parse response: \(error.localizedDescription)"
        case .invalidURL: return "Invalid request URL"
        case .invalidResponse: return "Unexpected response format"
        }
    }
}
