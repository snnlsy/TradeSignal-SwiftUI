//
//  AsyncDataService.swift
//  TradeSignal
//
//  Created by SUlusoy on 2.10.2024.
//

import Foundation

// MARK: - AsyncDataServicing

protocol AsyncDataServicing {
    associatedtype RequestType: URLRequestable
    associatedtype ResponseType: Decodable
    
    func fetchData(with request: RequestType) async -> Result<ResponseType, Error>
}

// MARK: - AsyncDataService

final class AsyncDataService<RequestType: URLRequestable, ResponseType: Decodable> {
    private let networkService: NetworkServicing
    
    init(container: DependencyContaining = DependencyContainer.shared) {
        self.networkService = container.resolve()
    }
}

// MARK: - AsyncDataServicing Implementation

extension AsyncDataService: AsyncDataServicing {
    func fetchData(with request: RequestType) async -> Result<ResponseType, Error> {
        let result: Result<ResponseType, NetworkError> = await networkService.execute(request)
        
        return switch result {
        case .success(let response):
            .success(response)
        case .failure(let error):
            .failure(error)
        }
    }
}

// MARK: - Handle Helpers

private extension AsyncDataService {
    func handleError(_ error: Error) {
        Logger.error("Error fetching data: \(error.localizedDescription)")
    }
}
