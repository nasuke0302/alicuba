var appNotificaciones = angular.module("appNotificaciones", ['datatables', 'datatables.bootstrap']);
function headerController($http, $scope) {
    //Obtener Lista de notificaciones
    $http.get("../header/getMessages").then(function (data) {
        $scope.allNotificaciones = data.data.data;
    });

    $scope.notifNoLeidas = function (item) {
        if (item.leido === "false") {
            return item;
        }
    };
    $scope.newNotification = {};
    var socket = new SockJS("../websocket/configuration");
    var stompClient = Stomp.over(socket);
    var notify;
    stompClient.connect({}, function (frame) {
        stompClient.subscribe("/user/queue/enviar", function (res) {
            $scope.newNotification = JSON.parse(res.body);
            notify = new Notification($scope.newNotification.titulo, {
                body: $scope.newNotification.mensaje,
                icon: "/alicuba/static/IconWebSocket.png"});
        });

        stompClient.subscribe("/topic/notifications", function (res) {
            $scope.allNotificaciones.unshift(JSON.parse(res.body));
            $scope.newNotification = JSON.parse(res.body);
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
    //Obtener Lista de notificaciones
    $http.get("getNotificaciones").then(function (data) {
        $scope.allNotificaciones = data.data.data;
    });
    // Eliminar Notificaciones
    $scope.eliminarNotificacion = function () {
        $("#formModalEliminar").modal("toggle");
        $http.delete("delete/" + $scope.notificacion.idMensaje).then(function (r) {
            $window.alert(r.data.mensaje);
            //Obtener Lista de Autores
            $http.get("get").then(function (data) {
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