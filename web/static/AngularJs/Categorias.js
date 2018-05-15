var appCategorias = angular.module("appCategorias", ['datatables', 'datatables.bootstrap']);
function headerController($http, $scope) {
    $scope.notificacion = {
        idMensaje: "",
        mensaje: "",
        sender: "",
        receiver: "",
        leido: "",
        fecha: "",
        titulo: ""
    };
    //Obtener Lista de notificaciones
    $http.get("../header/getMessages").then(function (data) {
        $scope.allNotificaciones = data.data.data;
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
    $http.get("get").then(function (data) {
        $scope.allCategorias = data.data.data;
    });
    //Crear o Editar Categoria
    $scope.createOrEditCategoria = function () {
        $("#formModalCreateOrEdit").modal("toggle");
        if ($scope.categoria.idCategoria === "") {
            $http.post("add", $scope.categoria, {}).then(function (r) {
                $window.alert(r.data.mensaje);
                //Obtener Lista de categorias
                $http.get("get").then(function (data) {
                    $scope.allCategorias = data.data.data;
                });
            });
        } else {
            $http.post("edit", $scope.categoria, {}).then(function (r) {
                $window.alert(r.data.mensaje);
                //Obtener Lista de Categorias
                $http.get("get").then(function (data) {
                    $scope.allCategorias = data.data.data;
                });
            });
        }
    };
    // Eliminar Categoria
    $scope.eliminarCategoria = function () {
        $("#formModalEliminar").modal("toggle");
        $http.delete("delete/" + $scope.categoria.idCategoria).then(function (r) {
            $window.alert(r.data.mensaje);
            //Obtener Lista de Categorias
            $http.get("get").then(function (data) {
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

    var socket = new SockJS("../websocket/configuration");
    var stompClient = Stomp.over(socket);
    var notify;
    stompClient.connect({}, function (frame) {
        stompClient.subscribe("/user/queue/enviar", function (res) {
            $scope.msj = JSON.parse(res.body);
            notify = new Notification($scope.msj.titulo, {
                body: $scope.msj.mensaje,
                icon: "/alicuba/static/IconWebSocket.png"});
        });
    });

    $scope.notificacion = {
        idMensaje: "",
        mensaje: "",
        sender: "",
        receiver: "",
        leido: "",
        fecha: "",
        titulo: ""
    };

    //Obtener Lista de Autores
    $http.get("get").then(function (data) {
        $scope.allNotificaciones = data.data.data;
    });

});