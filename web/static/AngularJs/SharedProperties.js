/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var appSharedProperties = angular.module("AppSharedProperties", []);
appSharedProperties.service("sharedData", function () {
    this.data = "";
    this.getData = function () {
        return this.data;
    };
    this.setData = function (newData) {
        this.data = newData;
    };
});