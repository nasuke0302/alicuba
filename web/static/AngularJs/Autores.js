var appAutores = angular.module("appAutores", ['datatables', 'datatables.bootstrap', 'angular-loading-bar']);
function headerController($http, $scope) {
    //Obtener Lista de notificaciones
    $scope.noLeido = 0;
    $scope.allNotificaciones = {};
    $http.get("../header/getMessages").then(function (data) {
        $scope.allNotificaciones = data.data.data;
        for (var i = 0; i < $scope.allNotificaciones.length; i++) {
            if (!$scope.allNotificaciones[i].leido) {
                $scope.noLeido++;
            }
        }
    });

    $scope.newNotification = {};
    var socket = new SockJS("../websocket/configuration");
    var stompClient = Stomp.over(socket);
    var notify;
    stompClient.connect({}, function (frame) {
        stompClient.subscribe("/user/queue/enviar", function (res) {
            $scope.newNotification = JSON.parse(res.body);
            $scope.noLeido++;
            notify = new Notification($scope.newNotification.titulo, {
                body: $scope.newNotification.mensaje,
                icon: "/alicuba/static/IconWebSocket.png"});
        });

        stompClient.subscribe("/topic/notifications", function (res) {
            $scope.allNotificaciones.unshift(JSON.parse(res.body));
            $scope.newNotification = JSON.parse(res.body);
            $scope.noLeido++;
            notify = new Notification($scope.newNotification.titulo, {
                body: $scope.newNotification.mensaje,
                icon: "/alicuba/static/IconWebSocket.png"});
        });
    });
}
appAutores.controller("headerController", headerController);
appAutores.controller("AutoresController", function ($scope, $http, $window) {
    $scope.autor = {
        idAutor: "",
        nombre: "",
        seundoNombre: "",
        apellidos: ""
    };

    //Obtener Lista de Autores
    $http.get("getAutores").then(function (data) {
        $scope.allAutores = data.data.data;
    });
    //Crear o Editar Autor
    $scope.createOrEditAutor = function () {
        $("#formModalCreateOrEdit").modal("toggle");
        if ($scope.autor.idAutor === "") {
            $http.post("addAutor", $scope.autor, {}).then(function (r) {
                $window.alert(r.data.mensaje);
                //Obtener Lista de autores
                $http.get("getAutores").then(function (data) {
                    $scope.allAutores = data.data.data;
                });
            });
        } else {
            $http.post("editAutor", $scope.autor, {}).then(function (r) {
                $window.alert(r.data.mensaje);
                //Obtener Lista de alimentos
                $http.get("getAutores").then(function (data) {
                    $scope.allAutores = data.data.data;
                });
            });
        }
    };
    // Eliminar Autor
    $scope.eliminarAutor = function () {
        $("#formModalEliminar").modal("toggle");
        $http.delete("deleteAutor/" + $scope.autor.idAutor).then(function (r) {
            $window.alert(r.data.mensaje);
            //Obtener Lista de Autores
            $http.get("getAutores").then(function (data) {
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
});
