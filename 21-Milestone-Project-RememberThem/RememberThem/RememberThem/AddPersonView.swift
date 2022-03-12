//
//  AddPersonView.swift
//  RememberThem
//
//  Created by Matt X on 3/10/22.
//

import CoreLocation
import SwiftUI

struct AddPersonView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var name = ""
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var location: CLLocationCoordinate2D?
    
    @State private var hasLocationSwitchOn = false
    @State private var isShowingImagePicker = false
    @State private var isShowingConfirmAlert = false
    
    let locationFetcher = LocationFetcher()
    
    var hasImageAndName: Bool {
        inputImage != nil && !name.isEmpty
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Image") {
                    if inputImage != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        EmptyImagePlaceholder(color: .blue)
                            .onTapGesture {
                                isShowingImagePicker = true
                            }
                    }
                }
                .onChange(of: inputImage) { newValue in
                    setImage(uiImage: newValue)
                }
                
                Section("Name") {
                    TextField("Person's name", text: $name)
                }
                
                Section("Location") {
                    Toggle("Save Location?",
                           isOn: $hasLocationSwitchOn.animation())
                        .onChange(of: hasLocationSwitchOn) { newValue in
                            if newValue == true { locationFetcher.start() }
                            else { location = nil }
                        }
                    
                    if hasLocationSwitchOn {
                        Button {
                            location = locationFetcher.lastKnownLocation
                            
                            isShowingConfirmAlert = true
                        } label: {
                            Label(
                                "Share My Current Location",
                                systemImage: "location"
                            )
                        }
                    }
                }
            }
            .alert("Location saved!", isPresented: $isShowingConfirmAlert) {
                Button("OK") { }
            } message: {
                Text("Your current location will be saved to remind you where you met this person.")
            }
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .toolbar {
                Button {
                    // Save...
                    guard let inputImage = inputImage else { return }
                    guard let jpegData = inputImage.jpegData(
                        compressionQuality: 0.8
                    ) else { return }
                    
                    let person = Person(
                        name: name,
                        jpegData: jpegData,
                        latitude: location?.latitude,
                        longitude: location?.longitude
                    )
                    
                    viewModel.addPerson(person)
                    dismiss()
                } label: {
                    Text("Save")
                }
                .disabled(!hasImageAndName)
            }
            .navigationTitle("Add a new person")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func setImage(uiImage: UIImage?) {
        guard let uiImage = uiImage else { return }
        
        image = Image(uiImage: uiImage)
    }
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView()
    }
}
