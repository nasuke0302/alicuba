var appAlimentos = angular.module("appAlimentos", ['datatables', 'datatables.bootstrap']);
function headerController($http, $scope) {
    //Obtener Lista de notificaciones
    $scope.noLeido = 0;
    $scope.allNotificaciones = {};
    $http.get("./header/getMessages").then(function (data) {
        $scope.allNotificaciones = data.data.data;
        for (var i = 0; i < $scope.allNotificaciones.length; i++) {
            if (!$scope.allNotificaciones[i].leido) {
                $scope.noLeido++;
            }
        }
    });

    $scope.newNotification = {};
    var socket = new SockJS("./websocket/configuration");
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
appAlimentos.controller("headerController", headerController);
appAlimentos.controller("AlimentosController", function ($scope, $http, $window) {
    $scope.selectedTipoCuba = "";
    $scope.selectedTipoFao = "";
    $scope.selectedTipoNrc = "";
    $scope.indiceRegistro = {
        idAlimento: "",
        nombreCient: "",
        nombre: "",
        variedad: "",
        parte: "",
        proceso: "",
        mezcla: "",
        idTipoCuba: "",
        idTipoFao: "",
        idTipoNrc: ""
    };

    //Obtener Lista de alimentos
    $http.get("getAlimentos").then(function (data) {
        $scope.allAlimentos = data.data.data;
    });
    //Obtener Lista de TipoCuba
    $http.get("getAllTipoCuba").then(function (data) {
        $scope.allTipoCuba = data.data.data;
    });
    //Obtener Lista de TipoFAO
    $http.get("getAllTipoFao").then(function (data) {
        $scope.allTipoFao = data.data.data;
    });
    //Obtener Lista de TipoNrc
    $http.get("getAllTipoNrc").then(function (data) {
        $scope.allTipoNrc = data.data.data;
    });
    //Crear o Editar Alimento
    $scope.createOrEditAlimento = function () {
        $("#formModalCreateOrEdit").modal("toggle");
        $scope.indiceRegistro.idTipoCuba = $scope.selectedTipoCuba;
        $scope.indiceRegistro.idTipoFao = $scope.selectedTipoFao;
        $scope.indiceRegistro.idTipoNrc = $scope.selectedTipoNrc;
        if ($scope.indiceRegistro.idAlimento === "") {
            $http.post("addAlimento", $scope.indiceRegistro, {}).then(function (r) {
                $window.alert(r.data.mensaje);
                //Obtener Lista de alimentos
                $http.get("getAlimentos").then(function (data) {
                    $scope.allAlimentos = data.data.data;
                });
            });
        } else {
            $http.post("editAlimento", $scope.indiceRegistro, {}).then(function (r) {
                $window.alert(r.data.mensaje);
                //Obtener Lista de alimentos
                $http.get("getAlimentos").then(function (data) {
                    $scope.allAlimentos = data.data.data;
                });
            });
        }
    };
    // Eliminar Alimento
    $scope.eliminarAlimento = function () {
        $("#formModalEliminar").modal("toggle");
        $http.delete("deleteAlimento/" + $scope.indiceRegistro.idAlimento).then(function (r) {
            $window.alert(r);
            $http.get("getAlimentos").then(function (data) {
                $scope.allAlimentos = data.data.data;
            });
        });
    };
    //Poner en blanco los campos del modal
    $scope.abrirNuevoAlimentoModal = function () {
        $scope.indiceRegistro = {
            idAlimento: "",
            nombreCient: "",
            nombre: "",
            variedad: "",
            parte: "",
            proceso: "",
            mezcla: "",
            idTipoCuba: "",
            idTipoFao: "",
            idTipoNrc: ""
        };
        $scope.selectedTipoCuba = 22;
        $scope.selectedTipoFao = 10;
        $scope.selectedTipoNrc = 9;

    };
    //Enviar Alimento al Modal Editar
    $scope.abrirEditarModal = function (indice) {
        var a = $scope.allAlimentos[indice];
        $scope.indiceRegistro = {
            idAlimento: a.idAlimento,
            nombreCient: a.nombreCient,
            nombre: a.nombre,
            variedad: a.variedad,
            parte: a.parte,
            proceso: a.proceso,
            mezcla: a.mezcla,
            idTipoCuba: a.idTipoCuba,
            idTipoFao: a.idTipoFao,
            idTipoNrc: a.idTipoNrc
        };
        $scope.selectedTipoCuba = a.idTipoCuba.idTipoCuba;
        $scope.selectedTipoFao = a.idTipoFao.idTipoFao;
        $scope.selectedTipoNrc = a.idTipoNrc.idTipoNrc;
    };
    //Enviar Usuario al Modal Eliminar
    $scope.abrirEliminarModal = function (indice) {
        var a = $scope.allAlimentos[indice];
        $scope.indiceRegistro = {
            idAlimento: a.idAlimento,
            nombreCient: a.nombreCient,
            nombre: a.nombre,
            variedad: a.variedad,
            parte: a.parte,
            proceso: a.proceso,
            mezcla: a.mezcla,
            idTipoCuba: a.idTipoCuba,
            idTipoFao: a.idTipoFao,
            idTipoNrc: a.idTipoNrc,
            idUsuario: a.idUsuario
        };
    };
});