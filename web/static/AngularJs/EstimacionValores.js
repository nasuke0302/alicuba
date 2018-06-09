var appEstimacion = angular.module("appEstimacion", ['ui.select', 'ngSanitize', 'angular-loading-bar']);
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
appEstimacion.controller("headerController", headerController);
appEstimacion.controller("EstimacionController", function ($scope, $http, $window) {

    $scope.nuevaFormula = {
        idFormula: "",
        nombreFormula: "",
        formula: "",
        idNutriente: "",
        variablesList: []
    };
    $scope.letras = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o",
        "p", "q", "r", "s", "u", "v", "w", "x", "y", "z"];
    $scope.arregloVars = [];
    var count = 0;

    //Obtener lista de todos los nutrientes
    $http.get("../estudio/getNutrientes").then(function (res) {
        $scope.allNutrientes = res.data.data;
    });
    //Obtener lista de todas las formulas
    $http.get("getFormulas").then(function (res) {
        $scope.allFormulas = res.data.data;
    });
    //Enviar una formula nueva al servidor para evaluar y guardar
    $scope.parseExp = function () {
        $('#formModalCreateOrEditFormula').modal('toggle');
        $http.post("addVariables", $scope.arregloVars, {}).then(function (res) {
            $scope.nuevaFormula.variablesList = res.data.data;
            $http.post("parseExp", $scope.nuevaFormula).then(function (res) {
                $window.alert(res.data.mensaje);
                $http.get("getFormulas").then(function (res) {
                    $scope.allFormulas = res.data.data;
                });
                $scope.nuevaFormula = {
                    idFormula: "",
                    nombreFormula: "",
                    formula: "",
                    idNutriente: "",
                    variablesFormulasList: []
                };
                $scope.arregloVars = [];
            });
        });

    };
    //Añadir una nueva variable
    $scope.addVariable = function () {
        var ele = {
            nombreVariable: $scope.letras[count++]
        };
        $scope.arregloVars.push(ele);
    };
    //Poner en blanco los campos del modal
    $scope.abrirNuevaFormulaModal = function () {
        $scope.nuevaFormula = {
            idFormula: "",
            nombreFormula: "",
            formula: "",
            idNutriente: "",
            variablesList: []
        };
        $scope.arregloVars = [];
        count = 0;
    };
    //Enviar formula al modal eliminar
    $scope.abrirEliminarModal = function (indice) {
        var a = $scope.allFormulas[indice];
        $scope.nuevaFormula = {
            idFormula: a.idFormula,
            nombreFormula: a.nombreFormula,
            formula: a.formula,
            idNutriente: a.idNutriente,
            variablesList: a.variablesList
        };
    };
    //Enviar la formula a eliminar al servidor
    $scope.eliminarFormula = function () {
        $("#formModalEliminarFormula").modal("toggle");
        $http.delete("deleteFormulas/" + $scope.nuevaFormula.idFormula).then(function (r) {
            $window.alert(r.data.mensaje);
            //Obtener Lista de Categorias
            $http.get("getFormulas").then(function (res) {
                $scope.allFormulas = res.data.data;
            });
        });
    };
    //Enviar formula al modal editar
    $scope.abrirEditarModal = function (indice) {
        var a = $scope.allFormulas[indice];
        $scope.nuevaFormula = {
            idFormula: a.idFormula,
            nombreFormula: a.nombreFormula,
            formula: a.formula,
            idNutriente: a.idNutriente,
            variablesList: a.variablesList
        };
        $scope.arregloVars = a.variablesList;
        count = a.variablesList.length;
    };
});
