var appCategorias = angular.module("appCategorias", ['datatables', 'datatables.bootstrap']);
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
appCategorias.controller("headerController", headerController);
appCategorias.controller("CategoriasController", function ($scope, $http, $window) {
    $scope.msj = {};
    $scope.categoria = {
        idCategoria: "",
        categoria: ""
    };

    //Obtener Lista de Categorias
    $http.get("getCategorias").then(function (data) {
        $scope.allCategorias = data.data.data;
    });
    //Crear o Editar Categoria
    $scope.createOrEditCategoria = function () {
        $("#formModalCreateOrEdit").modal("toggle");
        if ($scope.categoria.idCategoria === "") {
            $http.post("addCategoria", $scope.categoria, {}).then(function (r) {
                $window.alert(r.data.mensaje);
                //Obtener Lista de categorias
                $http.get("getCategorias").then(function (data) {
                    $scope.allCategorias = data.data.data;
                });
            });
        } else {
            $http.post("editCategoria", $scope.categoria, {}).then(function (r) {
                $window.alert(r.data.mensaje);
                //Obtener Lista de Categorias
                $http.get("getCategorias").then(function (data) {
                    $scope.allCategorias = data.data.data;
                });
            });
        }
    };
    // Eliminar Categoria
    $scope.eliminarCategoria = function () {
        $("#formModalEliminar").modal("toggle");
        $http.delete("deleteCategoria/" + $scope.categoria.idCategoria).then(function (r) {
            $window.alert(r.data.mensaje);
            //Obtener Lista de Categorias
            $http.get("getCategorias").then(function (data) {
                $scope.allCategorias = data.data.data;
            });
        });
    };
    //Poner en blanco los campos del modal
    $scope.abrirNuevaCategoriaModal = function () {
        $scope.categoria = {
            idCategoria: "",
            categoria: ""
        };
    };
    //Enviar Categoria al Modal Editar
    $scope.abrirEditarModal = function (indice) {
        var a = $scope.allCategorias[indice];
        $scope.categoria = {
            idCategoria: a.idCategoria,
            categoria: a.categoria
        };
    };
    //Enviar Categoria al Modal Eliminar
    $scope.abrirEliminarModal = function (indice) {
        var a = $scope.allCategorias[indice];
        $scope.categoria = {
            idCategoria: a.idCategoria,
            categoria: a.categoria
        };
    };
});