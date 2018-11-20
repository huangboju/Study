//
//  main.swift
//  SimpleFactory
//
//  Created by 伯驹 黄 on 2017/5/9.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation


class Pizza {
    func prepare() {
        
    }
    
    func bake()  {
        
    }
    
    func cut() {
        
    }
    
    func box() {
        
    }
}


class PizzaStore {
    final func orderPizza(_ type: String) {
        let pizza = createPizza(type)

        pizza?.prepare()
        pizza?.bake()
        pizza?.cut()
        pizza?.box()
    }

    func createPizza(_ type: String) -> Pizza? {
        return nil
    }
}


class NYStyleCheesePizza: Pizza {
    
}


class NYStyleVeggiePizza: Pizza {
    
}

class NYStyleClamPizza: Pizza {
    
}

class NYStylePepperoniPizza: Pizza {
    
}

class NYPizzaStore: PizzaStore {
    override func createPizza(_ type: String) -> Pizza? {
        switch type {
        case "cheese":
            return NYStyleCheesePizza()
        case "veggie":
            return NYStyleVeggiePizza()
        case "clam":
            return NYStyleClamPizza()
        case "pepperoni":
            return NYStylePepperoniPizza()
        default:
            return nil
        }
    }
}









