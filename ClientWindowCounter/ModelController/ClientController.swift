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
    func createClient(name: String, address: String) {
        let newClient = Client(name: name, address: address)
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
    func editClient(client: Client, name: String, address: String) {
        client.name = name
        client.address = address
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
