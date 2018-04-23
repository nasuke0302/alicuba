var appUsuarios = angular.module("appUsuarios", []);
appUsuarios.controller("UsuariosController", function ($scope, $http) {
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
                //Mostrar Mensaje o algo
            });
        } else {
            $http.post("edit", $scope.indiceRegistro, {}).then(function (r) {
                //Mostrar Mensaje o algo
            });
        }
    };

    // Eliminar Usuario
    $scope.eliminarUsuario = function () {
        $("#formModalEliminar").modal("toggle");
        $http.post("delete", $scope.indiceRegistro, {}).then(function (r) {
        });
    };

    //Enviar Usuarios al Modal Editar
    $scope.abrirEditarModal = function (indice) {
        var a = $scope.allUsuarios[indice];
        $scope.indiceRegistro = {
            idUsuario: a.idUsuario,
            email: a.email,
            nombre: a.nombre,
            apellidos: a.apellidos
        };
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
});