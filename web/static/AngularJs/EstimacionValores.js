var appEstimacion = angular.module("appEstimacion", ['ui.select', 'ngSanitize']);
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

    $scope.nuevaFormula = {
        nombreFormula: "",
        formula: "",
        idNutriente: "",
        variablesFormulasList: []
    };
    $scope.listaVariables = [];
    $scope.variables = {
        nombre: "",
        nutriente: ""
    };

    //Obtener lista de todos los nutrientes
    $http.get("../estudio/getNutrientes").then(function (res) {
        $scope.allNutrientes = res.data.data;
    });
    //Obtener lista de todas las formulas
    $http.get("getFormulas").then(function (res) {
        $scope.allFormulas = res.data.data;
    });

    $scope.parseExp = function () {
        $http.post("parseExp", $scope.nuevaFormula).then(function (res) {
            $window.alert(res.data.mensaje);
            $http.get("getFormulas").then(function (res) {
                $scope.allFormulas = res.data.data;
            });
            $scope.nuevaFormula = {
                nombreFormula: "",
                formula: "",
                idNutriente: "",
                variablesFormulasList: []
            };
            $scope.variables = {
                nombre: "",
                nutriente: ""
            };
        });
    };

    $scope.letras = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O",
        "P","Q","R","S","U","V","W","X","Y","Z"];
    $scope.arregloVars = [];
    var count = 0;
    $scope.addVariable = function () {
        var ele = {
            model: $scope.letras[count++]
        };
        $scope.arregloVars.push(ele);
    };
});
