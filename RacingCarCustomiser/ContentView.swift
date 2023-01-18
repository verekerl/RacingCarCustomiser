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
    @State private var remainingFunds = 1000
    @State private var remainingTime = 30
    @State private var CarButton = true
    
    var exhaustPackageEnabled: Bool {
        return exhaustPackage ? true : remainingFunds >= 500 ? true : false
    }
    
    var tirePackageEnabled: Bool {
        return tirePackage ? true : remainingFunds >= 500 ? true : false    }
    
    var accelerationPackageEnabled: Bool {
        return accelerationPackage ? true : remainingFunds >= 500 ? true : false
    }
    
    var boostPackageEnabled: Bool {
        return boostPackage ? true : remainingFunds >= 1000 ? true : false
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        let exhaustPackageBinding = Binding<Bool> (
            get: {self.exhaustPackage},
            set: {newValue in
                self.exhaustPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 10
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 10
                    remainingFunds += 500
                }
            }
        )
        let tirePackageBinding = Binding<Bool> (
            get: {self.tirePackage},
            set: {newValue in
                self.tirePackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 2
                    remainingFunds -= 500
                } else if newValue == false {
                    starterCars.cars[selectedCar].handling -= 2
                    remainingFunds += 500
                }
            }
        )
        let accelerationPackageBinding = Binding<Bool> (
            get: {self.accelerationPackage},
            set: {newValue in
                self.accelerationPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration -= 0.5
                    remainingFunds -= 500
                } else if newValue == false {
                    starterCars.cars[selectedCar].acceleration += 0.5
                    remainingFunds += 500
                }
            }
        )
        let boostPackageBinding = Binding<Bool> (
            get: {self.boostPackage},
            set: {newValue in
                self.boostPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].nitroBoost = true
                    remainingFunds -= 1000
                } else if newValue == false {
                    starterCars.cars[selectedCar].nitroBoost = false
                    remainingFunds += 1000
                }
            }
        )
        VStack {
            Text("\(remainingTime)")
                .onReceive(timer) { _ in
                    if remainingTime > 0 {
                        self.remainingTime -= 1
                    } else {
                        CarButton = false
                    }
                }
                .foregroundColor(.red)
            Form {
                VStack(alignment: .leading, spacing: 20) {
                    Text("\(starterCars.cars[selectedCar].displayCarStats())")
                    Button("Next Car", action: {
                        selectedCar += 1
                        resetDisplay()
                    })
                    .disabled(!CarButton)
                }
                Section {
                    Toggle("Exhaust Package (Cost: 500)", isOn: exhaustPackageBinding)
                        .disabled(!exhaustPackageEnabled)
                    Toggle("Tire Package (Cost: 500)", isOn: tirePackageBinding)
                        .disabled(!tirePackageEnabled)
                    Toggle("Acceleration Package (Cost: 500)", isOn: accelerationPackageBinding)
                        .disabled(!accelerationPackageEnabled)
                    Toggle("Boost Package (Cost: 1000)", isOn: boostPackageBinding)
                        .disabled(!boostPackageEnabled)
                }
            }
            Text("Remaining Funds: \(remainingFunds)")
                .foregroundColor(.red)
                .baselineOffset(20)
        }
    }
    
    func resetDisplay() {
        remainingFunds = 1000
        exhaustPackage = false
        tirePackage = false
        accelerationPackage = false
        boostPackage = false
        starterCars = StarterCars()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
