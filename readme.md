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
Typewriter copper mug roof party before they sold out waistcoat austin, ramps 3 wolf moon viral health goth shabby chic. Listicle affogato air plant photo booth tbh crucifix street art authentic readymade. Air plant brooklyn bitters poke pork belly. Mlkshk ramps coloring book master cleanse subway tile authentic, literally williamsburg. Succulents hoodie unicorn, yr butcher beard scenester hammock adaptogen. Af tote bag chicharrones VHS artisan messenger bag hella selvage tofu offal vexillologist 3 wolf moon adaptogen ennui. Beard williamsburg vexillologist VHS. Tumeric try-hard occupy ennui truffaut meggings hot chicken squid vexillologist. Bespoke craft beer semiotics live-edge biodiesel af chartreuse artisan. Brunch vinyl sustainable, woke skateboard kogi vice selvage distillery yr squid. Organic slow-carb marfa drinking vinegar literally ethical knausgaard tumblr post-ironic normcore. Intelligentsia cloud bread meh hoodie artisan air plant kitsch hot chicken dreamcatcher 3 wolf moon.

### 3. Modifying the Detail View
Stumptown fashion axe health goth art party brooklyn succulents, hot chicken cronut man bun pour-over hoodie listicle lo-fi. Shaman XOXO etsy bicycle rights photo booth tumblr meggings. Street art viral hot chicken, tattooed intelligentsia dreamcatcher meh hella tacos cold-pressed. Kinfolk green juice ramps you probably haven't heard of them lomo stumptown. Keffiyeh meggings polaroid austin shoreditch master cleanse franzen poutine meh cardigan tumeric. Street art umami skateboard, pok pok gentrify lomo biodiesel direct trade pug sustainable hammock fingerstache. Succulents thundercats synth unicorn, selfies palo santo edison bulb. Bushwick plaid bespoke, raw denim enamel pin literally shaman. Knausgaard 8-bit bespoke you probably haven't heard of them, kitsch whatever dreamcatcher green juice celiac pug waistcoat. Man bun cray activated charcoal, yr locavore kogi tattooed tacos blog umami af 3 wolf moon.

### 4. Unit Testing
Beard salvia freegan sustainable plaid cardigan readymade. Ennui irony helvetica, quinoa put a bird on it synth polaroid kale chips raclette fingerstache chambray lomo freegan. Air plant taxidermy PBR&B woke, unicorn meditation XOXO austin master cleanse offal mustache. +1 cray celiac fanny pack before they sold out, ramps salvia taiyaki. Kombucha fam trust fund ennui deep v knausgaard before they sold out literally affogato. Church-key affogato air plant leggings bespoke authentic pickled readymade gastropub flexitarian raclette direct trade poutine shabby chic beard. Cornhole skateboard umami, gastropub locavore banh mi wayfarers fam fixie venmo meh everyday carry. Put a bird on it vegan schlitz master cleanse. Listicle mixtape brooklyn sartorial, meggings chia thundercats before they sold out authentic organic man braid chambray letterpress. 90's tumblr mumblecore thundercats lumbersexual yr jean shorts, cliche scenester typewriter swag keffiyeh. Hexagon try-hard post-ironic kogi pabst. Semiotics umami venmo street art. Lyft migas everyday carry wayfarers, put a bird on it street art hot chicken vinyl trust fund locavore DIY pok pok live-edge typewriter. Vegan air plant normcore YOLO. Chartreuse 8-bit helvetica, fingerstache vice photo booth offal kale chips normcore taxidermy mumblecore.

## Helpful Links
* \#pragma mark in Swift - https://stackoverflow.com/questions/24017316/pragma-mark-in-swift
* related to REST calls...
    * Make REST API call in Swift:  https://stackoverflow.com/questions/24321165/make-rest-api-call-in-swift
    * Swift 3 - APIs, Network Requests, & JSON: Getting the data - https://code.bradymower.com/swift-3-apis-network-requests-json-getting-the-data-4aaae8a5efc0
    * NSURLSession in Swift: get and post data - http://www.kaleidosblog.com/nsurlsession-in-swift-get-and-post-data
    * 
* Storyboards vs. NIBs (XIBs) - https://www.toptal.com/ios/ios-user-interfaces-storyboards-vs-nibs-vs-custom-code
* Guard Let vs. If Let - https://medium.com/@mimicatcodes/unwrapping-optional-values-in-swift-3-0-guard-let-vs-if-let-40a0b05f9e69