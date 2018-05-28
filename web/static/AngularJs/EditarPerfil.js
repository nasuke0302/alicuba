var appEditarPerfil = angular.module("appEditarPerfil", ['ui.validate']);
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
appEditarPerfil.controller("headerController", headerController);
appEditarPerfil.controller("EditarPerfilController", function ($scope, $http, $window) {
    $scope.usuario = {
        idUsuario: "",
        email: "",
        nombre: "",
        apellidos: "",
        password: ""
    };
    $scope.usuarioPassword = {
        newPass: "",
        confirmNewPass: ""
    };
    $scope.usuarioEditado = {
        idUsuario: "",
        email: "",
        nombre: "",
        apellidos: ""
    };
   
   //Obtener informacion del usuario autenticado
    $http.get("getUsuarioAutenticado").then(function (data) {
        $scope.usuario = data.data.data;
    });
    //Actualizar datos del perfil
    $scope.updatePerfil = function () {
        var a = $scope.usuario;
        $scope.usuarioEditado = {
            idUsuario: a.idUsuario,
            email: a.email,
            nombre: a.nombre,
            apellidos: a.apellidos
        };
        $http.post("updatePerfil", $scope.usuarioEditado, {}).then(function (response) {
            $window.alert(response.data.mensaje);
            $http.get("getUsuarioAutenticado").then(function (data) {
                $scope.usuario = data.data.data;
            });
        });
    };
    //Mandar la contraseña nueva para el server
    $scope.cambiarPassword = function () {
        $http.post("cambiarPassword", $scope.usuarioPassword.newPass).then(function (response) {
            $window.alert(response.data.mensaje);
            $scope.usuarioPassword = {
                newPass: "",
                confirmNewPass: ""
            };
        });
    };
    //Hacer visible el form de cambiar password o no
    $scope.changePass = function () {
        if ($('#divPasswordGroup').hasClass('ng-hide')) {
            $('#divPasswordGroup').removeClass('ng-hide');
            $('#divPasswordGroup').addClass('ng-show');
        } else {
            $('#divPasswordGroup').removeClass('ng-show');
            $('#divPasswordGroup').addClass('ng-hide');
        }
    };
    //Validar que las contraseñas sean iguales
    $scope.validarPasswords = function (value) {
        return value === $scope.usuarioPassword.newPass;
    };
});
