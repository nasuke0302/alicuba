var appNotificaciones = angular.module("appNotificaciones", ['datatables', 'datatables.bootstrap', 'angular-loading-bar']);
function headerController($http, $scope) {
    $scope.noLeido = 0;
    $scope.allNotificaciones = {};
    //Obtener Lista de notificaciones
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
appNotificaciones.controller("headerController", headerController);
appNotificaciones.controller("NotificacionesController", function ($scope, $http, $window) {
    $scope.notificacion = {
        idMensaje: "",
        mensaje: "",
        sender: "",
        receiver: "",
        leido: "",
        fecha: "",
        titulo: ""
    };
    $scope.allNotificaciones = {};
    //Obtener Lista de notificaciones
    $http.get("getNotificaciones").then(function (data) {
        $scope.allNotificaciones = data.data.data;
        $http.post("setNotificacionesLeidas", $scope.allNotificaciones);
    });
    
    // Eliminar Notificaciones
    $scope.eliminarNotificacion = function () {
        $("#formModalEliminar").modal("toggle");
        $http.delete("deleteNotificacion/" + $scope.notificacion.idMensaje).then(function (r) {
            $window.alert(r.data.mensaje);
            //Obtener Lista de Notificaciones
            $http.get("getNotificaciones").then(function (data) {
                $scope.allNotificaciones = data.data.data;
            });
        });
    };
    //Enviar notificacion al Modal Eliminar
    $scope.abrirEliminarModal = function (indice) {
        var a = $scope.allNotificaciones[indice];
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
