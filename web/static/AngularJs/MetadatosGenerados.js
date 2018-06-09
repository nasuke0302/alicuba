var appMetadatosGenerados = angular.module("appMetadatosGenerados", ['datatables', 'datatables.bootstrap', 'angular-loading-bar']);
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
appMetadatosGenerados.controller("headerController", headerController);
appMetadatosGenerados.controller("MetadatosGeneradosController", function ($scope, $http) {

    $scope.tablaGenerada = JSON.parse(window.localStorage.getItem("tablaGenerada"));
    $scope.tablaGeneradaEdit = JSON.parse(window.localStorage.getItem("tablaGenerada"));
    //Obtener Lista de Metadatos Generados
    $http.get("getMetadatosGenerados").then(function (data) {
        $scope.allMetadatosGenerados = data.data.data;
    });

});