var appLoginHelp = angular.module("appLoginHelpPage", ['angular-loading-bar']);
appLoginHelp.controller("LoginHelpPageController", function ($scope, $http) {
    //Obtener el listado de usuarios con rol Administrador
    $http.get("../helpPage/getUsuariosAdministradores").then(function(data){
        $scope.usuariosAdmins = data.data.data;
    });
    //Obtener el listado de usuarios con rol Editor
    $http.get("../helpPage/getUsuariosEditores").then(function(data){
        $scope.usuariosEditores = data.data.data;
    });
});