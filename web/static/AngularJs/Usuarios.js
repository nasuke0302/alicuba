var appUsuarios = angular.module("appUsuarios", ['datatables', 'datatables.bootstrap', 'angular-loading-bar']);
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
appUsuarios.controller("headerController", headerController);
appUsuarios.controller("UsuariosController", function ($scope, $http, $window) {
    $scope.selectedRol = {};
    $scope.indiceRegistro = {
        idUsuario: "",
        email: "",
        nombre: "",
        apellidos: "",
        activo: "",
        password: "",
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

    //Cambiar Constraseña Usuario
    $scope.changePassword = function () {
        $http.post("changePassword/" + $scope.indiceRegistro.idUsuario, $scope.indiceRegistro.password, {})
                .then(function (r) {
                    $window.alert(r.data.mensaje);
                    $http.get("getUsuarios").then(function (data) {
                        $scope.allUsuarios = data.data.data;
                    });
                });
    };
    //Editar Usuario
    $scope.addOrEditUsuario = function () {
        $("#formModalCreateOrEdit").modal("toggle");
        $scope.indiceRegistro.idRol = $scope.selectedRol;
        $http.post("editUsuario", $scope.indiceRegistro, {}).then(function (r) {
            $window.alert(r.data.mensaje);
            //Obtener Lista de usuarios
            $http.get("getUsuarios").then(function (data) {
                $scope.allUsuarios = data.data.data;
            });
        });
    };
    //Bloquear Usuario
    $scope.lockUser = function () {
        $("#formModalLockUser").modal("toggle");
        $http.post("lockUser/" + $scope.indiceRegistro.idUsuario, {}).then(function (r) {
            $window.alert(r.data.mensaje);
            $http.get("getUsuarios").then(function (data) {
                $scope.allUsuarios = data.data.data;
            });
        });
    };
    //Eliminar Usuario
    $scope.deleteUser = function () {
        $("#formModalDelete").modal("toggle");
        $http.post("deleteUsuario/" + $scope.indiceRegistro.idUsuario, {}).then(function (r) {
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
            password: a.password,
            idRol: a.idRol
        };
        $scope.selectedRol = $scope.indiceRegistro.idRol.idRoles;
    };
    //Enviar Usuario al Modal Bloquear
    $scope.abrirLockModal = function (indice) {
        var a = $scope.allUsuarios[indice];
        $scope.indiceRegistro = {
            idUsuario: a.idUsuario,
            email: a.email,
            nombre: a.nombre,
            activo: a.activo,
            apellidos: a.apellidos
        };
    };

    $scope.abrirEditPassModal = function (indice) {
        var a = $scope.allUsuarios[indice];
        $scope.indiceRegistro = {
            idUsuario: a.idUsuario,
            email: a.email,
            nombre: a.nombre,
            activo: a.activo,
            apellidos: a.apellidos,
            password: ""
        };
    };
});
