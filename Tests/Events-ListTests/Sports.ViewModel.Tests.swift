import XCTest
@testable import Events_List

final class SportsViewModelTests: XCTestCase {
    typealias SportDomain = Feature.Domain.Sport
    typealias SportAPI = Feature.API.Sport
    
    let mockRepository = MockRepository()
    lazy var viewmodel = SportDomain.ViewModel(repository: mockRepository)
    
    func testLoad() {
        let testRepository = MockRepository()
        let viewmodel = SportDomain.ViewModel(repository: testRepository)
        
        XCTAssertEqual(viewmodel.sports.count, 7)
    }
    
    func testMapping() {
        XCTAssertNoThrow(try SportAPI.fixtureResponse())
    }
    
    func testClosedSectionShouldReturnZeroRows() {
        _ = viewmodel.toggleEvents(for: 0)
        XCTAssertEqual(viewmodel.showEvents(in: 0), 0)
    }
    
    func testTitleReturnsSoccerForSectionZero() {
        XCTAssertEqual(viewmodel.title(for: 0), "SOCCER")
    }
    
    func testInvalidSectionReturnsNil() {
        XCTAssertEqual(viewmodel.title(for: 999), nil)
    }
    
    func testEventsForTableTennisReturnsTwo() {
        XCTAssertEqual(viewmodel.events(for: 3).count, 2)
    }
    
    func testAddingAFavorite() {
        let testID = "32839802"
        viewmodel.updateEvent(favourite: true, id: testID)
        XCTAssertTrue(viewmodel.favourites.contains(testID))
    }
    
    func testAddingAFavoriteMovesItToTheBeginning() {
        let testID = "31798507"
        viewmodel.updateEvent(favourite: true, id: testID)
        let events = viewmodel.events(for: 0)
        XCTAssertEqual(events.first?.id, testID)
    }
    
    func testAddingAFavoriteTwiceDoesNotResultInDuplicate() {
        let testID = "32839802"
        viewmodel.updateEvent(favourite: true, id: testID)
        viewmodel.updateEvent(favourite: true, id: testID)
        XCTAssertEqual(viewmodel.favourites.filter{ $0 == testID}.count, 1)
    }
    
    func testRemovingAFavorite() {
        let testID = "32839802"
        viewmodel.updateEvent(favourite: true, id: testID)
        viewmodel.updateEvent(favourite: false, id: testID)
        XCTAssertEqual(viewmodel.favourites.filter{ $0 == testID}.count, 0)
    }
    
    func testOpenSectionReturnsTrue() {
        XCTAssertTrue(viewmodel.toggleEvents(for: 0))
    }
    
    func testCloseSectionReturnFalse() {
        // opem
        _ = viewmodel.toggleEvents(for: 0)
        
        XCTAssertFalse(viewmodel.toggleEvents(for: 0))
    }
    
    func testCallingToggleEventsTwiceEndOpen() {
        // open (true)
        _ = viewmodel.toggleEvents(for: 0)
        
        // close (false)
        _ = viewmodel.toggleEvents(for: 0)
        
        // open again (true)
        XCTAssertTrue(viewmodel.toggleEvents(for: 0))
    }
}

class MockRepository: SportsRepository {
    typealias Sport = Feature.API.Sport
    
    override func fetch(_ completion: @escaping ([Sport]?, Error?) -> Void) {
        let results = try? Sport.fixtureResponse()
        completion(results, nil)
    }
}

extension Feature.API.Sport {
    typealias Sport = Feature.API.Sport
    
    fileprivate static func fixtureResponse() throws -> [Sport] {
        guard let data = fixtureList.data(using: .utf8) else { throw NSError(domain: "mapping.test", code: 400) }
        return try JSONDecoder().decode([Sport].self, from: data)
    }
    
