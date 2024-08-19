//
//  CustomButton.swift
//  Toss_MeetingAccount_Clone_Coding
//
//  Created by OWEN on 8/13/24.
//
import SwiftUI

struct CustomButton: ButtonStyle {
    var labelColor = Color.white
    var backgroundColor = Color.black.opacity(0.1)
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(labelColor)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(RoundedRectangle(cornerRadius: 12).fill(backgroundColor))
            .scaleEffect(configuration.isPressed ? 0.88 : 1.0)
    }
}
