//
//  ContentView.swift
//  RememberThem
//
//  Created by Matt X on 3/10/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    @State private var isShowingAddView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.people) { person in
                    NavigationLink {
                        PersonDetailView(person: person)
                    } label: {
                        HStack {
                            person.image?
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 44, height: 44)
                            
                            Text(person.name)
                        }
                    }
                }
                .onDelete(perform: viewModel.removePerson)
            }
            .navigationTitle("Remember Them")
            .sheet(isPresented: $isShowingAddView) {
                AddPersonView()
                    .environmentObject(viewModel)
            }
            .toolbar {
                Button {
                    // Add a new person
                    isShowingAddView = true
                } label: {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("Add a new person")
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
