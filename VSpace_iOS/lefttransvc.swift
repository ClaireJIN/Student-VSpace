//
//  lefttransvc.swift
//  VSpace_iOS
//
//  Created by 李昂 on 15/8/9.
//  Copyright (c) 2015年 Obisoft Inc. All rights reserved.
//

import UIKit

enum LeftMenu: Int {
    case Main = 0
    case NEUIPGW
    case CheckQ
    case Missing
    case ChkGrade
    case LoveWall
    case SheTuan
    case Settings
}

protocol LeftMenuProtocol : class {
    func changeViewController(menu: LeftMenu)
}

class lefttransvc: UITableViewController, LeftMenuProtocol {
    var menus = ["Home", "NEU IPGW", "Traffic Query", "Lost and Found", "Query Scores", "Love Wall", "School Community", "Settings"]
    // 定义所有跳转的 Navigation Controller
    var _MainViewController:UIViewController!
    var _NEUIPGWViewController:UIViewController!
    var _CheckQViewController:UIViewController!
    var _MissingViewController:UIViewController!
    var _CheckGradeViewController:UIViewController!
    var _LoveWallViewController:UIViewController!
    var _SheTuanViewController:UIViewController!
    var _SettingsViewController:UIViewController!
    
    // 从 SlideMenuControllerSwift 第三方库扒来的，不知道什么用
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //定义 Navigation Controller 与 Storyboard 关联
        var sb1:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        self._NEUIPGWViewController=sb1.instantiateViewControllerWithIdentifier("NEUIPGWViewController") as! UIViewController
        self._CheckQViewController=sb1.instantiateViewControllerWithIdentifier("CheckQViewController") as! UIViewController
        self._MissingViewController=sb1.instantiateViewControllerWithIdentifier("MissingViewController") as! UIViewController
        self._CheckGradeViewController=sb1.instantiateViewControllerWithIdentifier("CheckGradeViewController") as! UIViewController
        self._LoveWallViewController=sb1.instantiateViewControllerWithIdentifier("LoveWallViewController") as! UIViewController
        self._SheTuanViewController=sb1.instantiateViewControllerWithIdentifier("SheTuanViewController") as! UIViewController
        self._SettingsViewController=sb1.instantiateViewControllerWithIdentifier("SettingsViewController") as! UIViewController
        self.tableView.registerCellClass(BaseTableViewCell.self)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: BaseTableViewCell = BaseTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: BaseTableViewCell.identifier)
        cell.textLabel?.font = UIFont.italicSystemFontOfSize(18)
        cell.textLabel?.textColor = UIColor.blackColor()
        // Configure the cell...
        cell.textLabel?.text = menus[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.item) {
            self.changeViewController(menu)
        }
    }
    
    func changeViewController(menu: LeftMenu) {
        switch menu {
        case .Main:
            self.slideMenuController()?.changeMainViewController(self._MainViewController, close: true)
        case .NEUIPGW:
            self.slideMenuController()?.changeMainViewController(self._NEUIPGWViewController, close: true)
        case .CheckQ:
            self.slideMenuController()?.changeMainViewController(self._CheckQViewController, close: true)
        case .Missing:
            self.slideMenuController()?.changeMainViewController(self._MissingViewController, close: true)
        case .ChkGrade:
            self.slideMenuController()?.changeMainViewController(self._CheckGradeViewController, close: true)
        case .LoveWall:
            self.slideMenuController()?.changeMainViewController(self._LoveWallViewController, close: true)
        case .SheTuan:
            self.slideMenuController()?.changeMainViewController(self._SheTuanViewController, close: true)
        case .Settings:
            self.slideMenuController()?.changeMainViewController(self._SettingsViewController, close: true)
        default:
            break
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
