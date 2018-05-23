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

    $scope.selectedMetadato = {};
    $scope.formula = "";
    $scope.resultado = "";
    $scope.variables = {
        x: "",
        y: ""
    };
    $scope.nutrientesMetadatos = {};

    //Cargar todas las referencia
    $http.get("getAllReferencias").then(function (res) {
        $scope.allReferencias = res.data.data;
    });

    //Cargar todos los metadatos
    $http.get("getAllMetadatos").then(function (res) {
        $scope.allMetadatos = res.data.data;
        console.log($scope.allMetadatos);
        $scope.nutrientesMetadatos = $scope.allMetadatos[0].tablaCnaGeneralList;
        console.log($scope.nutrientesMetadatos);
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
