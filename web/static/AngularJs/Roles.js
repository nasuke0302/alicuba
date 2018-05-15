var appRoles = angular.module("AppRoles", []);
appRoles.controller("RolesController", function ($scope, $http) {
    $scope.indiceRegistro =
            {
                idRoles: "",
                tipoRol: ""
            };
    //Obtener Listado de Roles
    $http.get("get").then(function (data) {
        $scope.allRoles = data.data.data;
    });

    //Crear o Editar un Rol
    $scope.addOrEditRol = function () {
        $("#formModalCreateOrEdit").modal("toggle");
        if ($scope.indiceRegistro.idRoles === "") {
            $http.post("add", $scope.indiceRegistro, {}).then(function (r) {
                //Mostrar Mensaje o algo
            });
        } else {
            $http.post("edit", $scope.indiceRegistro, {}).then(function (r) {
                //Mostrar Mensaje o algo
            });
        }
    };

    //Eliminar un Rol
    $scope.eliminarRol = function () {
         $("#formModalEliminar").modal("toggle");
        $http.post("delete", $scope.indiceRegistro, {}).then(function (r) {
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