var appHelp = angular.module("appHelpPage", []);
function headerController($http, $scope) {
    $scope.notificacion = {
        idMensaje: "",
        mensaje: "",
        sender: "",
        receiver: "",
        leido: "",
        fecha: "",
        titulo: ""
    };
    //Obtener Lista de notificaciones
    $http.get("../header/getMessages").then(function (data) {
        $scope.allNotificaciones = data.data.data;
    });
}
appHelp.controller("headerController", headerController);
appHelp.controller("helpPageController", function ($scope, $http) {
    
    //Obtener el listado de usuarios con rol Administrador
    $http.get("helpPage/getUsuariosAdministradores").then(function(data){
        $scope.usuariosAdmins = data.data.data;
    });
    
     $scope.notificacion = {
        idMensaje: "",
        mensaje: "",
        sender: "",
        receiver: "",
        leido: "",
        fecha: "",
        titulo: ""
    };

    //Obtener Lista de Autores
    $http.get("get").then(function (data) {
        $scope.allNotificaciones = data.data.data;
    });
});