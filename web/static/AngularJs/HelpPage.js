var appHelp = angular.module("appHelpPage", []);
appHelp.controller("helpPageController", function ($scope, $http) {
    
    //Obtener el listado de usuarios con rol Administrador
    $http.get("helpPage/getUsuariosAdministradores").then(function(data){
        $scope.usuariosAdmins = data.data.data;
    });
});