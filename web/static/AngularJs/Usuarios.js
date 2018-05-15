var appUsuarios = angular.module("appUsuarios", ['datatables', 'datatables.bootstrap']);
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
appUsuarios.controller("headerController", headerController);
appUsuarios.controller("UsuariosController", function ($scope, $http, $window) {
    $scope.selectedRol = {};
    $scope.indiceRegistro = {
        idUsuario: "",
        email: "",
        nombre: "",
        apellidos: "",
        idRol: ""
    };
    //Obtener Lista de usuarios
    $http.get("get").then(function (data) {
        $scope.allUsuarios = data.data.data;
    });
    //Obtener Lista de Roles
    $http.get("../roles/get").then(function (data) {
        $scope.allRoles = data.data.data;
    });
    //Enviar Usuario editado al Servidor
    $scope.addOrEditUsuario = function () {
        $("#formModalCreateOrEdit").modal("toggle");
        $scope.indiceRegistro.idRol = $scope.selectedRol;
        if ($scope.indiceRegistro.idUsuario === "") {
            $http.post("add", $scope.indiceRegistro, {}).then(function (r) {
                $window.alert(r.data.mensaje);
                //Obtener Lista de usuarios
                $http.get("get").then(function (data) {
                    $scope.allUsuarios = data.data.data;
                });
            });
        } else {
            $http.post("edit", $scope.indiceRegistro, {}).then(function (r) {
                $window.alert(r.data.mensaje);
                //Obtener Lista de usuarios
                $http.get("get").then(function (data) {
                    $scope.allUsuarios = data.data.data;
                });
            });
        }
    };
    // Eliminar Usuario
    $scope.eliminarUsuario = function () {
        $("#formModalEliminar").modal("toggle");
        $http.post("delete/" + $scope.indiceRegistro.idUsuario, {}).then(function (r) {
            $window.alert(r.data.mensaje);
            $http.get("get").then(function (data) {
                $scope.allUsuarios = data.data.data;
            });
        });
    };
    //Enviar Usuarios al Modal Editar
    $scope.abrirEditarModal = function (indice) {
        var a = $scope.allUsuarios[indice];
        $scope.indiceRegistro = {
            idUsuario: a.idUsuario,
            email: a.email,
            nombre: a.nombre,
            apellidos: a.apellidos,
            idRol: a.idRol
        };
        $scope.selectedRol = $scope.indiceRegistro.idRol.idRoles;
    };
    //Enviar Usuario al Modal Eliminar
    $scope.abrirEliminarModal = function (indice) {
        var a = $scope.allUsuarios[indice];
        $scope.indiceRegistro = {
            idUsuario: a.idUsuario,
            email: a.email,
            nombre: a.nombre,
            apellidos: a.apellidos
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