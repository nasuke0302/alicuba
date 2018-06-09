var appTablasGeneradas = angular.module("appTablasGeneradas", ['datatables', 'datatables.bootstrap', 'angular-loading-bar']);
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
appTablasGeneradas.controller("headerController", headerController);
appTablasGeneradas.controller("TablasGeneradasController", function ($scope, $http, $window) {
    $scope.tablaGenerada = {
        idListadoTablaGeneradas: "",
        nombre: "",
        fechaHora: "",
        idUsuario: {}
    };

    //Obtener Lista de Tablas Generadas
    $http.get("getTablasGeneradas").then(function (data) {
        $scope.allTablasGeneradas = data.data.data;
    });

    $scope.abrirNuevaTablaGeneradaModal = function () {
        $scope.tablaGenerada = {
            idListadoTablaGeneradas: "",
            nombre: "",
            fechaHora: "",
            idUsuario: {}
        };
    };

    $scope.createTablaG = function () {
        $('#formModalCreate').modal('toggle');
        $http.post("generarTabla", $scope.tablaGenerada, {}).then(function (res) {
            $window.alert(res.data.mensaje);
            $http.get("getTablasGeneradas").then(function (data) {
                $scope.allTablasGeneradas = data.data.data;
            });
        });
    };

    $scope.editarTablaG = function (indice) {
        var a = $scope.allTablasGeneradas[indice];
        window.localStorage.setItem("tablaGenerada", JSON.stringify(a));
        $window.location.href = "../metadatosGenerados/gestionar";
    };

    $scope.abrirEliminarModal = function (indice) {
        var a = $scope.allTablasGeneradas[indice];
        $scope.tablaGenerada = {
            idListadoTablaGeneradas: a.idListadoTablaGeneradas,
            nombre: a.nombre,
            fechaHora: a.fechaHora,
            idUsuario: a.idUsuario
        };
    };

    $scope.eliminarTablaGenerada = function () {
        $('#formModalEliminar').modal("toggle");
        $http.delete("deleteTablasGeneradas/" + $scope.tablaGenerada.idListadoTablaGeneradas, {}).then(function (res) {
            $window.alert(res.data.mensaje);
            $http.get("getTablasGeneradas").then(function (data) {
                $scope.allTablasGeneradas = data.data.data;
            });
        });
    };
});
