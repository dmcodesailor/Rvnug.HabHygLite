# HabHyg Lite - an iOS app for RVNUG

## Prerequisites
* Mac (preferably professional grade)
* XCode (and Swift) - https://developer.apple.com/develop/
* Patience (and maybe beer)

## TL;DR

## The D33tz

### 0. Lay the Foundation
Hipster Ipsum

### 1. Getting data from a REST API
hipster ipsum

#### List of Items 
```swift
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
```


#### Item Details
```swift
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
                        star.x = jsonStar["x"] as! Float
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
```

### 2. Adding an Activity Indicator
a;lsdkjf;aslkdjfas;ldkj

### 3. Modifying the Detail View
a;slkdjf;asdkljfas;dkljf

### 4. Graphics
a;slkdjfa;slkdjfas

### 5. Unit Testing
as;ldkjf;aslkdjfals;dkfa

## Helpful Links
* \#pragma mark in Swift - https://stackoverflow.com/questions/24017316/pragma-mark-in-swift
* related to REST calls...
    * Make REST API call in Swift:  https://stackoverflow.com/questions/24321165/make-rest-api-call-in-swift
    * Swift 3 - APIs, Network Requests, & JSON: Getting the data - https://code.bradymower.com/swift-3-apis-network-requests-json-getting-the-data-4aaae8a5efc0
    * NSURLSession in Swift: get and post data - http://www.kaleidosblog.com/nsurlsession-in-swift-get-and-post-data
    * 
* Storyboards vs. NIBs (XIBs) - https://www.toptal.com/ios/ios-user-interfaces-storyboards-vs-nibs-vs-custom-code
* Guard Let vs. If Let - https://medium.com/@mimicatcodes/unwrapping-optional-values-in-swift-3-0-guard-let-vs-if-let-40a0b05f9e69