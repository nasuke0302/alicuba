var appAutores = angular.module("appNotificaciones", ['datatables', 'datatables.bootstrap']);
appAutores.controller("NotificacionesController", function ($scope, $http, $window) {
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
    //Enviar Autor al Modal Eliminar
    $scope.abrirEliminarModal = function (indice) {
        var a = $scope.allAutores[indice];
        $scope.notificacion = {
            idMensaje: a.idMensaje,
            mensaje: a.mensaje,
            sender: a.sender,
            receiver: a.receiver,
            leido: a.leido,
            fecha: a.fecha,
            titulo: a.titulo
        };
    };
});