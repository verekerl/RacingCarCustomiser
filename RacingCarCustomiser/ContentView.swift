//
//  ContentView.swift
//  RacingCarCustomiser
//
//  Created by Luke Vereker on 12/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var starterCars = StarterCars()
    @State private var selectedCar: Int = 0 {
        didSet {
            if selectedCar >= starterCars.cars.count {
                selectedCar = 0
            }
        }
    }
    @State private var exhaustPackage = false
    @State private var tirePackage = false
    @State private var accelerationPackage = false
    @State private var boostPackage = false
    
    var body: some View {
        let exhaustPackageBinding = Binding<Bool> (
            get: {self.exhaustPackage},
            set: {newValue in
                self.exhaustPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 10
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 10
                }
            }
        )
        let tirePackageBinding = Binding<Bool> (
            get: {self.tirePackage},
            set: {newValue in
                self.tirePackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 2
                } else if newValue == false {
                    starterCars.cars[selectedCar].handling -= 2
                }
            }
        )
        let accelerationPackageBinding = Binding<Bool> (
            get: {self.accelerationPackage},
            set: {newValue in
                self.accelerationPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration += 0.5
                } else if newValue == false {
                    starterCars.cars[selectedCar].acceleration -= 0.5
                }
            }
        )
        let boostPackageBinding = Binding<Bool> (
            get: {self.boostPackage},
            set: {newValue in
                self.boostPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].nitroBoost = true
                } else if newValue == false {
                    starterCars.cars[selectedCar].nitroBoost = false
                }
            }
        )
        
        Form {
            VStack(alignment: .leading, spacing: 20) {
                Text("\(starterCars.cars[selectedCar].displayCarStats())")
                Button("Next Car", action: {
                    selectedCar += 1
                })
            }
            Section {
                Toggle("Exhaust Package", isOn: exhaustPackageBinding)
                Toggle("Tire Package", isOn: tirePackageBinding)
                Toggle("Acceleration Package", isOn: accelerationPackageBinding)
                Toggle("Boost Package", isOn: boostPackageBinding)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