    fileprivate static var fixtureList: String { """
[{
    "i": "FOOT",
    "d": "SOCCER",
    "e": [{
        "d": "Panserraikos - Niki Volos",
        "i": "32836151",
        "si": "FOOT",
        "sh": "Panserraikos - Niki Volos",
        "tt": 1681795200
    }, {
        "d": "Apollon Smyrnis - OF Ierapetra",
        "i": "32839802",
        "si": "FOOT",
        "sh": "Apollon Smyrnis - OF Ierapetra",
        "tt": 1681192740
    }, {
        "d": "Bristol City U21 - Nottingham Forest U21",
        "i": "32888598",
        "si": "FOOT",
        "sh": "Bristol City U21 - Nottingham Forest U21",
        "tt": 1683887700
    }, {
        "d": "Usm Alger - HB Chelghoum Laid",
        "i": "32746123",
        "si": "FOOT",
        "sh": "Usm Alger - HB Chelghoum Laid",
        "tt": 1685567580
    }, {
        "d": "Botev Plovdiv II - CSKA 1948 II",
        "i": "32888211",
        "si": "FOOT",
        "sh": "Botev Plovdiv II - CSKA 1948 II",
        "tt": 1680421260
    }, {
        "d": "PFC Ludogorets Razgrad II - FC Litex Lovech",
        "i": "32888213",
        "si": "FOOT",
        "sh": "PFC Ludogorets Razgrad II - FC Litex Lovech",
        "tt": 1685736720
    }, {
        "d": "Mohun Bagan AC - Hyderabad FC",
        "i": "32697530",
        "si": "FOOT",
        "sh": "Mohun Bagan AC - Hyderabad FC",
        "tt": 1681366500
    }, {
        "d": "Ironi Bnei Kabul - Hapoel Ironi Arraba",
        "i": "32922885",
        "si": "FOOT",
        "sh": "Ironi Bnei Kabul - Hapoel Ironi Arraba",
        "tt": 1681918740
    }, {
        "d": "AS Roma U19 - Empoli U19",
        "i": "32842091",
        "si": "FOOT",
        "sh": "AS Roma U19 - Empoli U19",
        "tt": 1683553380
    }, {
        "d": "Al Shamal - Umm Salal",
        "i": "31798506",
        "si": "FOOT",
        "sh": "Al Shamal - Umm Salal",
        "tt": 1683199860
    }, {
        "d": "Al-Ahli Doha - Qatar SC",
        "i": "31798507",
        "si": "FOOT",
        "sh": "Al-Ahli Doha - Qatar SC",
        "tt": 1684711140
    }, {
        "d": "FC Envigado II - Ferrovalvulas",
        "i": "32945070",
        "si": "FOOT",
        "sh": "FC Envigado II - Ferrovalvulas",
        "tt": 1685393280
    }, {
        "d": "Al Salibikhaet - AL Shabab",
        "i": "32945112",
        "si": "FOOT",
        "sh": "Al Salibikhaet - AL Shabab",
        "tt": 1679315040
    }, {
        "d": "Khaitan - Yarmouk",
        "i": "32945113",
        "si": "FOOT",
        "sh": "Khaitan - Yarmouk",
        "tt": 1682223120
    }, {
        "d": "NK Kustosija - Jarun",
        "i": "32688035",
        "si": "FOOT",
        "sh": "NK Kustosija - Jarun",
        "tt": 1685797260
    }, {
        "d": "Kelantan United - Kedah",
        "i": "32774482",
        "si": "FOOT",
        "sh": "Kelantan United - Kedah",
        "tt": 1680221280
    }, {
        "d": "FK Iskra Danilovgrad - Jezero Plav",
        "i": "32160243",
        "si": "FOOT",
        "sh": "FK Iskra Danilovgrad - Jezero Plav",
        "tt": 1684783620
    }, {
        "d": "FC Sheriff Tiraspol - FC Balti",
        "i": "32717732",
        "si": "FOOT",
        "sh": "FC Sheriff Tiraspol - FC Balti",
        "tt": 1684270260
    }, {
        "d": "Muscat - Ibri",
        "i": "32945111",
        "si": "FOOT",
        "sh": "Muscat - Ibri",
        "tt": 1683505320
    }, {
        "d": "Agmk FK - FC Bunyodkor Tashkent",
        "i": "32917527",
        "si": "FOOT",
        "sh": "Agmk FK - FC Bunyodkor Tashkent",
        "tt": 1682471880
    }, {
        "d": "Danubio FC II - CA Cerro II",
        "i": "32888556",
        "si": "FOOT",
        "sh": "Danubio FC II - CA Cerro II",
        "tt": 1687181220
    }, {
        "d": "Hamilton Academical II - Partick Thistle II",
        "i": "32917558",
        "si": "FOOT",
        "sh": "Hamilton Academical II - Partick Thistle II",
        "tt": 1682570400
    }, {
        "d": "Malmo FF U21 - Trelleborgs FF U21",
        "i": "32922860",
        "si": "FOOT",
        "sh": "Malmo FF U21 - Trelleborgs FF U21",
        "tt": 1684910400
    }, {
        "d": "Mjallby AIF U21 - Kalmar FF U21",
        "i": "32922884",
        "si": "FOOT",
        "sh": "Mjallby AIF U21 - Kalmar FF U21",
        "tt": 1681488240
    }, {
        "d": "Ihefu FC - Azam FC",
        "i": "32688084",
        "si": "FOOT",
        "sh": "Ihefu FC - Azam FC",
        "tt": 1679485620
    }, {
        "d": "AC Milan (Hermanito) (Esports) - RB Leipzig (Jekos) (Esports)",
        "i": "32922471",
        "si": "FOOT",
        "sh": "AC Milan (Hermanito) (Esports) - RB Leipzig (Jekos) (Esports)",
        "tt": 1681891560
    }, {
        "d": "Borussia Dortmund (Gaga) (Esports) - SSC Napoli (Duka) (Esports)",
        "i": "32922494",
        "si": "FOOT",
        "sh": "Borussia Dortmund (Gaga) (Esports) - SSC Napoli (Duka) (Esports)",
        "tt": 1684615320
    }, {
        "d": "Argentina (Taz) (Esports) - France (Drduca) (Esports)",
        "i": "32922228",
        "si": "FOOT",
        "sh": "Argentina (Taz) (Esports) - France (Drduca) (Esports)",
        "tt": 1685496120
    }, {
        "d": "Portugal (Rodja) (Esports) - Brazil (Perapanamera) (Esports)",
        "i": "32922232",
        "si": "FOOT",
        "sh": "Portugal (Rodja) (Esports) - Brazil (Perapanamera) (Esports)",
        "tt": 1686415080
    }, {
        "d": "Brazil (Perapanamera) (Esports) - Argentina (Taz) (Esports)",
        "i": "32922225",
        "si": "FOOT",
        "sh": "Brazil (Perapanamera) (Esports) - Argentina (Taz) (Esports)",
        "tt": 1679627100
    }, {
        "d": "England (Djole42) (Esports) - Portugal (Rodja) (Esports)",
        "i": "32922253",
        "si": "FOOT",
        "sh": "England (Djole42) (Esports) - Portugal (Rodja) (Esports)",
        "tt": 1685549160
    }, {
        "d": "Netherlands (Myxlunka) (Esports) - England (Gil_24) (Esports)",
        "i": "32922586",
        "si": "FOOT",
        "sh": "Netherlands (Myxlunka) (Esports) - England (Gil_24) (Esports)",
        "tt": 1680133500
    }, {
        "d": "France (Harsen) (Esports) - England (Gil_24) (Esports)",
        "i": "32922581",
        "si": "FOOT",
        "sh": "France (Harsen) (Esports) - England (Gil_24) (Esports)",
        "tt": 1682786940
    }, {
        "d": "Atletico Madrid (Danny) (Esports) - Real Sociedad (Nazario) (Esports)",
        "i": "32925194",
        "si": "FOOT",
        "sh": "Atletico Madrid (Danny) (Esports) - Real Sociedad (Nazario) (Esports)",
        "tt": 1682013240
    }, {
        "d": "Real Betis (Cantona) (Esports) - FC Barcelona (Nasmi) (Esports)",
        "i": "32944548",
        "si": "FOOT",
        "sh": "Real Betis (Cantona) (Esports) - FC Barcelona (Nasmi) (Esports)",
        "tt": 1687922040
    }]
}, {
    "i": "BASK",
    "d": "BASKETBALL",
    "e": [{
        "d": "Miami Heat (Bumblebee) - Cleveland Cavaliers (Purple_Boy)",
        "i": "32920621",
        "si": "BASK",
        "sh": "Miami Heat (Bumblebee) - Cleveland Cavaliers (Purple_Boy)",
        "tt": 1679347020
    }]
}, {
    "i": "TENN",
    "d": "TENNIS",
    "e": [{
        "d": "Kimmer Coppejans - Zsombor Piros",
        "i": "32895105",
        "si": "TENN",
        "sh": "Kimmer Coppejans - Zsombor Piros",
        "tt": 1682508900
    }, {
        "d": "Artem Khuda - Louroi Martinez",
        "i": "32921746",
        "si": "TENN",
        "sh": "Artem Khuda - Louroi Martinez",
        "tt": 1682699040
    }, {
        "d": "Takuya Kumasaka - Iacopo Sada",
        "i": "32921676",
        "si": "TENN",
        "sh": "Takuya Kumasaka - Iacopo Sada",
        "tt": 1683749400
    }, {
        "d": "Berk Ilkel - Gianrocco de Filippo",
        "i": "32921671",
        "si": "TENN",
        "sh": "Berk Ilkel - Gianrocco de Filippo",
        "tt": 1683472020
    }, {
        "d": "Paul Cayre - Tristan Dumas",
        "i": "32922929",
        "si": "TENN",
        "sh": "Paul Cayre - Tristan Dumas",
        "tt": 1680860640
    }, {
        "d": "Nikolay Vylegzhanin - Mathis Bondaz",
        "i": "32922930",
        "si": "TENN",
        "sh": "Nikolay Vylegzhanin - Mathis Bondaz",
        "tt": 1687989480
    }, {
        "d": "Jan Sebesta - Mischa Lanz",
        "i": "32922939",
        "si": "TENN",
        "sh": "Jan Sebesta - Mischa Lanz",
        "tt": 1682602980
    }, {
        "d": "Noah Lopez - Henry Bernet",
        "i": "32922947",
        "si": "TENN",
        "sh": "Noah Lopez - Henry Bernet",
        "tt": 1683433020
    }, {
        "d": "Laurin Aerne - Maximilian Figl",
        "i": "32922934",
        "si": "TENN",
        "sh": "Laurin Aerne - Maximilian Figl",
        "tt": 1685469420
    }, {
        "d": "Gabriel Tacanho - Tomas Vaise",
        "i": "32921938",
        "si": "TENN",
        "sh": "Gabriel Tacanho - Tomas Vaise",
        "tt": 1681983720
    }, {
        "d": "Jesse Flores - Ren Nakamura",
        "i": "32941561",
        "si": "TENN",
        "sh": "Jesse Flores - Ren Nakamura",
        "tt": 1684393680
    }, {
        "d": "Jean-Christian Morandais - Joe Tyler",
        "i": "32941599",
        "si": "TENN",
        "sh": "Jean-Christian Morandais - Joe Tyler",
        "tt": 1683102780
    }, {
        "d": "Chad Kissell - Andre Szilvassy",
        "i": "32941775",
        "si": "TENN",
        "sh": "Chad Kissell - Andre Szilvassy",
        "tt": 1684406160
    }, {
        "d": "Federica Rossi - Linda Salvi",
        "i": "32946199",
        "si": "TENN",
        "sh": "Federica Rossi - Linda Salvi",
        "tt": 1687668420
    }, {
        "d": "Vladislava Andreevskaya - Virginia Ferrara",
        "i": "32921926",
        "si": "TENN",
        "sh": "Vladislava Andreevskaya - Virginia Ferrara",
        "tt": 1679399640
    }, {
        "d": "Polina Bakhmutkina - Karolina Mrazikova",
        "i": "32921932",
        "si": "TENN",
        "sh": "Polina Bakhmutkina - Karolina Mrazikova",
        "tt": 1682397720
    }, {
        "d": "Sara Suchankova - Kseniia Piskareva",
        "i": "32921925",
        "si": "TENN",
        "sh": "Sara Suchankova - Kseniia Piskareva",
        "tt": 1685891040
    }, {
        "d": "Viktoriia Dema - Koharu Niimi",
        "i": "32921927",
        "si": "TENN",
        "sh": "Viktoriia Dema - Koharu Niimi",
        "tt": 1683955740
    }, {
        "d": "Jimar Geraldine Gerald Gonzalez - Iva Sepa",
        "i": "32921929",
        "si": "TENN",
        "sh": "Jimar Geraldine Gerald Gonzalez - Iva Sepa",
        "tt": 1687654440
    }, {
        "d": "Celine Simunyu - Elif Tuana Gunal",
        "i": "32921930",
        "si": "TENN",
        "sh": "Celine Simunyu - Elif Tuana Gunal",
        "tt": 1684639740
    }, {
        "d": "Danique Havermans - Madelief Hageman",
        "i": "32921936",
        "si": "TENN",
        "sh": "Danique Havermans - Madelief Hageman",
        "tt": 1679922240
    }, {
        "d": "Guillermina Naya - Martina Maria Bovio",
        "i": "32943082",
        "si": "TENN",
        "sh": "Guillermina Naya - Martina Maria Bovio",
        "tt": 1683159960
    }, {
        "d": "Ani Vangelova - Susan Doldan",
        "i": "32887145",
        "si": "TENN",
        "sh": "Ani Vangelova - Susan Doldan",
        "tt": 1687041000
    }, {
        "d": "Daniel Dutra Da Silva - Jose Pereira",
        "i": "32920374",
        "si": "TENN",
        "sh": "Daniel Dutra Da Silva - Jose Pereira",
        "tt": 1682843880
    }, {
        "d": "Gonzalo Villanueva - Wilson Leite",
        "i": "32923501",
        "si": "TENN",
        "sh": "Gonzalo Villanueva - Wilson Leite",
        "tt": 1687286940
    }, {
        "d": "Gustavo Heide - Orlando Luz",
        "i": "32922767",
        "si": "TENN",
        "sh": "Gustavo Heide - Orlando Luz",
        "tt": 1680071580
    }]
}, {
    "i": "TABL",
    "d": "TABLE TENNIS",
    "e": [{
        "d": "Anton Limonov - Dauud Cheaib",
        "i": "32919714",
        "si": "TABL",
        "sh": "Anton Limonov - Dauud Cheaib",
        "tt": 1688029860
    }, {
        "d": "Zbynek Vyskocil - Jaroslav Zamyslicky",
        "i": "32924083",
        "si": "TABL",
        "sh": "Zbynek Vyskocil - Jaroslav Zamyslicky",
        "tt": 1681010820
    }]
}, {
    "i": "ESPS",
    "d": "ESPORTS",
    "e": [{
        "d": "Monaspa - Ooredoo Thunders",
        "i": "32836153",
        "si": "ESPS",
        "sh": "Monaspa - Ooredoo Thunders",
        "tt": 1683715260
    }, {
        "d": "HEET - ex-Bluejays",
        "i": "32941184",
        "si": "ESPS",
        "sh": "HEET - ex-Bluejays",
        "tt": 1680921240
    }]
}, {
    "i": "HAND",
    "d": "HANDBALL",
    "e": [{
        "d": "Uskudar (W) - Tekirdag SK (W)",
        "i": "32923599",
        "si": "HAND",
        "sh": "Uskudar (W) - Tekirdag SK (W)",
        "tt": 1681936620
    }, {
        "d": "Al Kuwait SC - Al Safa",
        "i": "32921897",
        "si": "HAND",
        "sh": "Al Kuwait SC - Al Safa",
        "tt": 1682841960
    }]
}, {
    "i": "BCHV",
    "d": "BEACH VOLLEYBALL",
    "e": [{
        "d": "O.Klishch/M.Stepanov - I.Kobylianskyi/O.Kulyk",
        "i": "32924643",
        "si": "BCHV",
        "sh": "O.Klishch/M.Stepanov - I.Kobylianskyi/O.Kulyk",
        "tt": 1685233740
    }]
}]
"""
    }
}
