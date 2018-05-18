var appHelp = angular.module("appHelpPage", []);
function headerController($http, $scope) {
    //Obtener Lista de notificaciones
    $http.get("./header/getMessages").then(function (data) {
        $scope.allNotificaciones = data.data.data;
    });

    $scope.notifNoLeidas = function (item) {
        if (item.leido === "false") {
            return item;
        }
    };
    $scope.newNotification = {};
    var socket = new SockJS("./websocket/configuration");
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