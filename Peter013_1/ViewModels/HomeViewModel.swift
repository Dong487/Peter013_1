//
//  HomeViewModel.swift
//  Peter013_1
//
//  Created by DONG SHENG on 2022/7/10.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject{
    
    @Published var clothesColor: PickColorModel = PickColorModel(red: 236 / 255, green: 78 / 255, blue: 75 / 255, opacity: 1)
    @Published var pantsColor: PickColorModel = PickColorModel(red: 247 / 255, green: 245 / 255, blue: 135 / 255, opacity: 1)
    @Published var shoesColor: PickColorModel = PickColorModel(red: 239 / 255, green: 204 / 255, blue: 83 / 255, opacity: 1)
    
    // 選擇正在更改的
    @Published var selection: String = "clothes"
    let name: [String] = ["clothes", "pants" , "shoes"]
    
    // 圓角 用
    @Published var lock: Bool = true
    @Published var cornerRadius: CGFloat = 50
    
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var timerStart: Bool = false{
        didSet{
            if timerStart{
                self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            } else {
                self.timer.upstream.connect().cancel()
            }
        }
    }
    
    
    // 配合 Slider 值 顯示的Text
    func redText() -> String{
        if self.selection == "clothes"{
            return String(format: "%.0f", clothesColor.red * 255)
        } else if self.selection == "pants" {
            return String(format: "%.0f", pantsColor.red * 255)
        } else if self.selection == "shoes" {
            return String(format: "%.0f", shoesColor.red * 255)
        }
        return "錯誤"
    }
    
    func greenText() -> String{
        if self.selection == "clothes"{
            return String(format: "%.0f", clothesColor.green * 255)
        } else if self.selection == "pants" {
            return String(format: "%.0f", pantsColor.green * 255)
        } else if self.selection == "shoes" {
            return String(format: "%.0f", shoesColor.green * 255)
        }
        return "錯誤"
    }
    
    func blueText() -> String{
        if self.selection == "clothes"{
            return String(format: "%.0f", clothesColor.blue * 255)
        } else if self.selection == "pants" {
            return String(format: "%.0f", pantsColor.blue * 255)
        } else if self.selection == "shoes" {
            return String(format: "%.0f", shoesColor.blue * 255)
        }
        return "錯誤"
    }
    
    func opacityText() -> String{
        if self.selection == "clothes"{
            return String(format: "%.2f", clothesColor.opacity)
        } else if self.selection == "pants" {
            return String(format: "%.2f", pantsColor.opacity)
        } else if self.selection == "shoes" {
            return String(format: "%.2f", shoesColor.opacity)
        }
        return "錯誤"
    }
    
    // 判斷 selection 告訴 Slider 正在變動的對象
    // Slider追蹤的值 所以return Binding
    func redSlider() -> Binding<Double>{
        if self.selection == "clothes"{
            return Binding( get: { self.clothesColor.red }, set: { self.clothesColor.red = $0 })
        } else if self.selection == "pants"{
            return Binding( get: { self.pantsColor.red }, set: { self.pantsColor.red = $0 })
        } else if self.selection == "shoes"{
            return Binding( get: { self.shoesColor.red }, set: { self.shoesColor.red = $0 })
        }
        return Binding( get: { 0.0 }, set: { _ in }) // 沒值的情況 (通常不會出現)
    }
        
    func greenSlider() -> Binding<Double>{
        if self.selection == "clothes"{
            return Binding( get: { self.clothesColor.green }, set: { self.clothesColor.green = $0 })
        } else if self.selection == "pants"{
            return Binding( get: { self.pantsColor.green }, set: { self.pantsColor.green = $0 })
        } else if self.selection == "shoes"{
            return Binding( get: { self.shoesColor.green }, set: { self.shoesColor.green = $0 })
        }
        return Binding( get: { 0.2 }, set: { _ in })
    }
    
    func blueSlider() -> Binding<Double>{
        if self.selection == "clothes"{
            return Binding( get: { self.clothesColor.blue }, set: { self.clothesColor.blue = $0 })
        } else if self.selection == "pants"{
            return Binding( get: { self.pantsColor.blue }, set: { self.pantsColor.blue = $0 })
        } else if self.selection == "shoes"{
            return Binding( get: { self.shoesColor.blue }, set: { self.shoesColor.blue = $0 })
        }
        return Binding( get: { 0.0 }, set: { _ in }) // 沒值的情況 (通常不會出現)
    }
    
    func opacitySlider() -> Binding<Double>{
        if self.selection == "clothes"{
            return Binding( get: { self.clothesColor.opacity }, set: { self.clothesColor.opacity = $0 })
        } else if self.selection == "pants"{
            return Binding( get: { self.pantsColor.opacity }, set: { self.pantsColor.opacity = $0 })
        } else if self.selection == "shoes"{
            return Binding( get: { self.shoesColor.opacity }, set: { self.shoesColor.opacity = $0 })
        }
        return Binding( get: { 1.0 }, set: { _ in }) // 沒值的情況 (通常不會出現)
    }
    
    func random(){
        self.clothesColor = PickColorModel(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1), opacity: 1)
        self.pantsColor = PickColorModel(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1), opacity: 1)
        self.shoesColor = PickColorModel(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1), opacity: 1)
    }
    
    func reset(){
        self.clothesColor = PickColorModel(red: 236 / 255, green: 78 / 255, blue: 75 / 255, opacity: 1)
        self.pantsColor = PickColorModel(red: 247 / 255, green: 245 / 255, blue: 135 / 255, opacity: 1)
        self.shoesColor = PickColorModel(red: 239 / 255, green: 204 / 255, blue: 83 / 255, opacity: 1)
    }
}
