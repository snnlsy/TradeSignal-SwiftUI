//
//  DataService.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 4.09.2024.
//

import Foundation
import Combine

// MARK: - DataServicing

protocol DataServicing {
    associatedtype RequestType: URLRequestable
    associatedtype ResponseType
    
    var responsePublisher: AnyPublisher<ResponseType, Error> { get }
    func fetchData(with request: RequestType)
}

// MARK: - DataService

final class DataService<RequestType: URLRequestable, ResponseType: Decodable> {
    private let networkService: NetworkServicing
    private let responseSubject = PassthroughSubject<ResponseType, Error>()
    private var cancellables = Set<AnyCancellable>()
    
    init(container: DependencyContaining = DependencyContainer.shared) {
        self.networkService = container.resolve()
    }
}

// MARK: - DataServicing Implementation

extension DataService: DataServicing {
    var responsePublisher: AnyPublisher<ResponseType, Error> {
        responseSubject
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    func fetchData(with request: RequestType) {
        networkService.execute(request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.handleCompletion(completion)
            }, receiveValue: { [weak self] response in
                self?.handleResponse(response)
            })
            .store(in: &cancellables)
    }
}

// MARK: - Handle Helpers

private extension DataService {
    func handleCompletion(_ completion: Subscribers.Completion<NetworkError>) {
        switch completion {
        case .failure(let error):
            handleError(error)
        case .finished:
            responseSubject.send(completion: .finished)
        }
    }
    
    func handleResponse(_ responseModel: ResponseType) {
        responseSubject.send(responseModel)
    }
    
    func handleError(_ error: Error) {
        Logger.error("Error fetching data: \(error.localizedDescription)")
        responseSubject.send(completion: .failure(error))
    }
}
