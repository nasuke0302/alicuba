var appEstimacion = angular.module("appEstimacion", ['ui.select']);
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
appEstimacion.controller("headerController", headerController);
appEstimacion.controller("EstimacionController", function ($scope, $http, $window) {

    $scope.formula = "";
    $scope.resultado = "";
    $scope.variables = {
        x: "",
        y: ""
    };
    $scope.allNutrientes = {};

    $http.get("../estudio/getNutrientes").then(function (res) {
        $scope.allNutrientes = res.data.data;
    });

    $http.get("../estimacion/getFormulas").then(function (res) {
        $scope.allFormulas = res.data.data;
        console.log($scope.allFormulas);
    });

    $scope.parseExp = function () {
        $http.post("parseExp", $scope.formula).then(function (res) {
            if (!res.data.success) {
                $window.alert(res.data.mensaje);
            }
            $scope.resultado = res.data.data;
        });
    };

    $scope.addVariable = function () {
        console.log("New button needs to pop up");
    };
});
