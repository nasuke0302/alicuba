var appRoles = angular.module("AppRoles", []);
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
appRoles.controller("headerController", headerController);
appRoles.controller("RolesController", function ($scope, $http) {
    $scope.indiceRegistro =
            {
                idRoles: "",
                tipoRol: ""
            };
    //Obtener Listado de Roles
    $http.get("getRoles").then(function (data) {
        $scope.allRoles = data.data.data;
    });

    //Crear o Editar un Rol
    $scope.addOrEditRol = function () {
        $("#formModalCreateOrEdit").modal("toggle");
        if ($scope.indiceRegistro.idRoles === "") {
            $http.post("addRol", $scope.indiceRegistro, {}).then(function (r) {
                //Mostrar Mensaje o algo
            });
        } else {
            $http.post("editRol", $scope.indiceRegistro, {}).then(function (r) {
                //Mostrar Mensaje o algo
            });
        }
    };

    //Eliminar un Rol
    $scope.eliminarRol = function () {
         $("#formModalEliminar").modal("toggle");
        $http.post("deleteRol", $scope.indiceRegistro, {}).then(function (r) {
            //Mostrar Mensaje o algo
        });
    };

    //Enviar Rol al Modal Editar
    $scope.abrirEditarModal = function (indice) {
        var a = $scope.allRoles[indice];
        $scope.indiceRegistro = {
            idRoles: a.idRoles,
            tipoRol: a.tipoRol
        };
    };

    //Enviar Rol al Modal Eliminar
    $scope.abrirEliminarModal = function (indice) {
        var a = $scope.allRoles[indice];
        $scope.indiceRegistro = {
            idRoles: a.idRoles,
            tipoRol: a.tipoRol
        };
    };
});