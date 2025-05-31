//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Matt X on 2/11/22.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var orderObject: OrderObject
    
    @State private var confirmationMessage = ""
    @State private var isShowingConfirmationMessage = false
    @State private var isShowingFailureMessage = false
    
    private let imageUrl = URL(string: "https://hws.dev/img/cupcakes@3x.jpg")
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: imageUrl, scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .accessibilityHidden(true)
                } placeholder: {
                    ProgressView()
                        .accessibilityHidden(true)
                }
                .frame(height: 233)
                
                Text("Your total is \(orderObject.order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .alert(
                    "Uh-oh, something went wrong!",
                    isPresented: $isShowingFailureMessage
                ) {
                    Button("OK") { }
                } message: {
                    Text("Please check your internet connection or try again later.")
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $isShowingConfirmationMessage) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(orderObject.order) else {
            return print("Failed to encode order.")
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // This generic API key is necessary now...
        request.setValue("reqres-free-v1", forHTTPHeaderField: "x-api-key")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(
                for: request,
                from: encoded
            )
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcake(s) is on its way!"
            isShowingConfirmationMessage = true
        } catch {
            isShowingFailureMessage = true
        }
    }
}

#Preview {
    NavigationStack {
        CheckoutView(
            orderObject: OrderObject()
        )
    }
}
