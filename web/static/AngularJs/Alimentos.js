var appAlimentos = angular.module("appAlimentos", ['datatables', 'datatables.bootstrap']);
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
    $http.get("get").then(function (data) {
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
                $window.alert(r.data.mensaje);
                //Obtener Lista de alimentos
                $http.get("get").then(function (data) {
                    $scope.allAlimentos = data.data.data;
                });
            });
        } else {
            $http.post("edit", $scope.indiceRegistro, {}).then(function (r) {
                $window.alert(r.data.mensaje);
                //Obtener Lista de alimentos
                $http.get("get").then(function (data) {
                    $scope.allAlimentos = data.data.data;
                });
            });
        }
    };
    // Eliminar Alimento
    $scope.eliminarAlimento = function () {
        $("#formModalEliminar").modal("toggle");
        $http.delete("delete/" + $scope.indiceRegistro.idAlimento).then(function (r) {
            $window.alert(r);
            $http.get("get").then(function (data) {
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