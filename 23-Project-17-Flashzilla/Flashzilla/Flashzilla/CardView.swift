//
//  CardView.swift
//  Flashzilla
//
//  Created by Matt X on 3/21/22.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor)
    var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    
    @State private var feedback = UINotificationFeedbackGenerator()
    @State private var isShowingAnswer = false
    @State private var offset: CGSize = .zero
    
    let card: Card
    var removal: (() -> Void)? = nil
    
    var rotationAngle: Angle {
        let amount = Double(offset.width / 5)
        
        return .degrees(amount)
    }
    
    var delayedOpacity: Double {
        // Card must move at least 50 points before fading away
        2 - Double(abs(offset.width / 50))
    }
    
    var instantOpacity: Double {
        // Card starts being colored straight away
        1 - Double(abs(offset.width / 50))
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                    ? .white
                    : .white.opacity(instantOpacity)
                )
                .background(
                    differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(
                            offset.width > 0
                            ? .green
                            : (rotationAngle == .zero ? .white : .red)
                        )
                )
                .shadow(radius: 10)
            
            VStack {
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(rotationAngle)
        .offset(x: offset.width * 5, y: 0)
        .opacity(delayedOpacity)
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    
                    if offset.width < 0 {
                        feedback.prepare()
                    }
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        if offset.width < 0 {
                            feedback.notificationOccurred(.error)
                        }
                        
                        removal?()
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.spring(), value: offset)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: .example)
            .previewInterfaceOrientation(.landscapeRight)
    }
}
