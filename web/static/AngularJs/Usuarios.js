var appUsuarios = angular.module("appUsuarios", ['datatables', 'datatables.bootstrap']);
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
appUsuarios.controller("headerController", headerController);
appUsuarios.controller("UsuariosController", function ($scope, $http, $window) {
    $scope.selectedRol = {};
    $scope.indiceRegistro = {
        idUsuario: "",
        email: "",
        nombre: "",
        apellidos: "",
        activo: "",
        idRol: ""
    };
    //Obtener Lista de usuarios
    $http.get("getUsuarios").then(function (data) {
        $scope.allUsuarios = data.data.data;
    });
    //Obtener Lista de Roles
    $http.get("../roles/getRoles").then(function (data) {
        $scope.allRoles = data.data.data;
    });
    //Enviar Usuario editado al Servidor
    $scope.addOrEditUsuario = function () {
        $("#formModalCreateOrEdit").modal("toggle");
        $scope.indiceRegistro.idRol = $scope.selectedRol;
        if ($scope.indiceRegistro.idUsuario === "") {
            $http.post("addUsuario", $scope.indiceRegistro, {}).then(function (r) {
                $window.alert(r.data.mensaje);
                //Obtener Lista de usuarios
                $http.get("getUsuarios").then(function (data) {
                    $scope.allUsuarios = data.data.data;
                });
            });
        } else {
            $http.post("editUsuario", $scope.indiceRegistro, {}).then(function (r) {
                $window.alert(r.data.mensaje);
                //Obtener Lista de usuarios
                $http.get("getUsuarios").then(function (data) {
                    $scope.allUsuarios = data.data.data;
                });
            });
        }
    };
    // Eliminar Usuario
    $scope.lockUser = function () {
        $("#formModalLockUser").modal("toggle");
        $http.post("lockUser/" + $scope.indiceRegistro.idUsuario, {}).then(function (r) {
            $window.alert(r.data.mensaje);
            $http.get("getUsuarios").then(function (data) {
                $scope.allUsuarios = data.data.data;
            });
        });
    };
    //Enviar Usuarios al Modal Editar
    $scope.abrirEditarModal = function (indice) {
        var a = $scope.allUsuarios[indice];
        $scope.indiceRegistro = {
            idUsuario: a.idUsuario,
            email: a.email,
            nombre: a.nombre,
            apellidos: a.apellidos,
            activo: a.activo,
            idRol: a.idRol
        };
        $scope.selectedRol = $scope.indiceRegistro.idRol.idRoles;
    };
    //Enviar Usuario al Modal Eliminar
    $scope.abrirEliminarModal = function (indice) {
        var a = $scope.allUsuarios[indice];
        $scope.indiceRegistro = {
            idUsuario: a.idUsuario,
            email: a.email,
            nombre: a.nombre,
            activo: a.activo,
            apellidos: a.apellidos
        };
    };
});