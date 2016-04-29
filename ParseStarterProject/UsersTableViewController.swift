//
//  UsersTableViewController.swift
//  Instagram
//
//  Created by Adrian Ortiz Martinez on 4/28/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class UsersTableViewController: UITableViewController {

    var users = [String]()
    var following = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let followingQuery = PFQuery(className:"followers")
        followingQuery.whereKey("follower", equalTo:(PFUser.currentUser()?.username)!)
        followingQuery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if let followingPeople = objects as? [PFUser] {
                    
                    // Consultar datos
                    let query = PFUser.query()
                    query?.findObjectsInBackgroundWithBlock({ (objects:[AnyObject]?, error:NSError?) in
                        // vaciar
                        self.users.removeAll(keepCapacity: true)
                        
                        for object in objects! {
                            let user:PFUser = object as! PFUser
                            
                            // Evitar que se muestre mi usuario
                            if user.username != PFUser.currentUser()?.username {
                                self.users.append(user.username!)
                                
                                var isFollowing:Bool = false
                                
                                for followingPerson in followingPeople {
                                    if followingPerson["following"] as? String == user.username {
                                        isFollowing = true
                                    }
                                }
                                
                                self.following.append(isFollowing)
                            }
                        }
                        
                        // volver a cargar la vista
                        self.tableView.reloadData()
                    })
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.users.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        cell.textLabel?.text = self.users[indexPath.row]
        
        if following[indexPath.row] {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }

        return cell
    }
    
    // Seguir a un usuario
    // Ejecuta cuando se selecciona una fila de la tabla
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        if cell.accessoryType == UITableViewCellAccessoryType.Checkmark {
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            let query = PFQuery(className:"followers")
            query.whereKey("follower", equalTo:(PFUser.currentUser()?.username)!)
            query.whereKey("following", equalTo: (cell.textLabel?.text)!)
            query.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    if let objects = objects {
                        for object in objects {
                            object.deleteInBackgroundWithBlock(nil)
                        }
                    }
                } else {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
            }
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            let following = PFObject(className: "followers")
            following["following"] = cell.textLabel?.text
            following["follower"] = PFUser.currentUser()?.username
            following.saveInBackgroundWithBlock(nil)
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
