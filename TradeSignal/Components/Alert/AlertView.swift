//
//  AlertView.swift
//  TradeSignal
//
//  Created by SUlusoy on 5.09.2024.
//

import SwiftUI

struct AlertView: View {
    var title: String?
    var message: String?
    var primaryButtonLabel: String
    var primaryButtonAction: () -> Void
    var secondaryButtonLabel: String?
    var secondaryButtonAction: (() -> Void)?
    var image: Image?
    
    var body: some View {
        VStack {
            if let image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            } else if let title{
                Text(title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.theme.secondary)
                    .bold()
            }
            if let message {
                Text(message)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.theme.secondary)
            }
            
            HStack(spacing: .large) {
                Button(action: {
                    self.primaryButtonAction()
                }, label: {
                    Text(primaryButtonLabel)
                        .font(.headline)
                        .foregroundColor(.theme.primary)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.theme.secondary)
                        .cornerRadius(.huge)
                })
                if let secondaryButtonLabel {
                    Button(action: {
                        self.secondaryButtonAction?()
                    }, label: {
                        Text(secondaryButtonLabel)
                            .font(.headline)
                            .foregroundColor(.theme.secondary)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.theme.primaryVariant)
                            .cornerRadius(.medium)
                            .overlay(
                                RoundedRectangle(cornerRadius: .huge)
                                    .stroke(Color.theme.secondary, lineWidth: .xxSmall)
                            )
                    })
                }
            }
        }
        .padding()
        .background(Color.theme.primaryVariant)
        .cornerRadius(.medium)
        .shadow(radius: .xxLarge)
        .padding(.xxLarge)
        .presentationBackground(Color.theme.primary.opacity(0.7))
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AlertView(title: "Success!", message: "Your profile was updated successfully.", primaryButtonLabel: "OK", primaryButtonAction: {})
                .previewLayout(.sizeThatFits)
                .padding()
            
            AlertView(title: "Error!", message: "There was an error updating your profile.", primaryButtonLabel: "Try Again", primaryButtonAction: {}, secondaryButtonLabel: "Cancel", secondaryButtonAction: {})
                .previewLayout(.sizeThatFits)
                .padding()
            
            AlertView(title: "Confirmation", message: "Are you sure you want to delete this item?", primaryButtonLabel: "Yes", primaryButtonAction: {}, secondaryButtonLabel: "No", secondaryButtonAction: {})
                .previewLayout(.sizeThatFits)
                .padding()
            
            AlertView(title: "Warning!", message: "You are about to perform a critical operation.", primaryButtonLabel: "Proceed", primaryButtonAction: {}, secondaryButtonLabel: "Cancel", secondaryButtonAction: {})
                .previewLayout(.sizeThatFits)
                .padding()
            
            AlertView(
                message: "An error occurred.",
                primaryButtonLabel: "OK",
                primaryButtonAction: {},
                secondaryButtonLabel: nil,
                secondaryButtonAction: nil,
                image: Image(systemName: "exclamationmark.triangle")
            )
            .previewLayout(.sizeThatFits)
            .padding()
            
        }
    }
}
