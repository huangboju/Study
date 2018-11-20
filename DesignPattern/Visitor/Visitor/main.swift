//
//  main.swift
//  Visitor
//
//  Created by 伯驹 黄 on 2017/2/27.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

protocol PlanetVisitor {
    func visit(planet: PlanetAlderaan)
    func visit(planet: PlanetCoruscant)
    func visit(planet: PlanetTatooine)
    func visit(planet: MoonJedah)
}

protocol Planet {
    func accept(visitor: PlanetVisitor)
}

class MoonJedah: Planet {
    func accept(visitor: PlanetVisitor) { visitor.visit(planet: self) }
}

class PlanetAlderaan: Planet {
    func accept(visitor: PlanetVisitor) { visitor.visit(planet: self) }
}

class PlanetCoruscant: Planet {
    func accept(visitor: PlanetVisitor) { visitor.visit(planet: self) }
}

class PlanetTatooine: Planet {
    func accept(visitor: PlanetVisitor) { visitor.visit(planet: self) }
}

class NameVisitor: PlanetVisitor {
    var name = ""

    func visit(planet _: PlanetAlderaan) { name = "Alderaan" }
    func visit(planet _: PlanetCoruscant) { name = "Coruscant" }
    func visit(planet _: PlanetTatooine) { name = "Tatooine" }
    func visit(planet _: MoonJedah) { name = "Jedah" }
}

let planets: [Planet] = [PlanetAlderaan(), PlanetCoruscant(), PlanetTatooine(), MoonJedah()]

let names = planets.map { (planet: Planet) -> String in
    let visitor = NameVisitor()
    planet.accept(visitor: visitor)
    return visitor.name
}

print(names)
