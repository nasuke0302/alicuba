var appAutores = angular.module("appAutores", ['datatables', 'datatables.bootstrap']);
appAutores.controller("AutoresController", function ($scope, $http, $window) {
    $scope.autor = {
        idAutor: "",
        nombre: "",
        seundoNombre: "",
        apellidos: ""
    };

    //Obtener Lista de Autores
    $http.get("get").then(function (data) {
        $scope.allAutores = data.data.data;
    });
    //Crear o Editar Autor
    $scope.createOrEditAutor = function () {
        $("#formModalCreateOrEdit").modal("toggle");
        if ($scope.autor.idAutor === "") {
            $http.post("add", $scope.autor, {}).then(function (r) {
                $window.alert(r.data.mensaje);
                //Obtener Lista de autores
                $http.get("get").then(function (data) {
                    $scope.allAutores = data.data.data;
                });
            });
        } else {
            $http.post("edit", $scope.autor, {}).then(function (r) {
                $window.alert(r.data.mensaje);
                //Obtener Lista de alimentos
                $http.get("get").then(function (data) {
                    $scope.allAutores = data.data.data;
                });
            });
        }
    };
    // Eliminar Autor
    $scope.eliminarAutor = function () {
        $("#formModalEliminar").modal("toggle");
        $http.delete("delete/" + $scope.autor.idAutor).then(function (r) {
            $window.alert(r.data.mensaje);
            //Obtener Lista de Autores
            $http.get("get").then(function (data) {
                $scope.allAutores = data.data.data;
            });
        });
    };
    //Poner en blanco los campos del modal
    $scope.abrirNuevoAutorModal = function () {
        $scope.autor = {
            idAutor: "",
            nombre: "",
            segundoNombre: "",
            apellidos: ""
        };
    };
    //Enviar Autor al Modal Editar
    $scope.abrirEditarModal = function (indice) {
        var a = $scope.allAutores[indice];
        $scope.autor = {
            idAutor: a.idAutor,
            nombre: a.nombre,
            segundoNombre: a.segundoNombre,
            apellidos: a.apellidos
        };
    };
    //Enviar Autor al Modal Eliminar
    $scope.abrirEliminarModal = function (indice) {
        var a = $scope.allAutores[indice];
        $scope.autor = {
            idAutor: a.idAutor,
            nombre: a.nombre,
            segundoNombre: a.segundoNombre,
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