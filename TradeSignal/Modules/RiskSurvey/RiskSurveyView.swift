//
//  RiskSurveyView.swift
//  TradeSignal
//
//  Created by SUlusoy on 5.09.2024.
//

import SwiftUI

struct RiskSurveyView<ViewModel: RiskSurveyViewModeling>: View {
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color.theme.primary
            content
        }
        .padding(.horizontal)
        .background(Color.theme.primary)
        .navigationTitle("Risk Survey")
        .navigationBarTitleDisplayMode(.inline)
        .loading($viewModel.isLoadingActive)
    }
    
    var content: some View {
        ScrollView {
            VStack(spacing: .large) {
                Spacer()
                questionList
                sendButton
            }
        }
    }
    
    var questionList: some View {
        LazyVStack(alignment: .leading, spacing: .medium) {
            ForEach(viewModel.questions.indices, id: \.self) { questionIndex in
                HStack {
                    VStack(alignment: .leading, spacing: .medium) {
                        Text(viewModel.questions[questionIndex].question)
                            .padding(.horizontal, .medium)
                            .font(.headline)
                            .bold()
                        
                        ForEach(viewModel.questions[questionIndex].answers.indices, id: \.self) { answerIndex in
                            HStack {
                                radioButton(isSelected: viewModel.selectedAnswers[questionIndex] == answerIndex)
                                Text(viewModel.questions[questionIndex].answers[answerIndex])
                            }
                            .padding(.horizontal, .medium)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    viewModel.selectAnswer(for: questionIndex, answerIndex: answerIndex)
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .foregroundColor(.theme.secondary)
                .padding(.vertical)
            }
            .frame(maxWidth: .infinity)
            .padding(.medium)
            .background(Color.theme.primaryVariant)
            .cornerRadius(.medium)
        }
    }

    func radioButton(isSelected: Bool) -> some View {
        ZStack {
            Circle()
                .stroke(isSelected ? Color.theme.secondary : Color.theme.secondary, lineWidth: 2)
                .frame(width: .large, height: .large)
                .shadow(color: isSelected ? Color.theme.secondary.opacity(0.4) : Color.clear, radius: 2, x: 0, y: 0)
            
            if isSelected {
                Circle()
                    .fill(Color.theme.secondary)
                    .frame(width: .medium, height: .medium)
                    .transition(.scale)
                    .animation(.easeInOut(duration: 0.2), value: isSelected)
            }
        }
    }
    
    var sendButton: some View {
        Button(action: { viewModel.didTapSendButton() }) {
            Text("Send")
                .frame(maxWidth: .infinity)
                .padding(.medium)
                .background(Color.theme.secondary)
                .foregroundColor(.theme.primary)
                .cornerRadius(.huge)
        }
    }
}
