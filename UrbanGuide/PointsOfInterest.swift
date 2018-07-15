//
//  PointsOfInterest.swift
//  UrbanGuide
//

import CoreLocation

struct PointsOfInterest {

    private let points: [PointOfInterest]
    private let maxRange: Double = 1000

    func point(withId id: Int) -> PointOfInterest? {
        for point in points where point.id == id {
            return point
        }
        return nil
    }

    func near(_ location: CLLocation) -> [(data: PointOfInterest, distance: Double, bearing: Double)] {
        var pointsInRange = [(data: PointOfInterest, distance: Double, bearing: Double)]()
        for point in points {
            let distance = location.distance(from: point.location)
            guard distance >= 0 && distance <= maxRange else { continue }
            let bearing = location.bearing(to: point.location)
            pointsInRange.append((data: point, distance: distance, bearing: bearing))
        }
        return pointsInRange
    }

    init() {
        points = [
            PointOfInterest(
                id: 1,
                location: CLLocation(latitude: 53.426254, longitude: 14.560311),
                name: "Zamek Książąt Pomorskich",
                address: "Korsarzy 34, Szczecin",
                website: "https://zamek.szczecin.pl",
                description: "\"Renovated castle hosting art & history exhibitions plus classical concerts, some outdoors in summer.\" - Google",
                image: "zamek"
            ),
            PointOfInterest(
                id: 2,
                location: CLLocation(latitude: 53.429163, longitude: 14.557965),
                name: "Filharmonia",
                address: "Małopolska 48, 70-515 Szczecin",
                website: "https://filharmonia.szczecin.pl",
                description: "",
                image: "filharmonia"
            ),
            PointOfInterest(
                id: 3,
                location: CLLocation(latitude: 53.428479, longitude: 14.556741),
                name: "Brama Królewska",
                address: "plac Hołdu Pruskiego, Szczecin",
                website: "https://pl.wikipedia.org/wiki/Brama_Królewska_w_Szczecinie",
                description: "",
                image: "brama_krolewska"
            ),
            PointOfInterest(
                id: 4,
                location: CLLocation(latitude: 53.424964, longitude: 14.550531),
                name: "Brama Portowa",
                address: "Plac Brama Portowa, Szczecin",
                website: "https://pl.wikipedia.org/wiki/Brama_Portowa_w_Szczecinie",
                description: "",
                image: "brama_portowa"
            ),
            PointOfInterest(
                id: 5,
                location: CLLocation(latitude: 53.429705, longitude: 14.565963),
                name: "Wały Chrobrego",
                address: "Wały Chrobrego, Szczecin",
                website: "https://pl.wikipedia.org/wiki/Wały_Chrobrego",
                description: "",
                image: "waly_chrobrego"
            ),
            PointOfInterest(
                id: 6,
                location: CLLocation(latitude: 53.424601, longitude: 14.556139),
                name: "Bazylika archikatedralna Św. Jakuba Apostoła",
                address: "Św. Jakuba Apostoła 1, 70-543 Szczecin",
                website: "http://www.katedra.szczecin.pl",
                description: "",
                image: "katedra"
            ),
            PointOfInterest(
                id: 7,
                location: CLLocation(latitude: 53.426312, longitude: 14.562925),
                name: "Baszta Siedmiu Płaszczy",
                address: "Panieńska 47, Szczecin",
                website: "https://pl.wikipedia.org/wiki/Baszta_Panieńska",
                description: "",
                image: "baszta"
            ),
            PointOfInterest(
                id: 8,
                location: CLLocation(latitude: 53.446994, longitude: 14.492326),
                name: "Wydział Informatyki ZUT",
                address: "Żołnierska 49, Szczecin",
                website: "http://www.wi.zut.edu.pl",
                description: "Budynek 1",
                image: "wi1"
            ),
            PointOfInterest(
                id: 9,
                location: CLLocation(latitude: 53.448615, longitude: 14.491069),
                name: "Wydział Informatyki ZUT",
                address: "Żołnierska 52, 71-210 Szczecin",
                website: "http://www.wi.zut.edu.pl",
                description: "Budynek 2",
                image: "wi2"
            ),
            PointOfInterest(
                id: 10,
                location: CLLocation(latitude: 53.447665, longitude: 14.493075),
                name: "Wydział Ekonomiczny ZUT",
                address: "Żołnierska 47, Szczecin",
                website: "http://www.ekonomia.zut.edu.pl",
                description: "",
                image: "we"
            ),
            PointOfInterest(
                id: 11,
                location: CLLocation(latitude: 53.447013, longitude: 14.493440),
                name: "Instytut Geoinformatyki, Akademia Morska w Szczecinie",
                address: "Żołnierska 46, Szczecin",
                website: "http://ig.am.szczecin.pl",
                description: "",
                image: "am"
            ),
            PointOfInterest(
                id: 12,
                location: CLLocation(latitude: 53.447532, longitude: 14.491276),
                name: "Wydział Budownictwa i Architektury ZUT",
                address: "Żołnierska 50, 70-953 Szczecin",
                website: "http://www.wbia.zut.edu.pl",
                description: "",
                image: "wbia"
            ),
            PointOfInterest(
                id: 13,
                location: CLLocation(latitude: 53.448238, longitude: 14.493603),
                name: "Wydział Nauk o Zdrowiu PUM",
                address: "Żołnierska 48, Szczecin",
                website: "http://pum.edu.pl",
                description: "",
                image: "pum"
            ),
            PointOfInterest(
                id: 14,
                location: CLLocation(latitude: 53.449001, longitude: 14.491923),
                name: "Zachodniopomorska Szkoła Biznesu",
                address: "Żołnierska 53, 71-210 Szczecin",
                website: "http://zpsb.szczecin.pl",
                description: "",
                image: "zpsb"
            ),
            PointOfInterest(
                id: 15,
                location: CLLocation(latitude: 53.395823, longitude: 14.522544),
                name: "Point 1",
                address: "",
                website: "",
                description: "testing",
                image: ""
            ),
            PointOfInterest(
                id: 16,
                location: CLLocation(latitude: 53.397627, longitude: 14.525333),
                name: "Point 2",
                address: "",
                website: "",
                description: "testing",
                image: ""
            ),
            PointOfInterest(
                id: 17,
                location: CLLocation(latitude: 53.397109, longitude: 14.524904),
                name: "Point 3",
                address: "",
                website: "",
                description: "testing",
                image: ""
            ),
        ]
    }

}
