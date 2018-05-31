var appHelp = angular.module("appHelpPage", []);
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
appHelp.controller("headerController", headerController);
appHelp.controller("helpPageController", function ($scope, $http) {
    //Obtener el listado de usuarios con rol Administrador
    $http.get("helpPage/getUsuariosAdministradores").then(function(data){
        $scope.usuariosAdmins = data.data.data;
    });
    $http.get("helpPage/getUsuariosEditores").then(function(data){
        $scope.usuariosEditores = data.data.data;
    });
});
