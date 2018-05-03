var appCna = angular.module("AppCna", ['ui.select']);
appCna.controller("CnaController", function ($scope, $http, $window) {
    $scope.referencia = JSON.parse(window.localStorage.getItem("referencia"));
    $scope.selectedAutores = {};
    $scope.selectedCategoria = {};
    $scope.estudioPorReferencia = {};
    $scope.selectedFuente = {};
    $scope.fuente = {
        nombreFuente: ""
    };
    $scope.selectedAutores = {};
    $scope.autor = {
        nombre: "",
        segundoNombre: "",
        apellidos: ""
    };
    $scope.categoria = {
        categoria: ""
    };
    $scope.selectedCategoria = {};


    $scope.estudiosPorReferencia = function (idReferencia) {
        console.log($scope.referencia);
        $http.get("getEstudioPorReferencia/" + idReferencia).then(function (data) {
            $scope.estudioPorReferencia = data.data.data;
        });
    };
    //Obtener Listado de Categorias
    $http.get("../categorias/get").then(function (data) {
        $scope.allCategorias = data.data.data;
    });
    //Obtener Lista de Fuentes de Informacion
    $http.get("../index/getFuentes").then(function (data) {
        $scope.allFuentes = data.data.data;
    });
    //Obtener Lista de Autores
    $http.get("../autores/get").then(function (data) {
        $scope.allAutores = data.data.data;
    });
    $scope.saveReferencia = function () {
        $scope.referencia.idFuente = parseInt($scope.selectedFuente);
        $scope.referencia.fechaMod = new Date();
        $scope.referencia.autoresList = $scope.selectedAutores.selected;
        $scope.referencia.categoriaList = $scope.selectedCategoria.selected;
        $http.post("../index/editReferencia", $scope.referencia, {}).then(function (r) {
            console.log(r.data.mensaje);
            //Obtener la ultima referencia insertada
            $http.get("getLastReferencia").then(function (data) {
                $scope.referencia = data.data.data;
            });
        });
        $("#modalNuevaReferencia").modal("toggle");
    };
    //NUEVO ESTUDIO
    $scope.nuevoEstudio = function () {
        $window.location.href = "../estudio/gestionar";
    };
    //Enviar Referencia al Modal
    $scope.abrirEditarModal = function () {
        $scope.selectedFuente.selected = $scope.referencia.idFuente;
        $scope.selectedAutores.selected = $scope.referencia.autoresList;
        $scope.selectedCategoria.selected = $scope.referencia.categoriaList;
    };
    $scope.abrirModalAddAutor = function () {
        $scope.autor = {
            nombre: "",
            segundoNombre: "",
            apellidos: ""
        };
    };
    $scope.addAutor = function () {
        $http.post("../autor/add", $scope.autor, {}).then(function (r) {
            $window.alert(r.data.mensaje);
            //Obtener Lista de Autores
            $http.get("../autor/get").then(function (data) {
                $scope.allAutores = data.data.data;
            });
            $("#modalAddOrEditAutor").modal("toggle");
        });
    };
    $scope.abrirModalAddCategoria = function () {
        $scope.categoria = {
            categoria: ""
        };
    };
    $scope.addCategoria = function () {
        $http.post("../categorias/add", $scope.categoria, {}).then(function (r) {
            $window.alert(r.data.mensaje);
            //Obtener Lista de Categorias
            $http.get("../categorias/get").then(function (data) {
                $scope.allCategorias = data.data.data;
            });
            $("#modalAddOrEditCategoria").modal("toggle");
        });
    };
});