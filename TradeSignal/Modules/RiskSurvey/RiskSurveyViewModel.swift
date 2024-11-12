//
//  RiskSurveyViewModel.swift
//  TradeSignal
//
//  Created by SUlusoy on 5.09.2024.
//

import Foundation
import Combine

// MARK: - RiskSurveyViewModeling

protocol RiskSurveyViewModeling: ObservableObject {
    var questions: [RiskSurveyModel] { get set }
    var selectedAnswers: [Int: Int] { get set }
    var isLoadingActive: Bool { get set }
    var error: Error? { get }
    func didTapSendButton()
    func selectAnswer(for questionNumber: Int, answerIndex: Int)
}

// MARK: - RiskSurveyViewModel

final class RiskSurveyViewModel: RiskSurveyViewModeling {
    private let riskSurveyDataService: RiskSurveyDataService
    private let sendRiskSurveyDataService: SendRiskSurveyDataService
    @Published var isLoadingActive = false
    @Published private(set) var error: Error?
    @Published var questions: [RiskSurveyModel] = []
    @Published var selectedAnswers: [Int: Int] = [:]
    
    private var cancellables = Set<AnyCancellable>()

    init(
        riskSurveyDataService: RiskSurveyDataService = .init(),
        sendRiskSurveyDataService: SendRiskSurveyDataService = .init()
    ) {
        self.riskSurveyDataService = riskSurveyDataService
        self.sendRiskSurveyDataService = sendRiskSurveyDataService
        setupBindings()
        fetchRiskSurveyData()
    }
}

// MARK: - Data Operations

private extension RiskSurveyViewModel {
    func fetchRiskSurveyData() {
        isLoadingActive = true
        riskSurveyDataService.fetchData(with: .init())
    }
    
    func postSendRiskSurveyData() {
        isLoadingActive = true
        let req = SendRiskSurveyRequestModel(parameters: .init(answers: selectedAnswers))
        sendRiskSurveyDataService.fetchData(with: req)
    }
    
    func handleRiskSurveyResponse(with response: RiskSurveyResponseModel) {
        questions = response.questionList
    }
}

// MARK: - RiskSurveyViewModeling Implementation

extension RiskSurveyViewModel {
    func didTapSendButton() {
        postSendRiskSurveyData()
    }
    
    func selectAnswer(for questionNumber: Int, answerIndex: Int) {
        selectedAnswers[questionNumber] = answerIndex
    }
}

// MARK: - Bindings

private extension RiskSurveyViewModel {
    func setupBindings() {
        bindRiskSurveyData()
        bindSendRiskSurveyData()
    }
    
    func bindRiskSurveyData() {
        riskSurveyDataService.responsePublisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self else { return }
                    self.isLoadingActive = false
                    if case .failure(let error) = completion {
                        self.error = error
                    }
                },
                receiveValue: { [weak self] response in
                    guard let self else { return }
                    handleRiskSurveyResponse(with: response)
                }
            )
            .store(in: &cancellables)
    }
    
    func bindSendRiskSurveyData() {
        sendRiskSurveyDataService.responsePublisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self else { return }
                    self.isLoadingActive = false
                    if case .failure(let error) = completion {
                        self.error = error
                    }
                },
                receiveValue: { [weak self] response in
                    guard let self else { return }
                    print(response)
                }
            )
            .store(in: &cancellables)
    }
}
