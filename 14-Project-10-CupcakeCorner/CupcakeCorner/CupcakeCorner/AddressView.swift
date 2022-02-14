//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Matt X on 2/11/22.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderObject: OrderObject
    
    var body: some View {
        Form {
            Section("Address Information") {
                TextField("Name", text: $orderObject.order.name)
                TextField("Street address", text: $orderObject.order.streetAddress)
                TextField("City", text: $orderObject.order.city)
                TextField("Zip", text: $orderObject.order.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(orderObject: orderObject)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(!orderObject.order.hasValidAddress)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(orderObject: OrderObject())
        }
    }
}
