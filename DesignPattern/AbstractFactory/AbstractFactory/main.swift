//
//  main.swift
//  AbstractFactory
//
//  Created by 伯驹 黄 on 2016/12/18.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import Foundation

protocol IUser {
    func insert(_ user: String)

    func getUser()
}

class SqlServerUser: IUser {
    func insert(_ user: String) {
        print("向sqlserver数据库插入用户:\(user)")
    }

    func getUser() {
        print("从sqlserver数据库获取到一条用户数据")
    }
}

class AccessUser: IUser {
    func insert(_ user: String) {
        print("向access数据库插入用户:\(user)")
    }

    func getUser() {
        print("从access数据库获取到一条用户数据")
    }
}

protocol IDepartment {
    func insert(_ department: String)

    func getDepartment()
}

class SqlServerDepartment: IDepartment {
    func insert(_ department: String) {
        print("向sqlserver数据库插入部门：\(department)")
    }

    func getDepartment() {
        print("从sqlserver数据库获取到一条部门数据")
    }
}

class AccessDepartment: IDepartment {
    func insert(_ department: String) {
        print("向AccessDepartment数据库插入部门：\(department)")
    }

    func getDepartment() {
        print("从Access数据库获取到一条部门数据")
    }
}

protocol IFactory {
    func createUser() -> IUser

    func createDepartment() -> IDepartment
}


class SqlServerFactory: IFactory {
    func createUser() -> IUser {
        return SqlServerUser()
    }

    func createDepartment() -> IDepartment {
        return SqlServerDepartment()
    }
}

class AccessFactory: IFactory {
    func createUser() -> IUser {
        return AccessUser()
    }

    func createDepartment() -> IDepartment {
        return AccessDepartment()
    }
}

var dbfactory: IFactory?

dbfactory = SqlServerFactory()

let user = dbfactory?.createUser()
let deparment = dbfactory?.createDepartment()

user?.insert("张三")
user?.getUser()
deparment?.insert("财务")
deparment?.getDepartment()
