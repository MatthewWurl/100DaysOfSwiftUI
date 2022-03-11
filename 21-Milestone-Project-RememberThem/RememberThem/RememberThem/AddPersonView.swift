//
//  AddPersonView.swift
//  RememberThem
//
//  Created by Matt X on 3/10/22.
//

import SwiftUI

struct AddPersonView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var name = ""
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    @State private var isShowingImagePicker = false
    
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
                        EmptyImagePlaceholder()
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
                        jpegData: jpegData
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

struct EmptyImagePlaceholder: View {
    let color: Color = .blue
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .stroke(
                    color,
                    style: .init(
                        lineWidth: 2,
                        lineCap: .round,
                        dash: [5, 5])
                )
                .scaledToFit()
            
            Text("Tap to select an image")
                .foregroundColor(color)
                .font(.headline)
        }
    }
}
