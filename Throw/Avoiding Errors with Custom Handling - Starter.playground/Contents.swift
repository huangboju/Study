/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

// ----------------------------------------------------------------------------
// Playground that includes Witches.
//
// These magical beings may be created and may cast spells on each other
// & their familiars (i.e. cats, bats, toads).
// ----------------------------------------------------------------------------

// Most objects in this tutorial need an avatar, to make things exciting.

// http://nshipster.cn/guard-and-defer/
// http://www.infocool.net/kb/Swift/201608/170758.html

protocol Avatar {
    var avatar: String { get }
}

enum MagicWords: String {
    case abracadbra = "abracadabra"
    case alakazam
    case hocusPocus = "hocus pocus"
    case prestoChango = "presto chango"
}

struct Spell {

    var magicWords: MagicWords = .abracadbra

    // If words are considered magical, we can create a spell
    init?(words: String) {
        guard let incantation = MagicWords(rawValue: words) else {
            return nil
        }
        magicWords = incantation
    }

    init?(magicWords: MagicWords) {
        self.magicWords = magicWords
    }
}

// ----------------------------------------------------------------------------
// Example Two - Avoiding Errors with Custom Handling - Pyramids of Doom
// ----------------------------------------------------------------------------

// Familiars

protocol Familiar: Avatar {
    var noise: String { get }
    var name: String? { get set }
    init(name: String?)
}

extension Familiar {
    func speak() {
        print(avatar, "* \(noise)s *", separator: " ", terminator: "")
    }
}

struct Cat: Familiar {
    var name: String?
    var noise = "purr"
    var avatar = "🐱"

    init(name: String?) {
        self.name = name
    }
}

struct Bat: Familiar {
    var name: String?
    var noise = "screech"
    var avatar = "[bat]" // Sadly there is no bat avatar

    init(name: String?) {
        self.name = name
    }

    func speak() {
        print(avatar, "* \(noise)es *", separator: " ", terminator: "")
    }
}

struct Toad: Familiar {
    init(name: String?) {
        self.name = name
    }

    var name: String?
    var noise = "croak"
    var avatar = "🐸"
}

// Magical Things

struct Hat {
    enum HatSize {
        case small
        case medium
        case large
    }

    enum HatColor {
        case black
    }

    var color: HatColor = .black
    var size: HatSize = .medium
    var isMagical = true
}

protocol Magical: Avatar {
    var name: String? { get set }
    var spells: [Spell] { get set }
    func turnFamiliarIntoToad() throws -> Toad
}

enum ChangoSpellError: Error {
    case hatMissingOrNotMagical
    case noFamiliar
    case familiarAlreadyAToad
    case spellFailed(reason: String)
    case spellNotKnownToWitch
}

struct Witch: Magical {
    var avatar = "👩🏻"
    var name: String?
    var familiar: Familiar?
    var spells: [Spell] = []
    var hat: Hat?

    func speak() {
        defer {
            print("*cackles*")
        }
        print("Hello my pretties.")
    }

    init(name: String?, familiar: Familiar?) {
        self.name = name
        self.familiar = familiar

        if let s = Spell(magicWords: .prestoChango) {
            spells = [s]
        }
    }

    init(name: String?, familiar: Familiar?, hat: Hat?) {
        self.init(name: name, familiar: familiar)
        self.hat = hat
    }

    func turnFamiliarIntoToad() throws -> Toad {
        guard let hat = hat, hat.isMagical else {
            throw ChangoSpellError.hatMissingOrNotMagical
        }
        // When have you ever seen a Witch perform a spell without her magical hat on ? :]
        // Check if witch has a familiar
        guard let familiar = familiar else {
            throw ChangoSpellError.noFamiliar
        }
        if familiar is Toad {
            throw ChangoSpellError.familiarAlreadyAToad
        }

        guard hasSpell(ofType: .prestoChango) else {
            throw ChangoSpellError.spellNotKnownToWitch
        }

        guard let name = familiar.name else {
            let reason = "Familiar doesn’t have a name."
            throw ChangoSpellError.spellFailed(reason: reason)
        }

        return Toad(name: name)
    }

    func hasSpell(ofType type: MagicWords) -> Bool { // Check if witch currently has an appropriate spell in their spellbook
        let change = spells.flatMap { spell in
            spell.magicWords == type
        }
        return change.count > 0
    }
}

func exampleOne() {
    print("") // 在调试区域添加一个空行

    // 1
    let salem = Cat(name: "Salem Saberhagen")
    salem.speak()

    // 2
    let witchOne = Witch(name: "Sabrina", familiar: salem)
    do {
        // 3
        try witchOne.turnFamiliarIntoToad()
    } catch let error as ChangoSpellError {
        handle(spellError: error)
    } catch {
        print("Something went wrong, are you feeling OK?")
    }
}

func handle(spellError error: ChangoSpellError) {
    let prefix = "Spell Failed."
    switch error {
    case .hatMissingOrNotMagical:
        print("\(prefix) Did you forget your hat, or does it need its batteries charged?")

    case .familiarAlreadyAToad:
        print("\(prefix) Why are you trying to change a Toad into a Toad?")

    default:
        print(prefix)
    }
}

func exampleTwo() {
    print("") // 在调试区域添加一个空行

    let toad = Toad(name: "Mr. Toad")
    toad.speak()

    let hat = Hat()
    let witchTwo = Witch(name: "Elphaba", familiar: toad, hat: hat)

    print("") // 在调试区域添加一个空行

    let newToad = try? witchTwo.turnFamiliarIntoToad()
    if newToad != nil { // Same logic as: if let _ = newToad
        print("Successfully changed familiar into toad.")
    } else {
        print("Spell failed.")
    }
}

func exampleThree() {
    print("") // Add an empty line in the debug area

    let witchThree = Witch(name: "Hermione", familiar: nil, hat: nil)
    witchThree.speak()
}

exampleThree()
