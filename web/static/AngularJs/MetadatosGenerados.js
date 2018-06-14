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
appMetadatosGenerados.controller("MetadatosGeneradosController", function ($scope, $http, $window) {

    $scope.tablaGenerada = {
        idListadoTablaGeneradas: ""
    };

    $scope.metadatoGenerado = {
        presentation: "",
        tratamiento: "",
        tecnolog: "",
        corte: "",
        npk: "",
        n: ""
    };

    $scope.tablaGenerada = JSON.parse(window.localStorage.getItem("tablaGenerada"));
    $scope.tablaGeneradaEdit = JSON.parse(window.localStorage.getItem("tablaGenerada"));
    //Obtener Lista de Metadatos Generados
    $http.get("getMetadatosGeneradosPorTablaGenerada/" + $scope.tablaGenerada.idListadoTablaGeneradas).then(function (data) {
        $scope.allMetadatosGenerados = data.data.data;
    });

    //Ver datos del alimento seleccionado
    $scope.verDatos = function (indice) {
        $scope.metadatoGenerado = $scope.allMetadatosGenerados[indice];
        if ($scope.metadatoGenerado.corte === '') {
            $scope.metadatoGenerado.corte = "SDCorte";
        }
        if ($scope.metadatoGenerado.npk === 'null-null-null') {
            $scope.metadatoGenerado.npk = "0-0-0";
        }
        if ($scope.metadatoGenerado.presentation === '') {
            $scope.metadatoGenerado.presentation = "SDPre";
        }
        if ($scope.metadatoGenerado.tratamiento === '') {
            $scope.metadatoGenerado.tratamiento = "SDTra";
        }
        if ($scope.metadatoGenerado.tecnolog === '') {
            $scope.metadatoGenerado.tecnolog = "SDTec";
        }
        if (!$scope.metadatoGenerado.n) {
            $scope.metadatoGenerado.n = "0";
        }
    };

    $scope.editTabla = function () {
        $('#formModalEdit').modal('toggle');
        $http.post("../tablasgeneradas/editTabla", $scope.tablaGeneradaEdit, {}).then(function (res) {
            $window.alert(res.data.mensaje);
            $scope.tablaGenerada = res.data.data;
            window.localStorage.setItem("tablaGenerada", JSON.stringify($scope.tablaGenerada));
        });
    };

    $scope.abrirEditarModal = function () {
        $scope.tablaGeneradaEdit = JSON.parse(window.localStorage.getItem("tablaGenerada"));
    };
});