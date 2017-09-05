//
//  MasterViewController.swift
//  habhyglite
//
//  Created by Brian Lanham on 8/18/17.
//  Copyright © 2017 Brian Lanham. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var busySignal: UIActivityIndicatorView!

    var detailViewController: DetailViewController? = nil
    @IBOutlet weak var busyView: UIView!
    var managedObjectContext: NSManagedObjectContext? = nil


    override func viewDidLoad() {
        super.viewDidLoad()
        self.busyView.isHidden = true

        self.load()
        
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem

//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
//        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(_ sender: Any) {
        let context = self.fetchedResultsController.managedObjectContext
        let newEvent = Event(context: context)
             
        // If appropriate, configure the new managed object.
        newEvent.timestamp = NSDate()

        // Save the context.
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    // MARK: - Custom
    
    var stellarData: [StarData]?
    var isLoading: Bool = true
    
    func load() {
        self.showBusy()
        let request = NSMutableURLRequest(url: NSURL(string: "http://dmapi.loticfactor.com/api/HabHyg_Lite/")! as URL)
        let session = URLSession.shared
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
//            print (data!)
//            print (response!)
//            print (error!)
            if error != nil {
                print("Error: \(String(describing: error))")
            } else {
//                let parsedStars: [StarData] = self.parseJson(from: data!)
                self.stellarData = [StarData]()
                self.stellarData?.append(contentsOf: self.parseJson(from: data!))
                self.title = String("\(self.stellarData?.count ?? 0) Stars")
                self.editButtonItem.isEnabled = false
                //                for star:StarData in parsedStars {
//                    print (star.ProperName)
//                    self.stellarData?.append(star)
//                }
//                print("Response: \(String(describing: parsedJson))")
//                print("Response: \(String(describing: data))")
//                self.stellarData = [StarData]()
//                for i: Int in 0 ..< 100 {
//                    let sd: StarData = StarData()
//                    sd.ProperName = "PN: \(i)" //String(describing: i)
//                    self.stellarData?.append(sd)
//                }
//                for sd:StarData in self.stellarData! {
//                    print(sd.ProperName)
//                }
//                func refreshUI() { DispatchQueue.main.async { self.tableView!.reloadData() } }
                self.tableView!.reloadData()
                self.hideBusy()
//                if (self.tableView != nil) {
//                    self.tableView!.reloadData()
//                }
            }
        })
        
        task.resume()
        
    }
    
    func parseJson(from data: Data) -> [StarData] {
        var stars = [StarData]()
        do {
            if let jsonResult = try JSONSerialization.jsonObject(with: data) as? [[String:Any]] {
                for jsonStar in jsonResult {
                    var pn: String = String(describing: jsonStar["ProperName"]!)
                    pn = pn.trimmingCharacters(in: .whitespacesAndNewlines)
                    if pn.characters.count > 0 {
                        let star = StarData()
                        star.id = jsonStar["id"] as! Int
                        star.ProperName = jsonStar["ProperName"] as! String
                        star.CommonName = jsonStar["CommonName"] as! String
                        star.x = (jsonStar["x"] as? Float)!
                        star.y = jsonStar["y"] as! Float
                        star.z = jsonStar["z"] as! Float
                        star.DistanceInParsecs = jsonStar["DistanceInParsecs"] as! Float
                        stars.append(star)
//                        print ("\(pn) (\(pn.characters.count))")
                    }
                }
            } else {
                print("The value for key `people` is not an array or the key `people` does not exist")
            }
        } catch {
            print(error)
        }
        return stars
    }
    
    func showBusy() {
        self.busySignal.startAnimating()
        self.busyView.isHidden = false
    }
    
    func hideBusy() {
        self.busyView.removeFromSuperview()
        self.busyView.isHidden = true
        self.busySignal.stopAnimating()
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
//            let object = fetchedResultsController.object(at: indexPath)
            let object = self.stellarData![indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
//        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView::numberOfRowsInSection::\(section)")
        var result: Int = 0
        if self.stellarData != nil {
            print("\(self.stellarData!.count) stars")
            result = self.stellarData!.count
        }
        return result
//        let sectionInfo = fetchedResultsController.sections![section]
//        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableView::cellForRowAt::\(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let sd: StarData = self.stellarData![indexPath.row]
        print("rendering \(sd.ProperName)")
        cell.textLabel!.text = sd.ProperName
        
//        let event = fetchedResultsController.object(at: indexPath)
//        configureCell(cell, withEvent: event)
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = fetchedResultsController.managedObjectContext
            context.delete(fetchedResultsController.object(at: indexPath))
                
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func configureCell(_ cell: UITableViewCell, withEvent event: Event) {
        cell.textLabel!.text = event.timestamp!.description
    }

    // MARK: - Fetched results controller

    var fetchedResultsController: NSFetchedResultsController<Event> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
             // Replace this implementation with code to handle the error appropriately.
             // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             let nserror = error as NSError
             fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }    
    var _fetchedResultsController: NSFetchedResultsController<Event>? = nil

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
            case .insert:
                tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
            case .delete:
                tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
            default:
                return
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .insert:
                tableView.insertRows(at: [newIndexPath!], with: .fade)
            case .delete:
                tableView.deleteRows(at: [indexPath!], with: .fade)
            case .update:
                configureCell(tableView.cellForRow(at: indexPath!)!, withEvent: anObject as! Event)
            case .move:
                configureCell(tableView.cellForRow(at: indexPath!)!, withEvent: anObject as! Event)
                tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         tableView.reloadData()
     }
     */

}

