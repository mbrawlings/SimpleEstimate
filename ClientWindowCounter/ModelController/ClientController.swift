//
//  ClientController.swift
//  ClientWindowCounter
//
//  Created by Matthew Rawlings on 10/7/22.
//

import CoreData

class ClientController {
    static let shared = ClientController()
    
    private init() {
        fetchClients()
    }
    
    var clients: [Client] = []
    
    private lazy var fetchRequest: NSFetchRequest<Client> = {
        let request = NSFetchRequest<Client>(entityName: "Client")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    //CRUD
    func createClient(name: String, streetAddress: String, cityAddress: String, stateAddress: String, phoneNumber: Int64) {
        let newClient = Client(name: name, streetAddress: streetAddress, cityAddress: cityAddress, stateAddress: stateAddress, phoneNumber: phoneNumber)
        clients.append(newClient)
        CoreDataStack.saveContext()
    }
    func fetchClients() {
        var clients = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []
        clients.sort { lhs, rhs in
            guard let lhsName = lhs.name,
                  let rhsName = rhs.name
            else { return true }
            return lhsName.lowercased() < rhsName.lowercased()
        }
        self.clients = clients
    }
    func editClient(client: Client, name: String, streetAddress: String, cityAddress: String, stateAddress: String, phoneNumber: Int64) {
        client.name = name
        client.streetAddress = streetAddress
        client.cityAddress = cityAddress
        client.stateAddress = stateAddress
        client.phoneNumber = phoneNumber
        CoreDataStack.saveContext()
        fetchClients()
    }
    func deleteClient(client: Client) {
        guard let index = clients.firstIndex(of: client) else { return }
        clients.remove(at: index)
        CoreDataStack.context.delete(client)
        CoreDataStack.saveContext()
        fetchClients()
    }
}
