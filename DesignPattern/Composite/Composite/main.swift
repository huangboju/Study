//
//  main.swift
//  Composite
//
//  Created by 伯驹 黄 on 2017/5/16.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation



protocol MenuComponent {
    func add(menuComponent: MenuComponent)
    
    func remove(menuComponent: MenuComponent)
    
    func getChild(at i: Int) -> MenuComponent?
    
    var name: String { get }
    
    var description: String { get }
    
    var price: Double { get }
    
    var isVegetarian: Bool { get }
    
    func log()
}

extension MenuComponent {
    var isVegetarian: Bool {
        return false
    }
    
    var price: Double {
        return 0
    }
}


class MenuItem: MenuComponent {

    private var _name: String
    private var _description: String
    private var _isVegetarian: Bool
    private var _price: Double
    
    var name: String {
        return _name
    }
    
    var description: String {
        return _description
    }
    
    var price: Double {
        return _price
    }
    
    var isVegetarian: Bool {
        return _isVegetarian
    }
    
    init(name: String, description: String, price: Double, isVegetarian: Bool) {
        _name = name
        _description = description
        _isVegetarian = isVegetarian
        _price = price
    }
    
    func add(menuComponent: MenuComponent) {
        
    }
    
    func remove(menuComponent: MenuComponent) {
        
    }
    
    func getChild(at i: Int) -> MenuComponent? {
        return nil
    }

    func log() {
        print(" \(name)")
        if isVegetarian {
            print("v")
        }
        print("\(price)")
        print("\(description)")
    }
}

class Menu: MenuComponent {

    private var _name: String
    private var _description: String

    var menuComponents: [MenuComponent] = []
    
    var name: String {
        return _name
    }
    
    var description: String {
        return _description
    }

    init(name: String, description: String) {
        _name = name
        _description = description
    }
    
    func add(menuComponent: MenuComponent) {
        menuComponents.append(menuComponent)
    }
    
    func remove(menuComponent: MenuComponent) {
        
    }
    
    func getChild(at i: Int) -> MenuComponent? {
        return menuComponents[i]
    }
    
    func log() {
        print("\n \(name)")
        print(", \(description)")
        print("=================================")
        
        var iterator = menuComponents.makeIterator()

        while let item = iterator.next() {
            item.log()
        }
    }
}


class Waitress {
    var allMenus: MenuComponent
    
    init(menus: MenuComponent) {
        allMenus = menus
    }

    func printMenu() {
        allMenus.log()
    }
}


let pancakeHouseMenu = Menu(name: "PANCAKE HOUSE MENU", description: "Breakfast")
let dinerMenu = Menu(name: "DINER MENU", description: "Lunch")
let cafeMenu = Menu(name: "CAFE MENU", description: "Dinner")
let dessertMenu = Menu(name: "DESSERT MENU", description: "Dessert of course!")

let allMenus = Menu(name: "ALL MENUS", description: "All menus combined")


allMenus.add(menuComponent: pancakeHouseMenu)
allMenus.add(menuComponent: dinerMenu)
allMenus.add(menuComponent: cafeMenu)




dinerMenu.add(menuComponent: MenuItem(name: "Pasta", description: "Spaghetti with Marinara Sauce, and a slice of sourdough bread", price: 3.89, isVegetarian: true))
dinerMenu.add(menuComponent: dessertMenu)

dessertMenu.add(menuComponent: MenuItem(name: "Apple Pie", description: "Apple pie with a flakey crust, topped with vanilla ice cream", price: 1.59, isVegetarian: true))

let waitress = Waitress(menus: allMenus)
waitress.printMenu()












