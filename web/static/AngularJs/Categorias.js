var appCategorias = angular.module("appCategorias", ['datatables', 'datatables.bootstrap']);
appCategorias.controller("CategoriasController", function ($scope, $http, $window) {
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
});