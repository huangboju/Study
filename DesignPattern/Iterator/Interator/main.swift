//
//  main.swift
//  Interator
//
//  Created by 伯驹 黄 on 2017/2/27.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

struct MenuItem {
    let name: String
    let description: String
    let vegetarian: Bool
    let price: Double
}

protocol Menu {
    func creatIterator() -> DinerMenuIterator
}


class PancakeHouseMenu: Menu {
    var menuItems: [MenuItem] = []

    init() {

        let items = [
            ("K&B's Pancake Breakfast", "Pancakes with scrambled eggs, and toast", true, 2.99),
            ("Regular Pancake Breakfast", "Pancakes with friend eggs, sausage", false, 2.99),
            ("Blueberry Pancakes", "Pancakes made with fresh blueberries", true, 3.49),
            ("Waffles", "Waffles, with your choice of blueberries or starawberries", true, 3.59),
        ]

        items.forEach { addItem($0.0, description: $0.1, vegetarian: $0.2, price: $0.3) }
    }

    func addItem(_ name: String, description: String, vegetarian: Bool, price: Double) {
        let item = MenuItem(name: name, description: description, vegetarian: vegetarian, price: price)
        menuItems.append(item)
    }

    func creatIterator() -> DinerMenuIterator {
        return DinerMenuIterator(items: menuItems)
    }
}

struct DinerMenuIterator: IteratorProtocol {
    var items: [MenuItem] = []
    var position = 0

    init(items: [MenuItem]) {
        self.items = items
    }

    mutating func next() -> MenuItem? {
        defer { position += 1 }
        return items.count > position ? items[position] : nil
    }
}

class DinerMenu: Menu {
    let maxItems = 6
    var numberOfItems = 0
    var menuItems: [MenuItem] = []

    init() {
        let items = [
            ("Vegetarian BLT", "(Fakin') Bacon with lettuce & tomato on whole wheat", true, 2.99),
            ("BLT", "Bacon with lettuce & tomato on whole wheat", false, 2.99),
            ("Soup of the day", "with a side of potato salad", false, 3.29),
            ("Hotdog", "A hot dog, with saurkraut, relish, onions, topped with cheese", false, 3.05),
        ]

        items.forEach { addItem($0.0, description: $0.1, vegetarian: $0.2, price: $0.3) }
    }

    func addItem(_ name: String, description: String, vegetarian: Bool, price: Double) {
        let item = MenuItem(name: name, description: description, vegetarian: vegetarian, price: price)
        if numberOfItems >= maxItems {
            print("Sorry, menu is full!Can't add item to menu")
        } else {
            menuItems.append(item)
            numberOfItems += 1
        }
    }

    func creatIterator() -> DinerMenuIterator {
        return DinerMenuIterator(items: menuItems)
    }
}



class Waitress {
    var pancakeHouseMenu: Menu
    var dinerMenu: Menu
    
    init(pancakeHouseMenu: Menu, dinerMenu: Menu) {
        self.pancakeHouseMenu = pancakeHouseMenu
        self.dinerMenu = dinerMenu
    }
    
    func printMenu() {
        let pancakeInterator = pancakeHouseMenu.creatIterator()
        let dinerIterator = dinerMenu.creatIterator()
        
        print("MENU\n----\nBREAKFAST")
        printMenu(with: pancakeInterator)
        print("\nLUNCH")
        printMenu(with: dinerIterator)
    }
    
    func printMenu(with iterator: DinerMenuIterator) {
        var iterator = iterator
        while let menuItem = iterator.next() {
            print(menuItem.name)
            print(menuItem.price)
            print(menuItem.description)
        }
    }
}


let pancakeHouseMenu = PancakeHouseMenu()
let dinerMenu = DinerMenu()

let waitress = Waitress(pancakeHouseMenu: pancakeHouseMenu, dinerMenu: dinerMenu)
waitress.printMenu()

print("😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄")




// MARK: - ************************************************

struct Novella {
    let name: String
}

struct Novellas {
    let novellas: [Novella]
}

struct NovellasIterator: IteratorProtocol {

    private var current = 0
    private let novellas: [Novella]

    init(novellas: [Novella]) {
        self.novellas = novellas
    }

    mutating func next() -> Novella? {
        defer { current += 1 }
        return novellas.count > current ? novellas[current] : nil
    }
}

extension Novellas: Sequence {
    func makeIterator() -> NovellasIterator {
        return NovellasIterator(novellas: novellas)
    }
}

let greatNovellas = Novellas(novellas: [Novella(name: "The Mist")])

for novella in greatNovellas {
    print("I've read: \(novella)")
}

for i in stride(from: 1, to: 10, by: 2) {
    print(i)
}
