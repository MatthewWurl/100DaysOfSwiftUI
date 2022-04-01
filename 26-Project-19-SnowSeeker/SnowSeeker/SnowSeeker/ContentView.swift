//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Matt X on 3/29/22.
//

import SwiftUI

// Override iPhone 13 Pro Max layout...
//
//extension View {
//    @ViewBuilder func phoneOnlyNavigationView() -> some View {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            self.navigationViewStyle(.stack)
//        } else {
//            self
//        }
//    }
//}

struct ContentView: View {
    enum SortOrder {
        case defaultOrder, alphabeticalOrder, countryOrder
    }
    
    @StateObject var favorites = Favorites()
    
    @State private var searchText = ""
    @State private var sortOrder: SortOrder = .defaultOrder
    @State private var isShowingSortConfirmation = false
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var sortedResorts: [Resort] {
        switch sortOrder {
        case .defaultOrder:
            return filteredResorts
        case .alphabeticalOrder:
            return filteredResorts.sorted { $0.name < $1.name }
        case .countryOrder:
            // Sort by country & sort alphabetically within same country.
            return filteredResorts.sorted {
                $0.country == $1.country
                ? $0.name < $1.name
                : $0.country < $1.country
            }
        }
    }
    
    var body: some View {
        NavigationView {
            // Primary View
            List(sortedResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            }
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort.")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort...")
            .confirmationDialog("Test",
                                isPresented: $isShowingSortConfirmation) {
                Button("Default") { sortOrder = .defaultOrder }
                Button("Alphabetical (A-Z)") { sortOrder = .alphabeticalOrder }
                Button("Country") { sortOrder = .countryOrder }
            } message: {
                Text("Sorting Order")
            }
            .toolbar {
                Button {
                    isShowingSortConfirmation = true
                } label: {
                    Label("Sort Resorts", systemImage: "arrow.up.arrow.down")
                }
            }
            
            // Secondary View
            WelcomeView()
        }
        .environmentObject(favorites)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
