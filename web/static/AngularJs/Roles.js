var appRoles = angular.module("AppRoles", []);
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
appRoles.controller("headerController", headerController);
appRoles.controller("RolesController", function ($scope, $http) {
    $scope.indiceRegistro =
            {
                idRoles: "",
                tipoRol: ""
            };
    //Obtener Listado de Roles
    $http.get("getRoles").then(function (data) {
        $scope.allRoles = data.data.data;
    });

    //Crear o Editar un Rol
    $scope.addOrEditRol = function () {
        $("#formModalCreateOrEdit").modal("toggle");
        if ($scope.indiceRegistro.idRoles === "") {
            $http.post("addRol", $scope.indiceRegistro, {}).then(function (r) {
                //Mostrar Mensaje o algo
            });
        } else {
            $http.post("editRol", $scope.indiceRegistro, {}).then(function (r) {
                //Mostrar Mensaje o algo
            });
        }
    };

    //Eliminar un Rol
    $scope.eliminarRol = function () {
         $("#formModalEliminar").modal("toggle");
        $http.post("deleteRol", $scope.indiceRegistro, {}).then(function (r) {
            //Mostrar Mensaje o algo
        });
    };

    //Enviar Rol al Modal Editar
    $scope.abrirEditarModal = function (indice) {
        var a = $scope.allRoles[indice];
        $scope.indiceRegistro = {
            idRoles: a.idRoles,
            tipoRol: a.tipoRol
        };
    };

    //Enviar Rol al Modal Eliminar
    $scope.abrirEliminarModal = function (indice) {
        var a = $scope.allRoles[indice];
        $scope.indiceRegistro = {
            idRoles: a.idRoles,
            tipoRol: a.tipoRol
        };
    };
});