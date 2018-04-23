var appUsuarios = angular.module("appAlimentos", []);
appUsuarios.controller("AlimentosController", function ($scope, $http) {
    $scope.paginaActual = 1;
    $scope.indiceRegistro = {
        idAlimento: "",
        nombreCient: "",
        nombre: "",
        variedad: "",
        parte: "",
        idTipoCuba: "",
        idTipoFao: "",
        idTipoNrc: "",
        idUsuario: ""
    };

    //Incrementar valor de paginaActual
    $scope.nextPage = function () {
        $scope.paginaActual = $scope.paginaActual + 1;
        $http.get("get", {params: {page: $scope.paginaActual, size: 1}}).then(function (data) {
            $scope.allAlimentos = data.data.data;
        });
    };
    
    //Decrementar valor de paginaActual
    $scope.previousPage = function () {
        $scope.paginaActual = $scope.paginaActual - 1;
        $http.get("get", {params: {page: $scope.paginaActual, size: 1}}).then(function (data) {
            $scope.allAlimentos = data.data.data;
        });
    };
    
    //Obtener Lista de alimentos
    $http.get("get", {params: {page: $scope.paginaActual, size: 1}}).then(function (data) {
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
            $http.post("add", $scope.indiceRegistro, {}).then(function (r) {
                //Mostrar Mensaje o algo
            });
        } else {
            $http.post("edit", $scope.indiceRegistro, {}).then(function (r) {
                //Mostrar Mensaje o algo
            });
        }
    };

    // Eliminar Alimento
    $scope.eliminarAlimento = function () {
        $("#formModalEliminar").modal("toggle");
        $http.post("delete", $scope.indiceRegistro, {}).then(function (r) {
        });
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
            idTipoCuba: a.idTipoCuba,
            idTipoFao: a.idTipoFao,
            idTipoNrc: a.idTipoNrc,
            idUsuario: a.idUsuario
        };
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
            idTipoCuba: a.idTipoCuba,
            idTipoFao: a.idTipoFao,
            idTipoNrc: a.idTipoNrc,
            idUsuario: a.idUsuario
        };
    };
});