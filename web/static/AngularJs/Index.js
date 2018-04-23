var appIndex = angular.module("AppIndex", ['datatables', 'datatables.bootstrap', 'ui.select']);
appIndex.controller("IndexController", function ($scope, $http, $window) {
    $scope.selectedAutores = {};
    $scope.selectedCategoria = {};
    $scope.referencia = {
        idReferencia: "",
        idFuente: "",
        url: "http://",
        nota: "",
        title: "",
        informeNum: "",
        informeTipo: "",
        informeSerie: "",
        informeInstitution: "",
        arcPublication: "",
        volumen: "",
        numVol: "",
        edition: "",
        lugar: "",
        editorial: "",
        secclTitle: "",
        tesisUniversidad: "",
        pages: "",
        fecha: "",
        fechaAd: "",
        fechaMod: "",
        autoresList: "",
        categoriaList: ""
    };

    //Obtener Listado de Referencias
    $http.get("index/getReferencias").then(function (data) {
        $scope.allReferencias = data.data.data;
    });
    //Obtener Listado de Categorias
    $http.get("index/getCategorias").then(function (data) {
        $scope.allCategorias = data.data.data;
    });
    //Obtener Lista de Fuentes de Informacion
    $http.get("index/getFuentes").then(function (data) {
        $scope.allFuentes = data.data.data;
    });
    //Obtener Lista de Autores
    $http.get("index/getAutores").then(function (data) {
        $scope.allAutores = data.data.data;
    });
    $scope.createOrEditReferencia = function () {
        $scope.referencia.idFuente = parseInt($scope.selectedFuente);
        $scope.referencia.fechaAd = new Date();
        $scope.referencia.fechaMod = new Date();
        $scope.referencia.autoresList = $scope.selectedAutores.selected;
        $scope.referencia.categoriaList = $scope.selectedCategoria.selected;
        if ($scope.referencia.idReferencia === "") {
            $http.post("index/addReferencia", $scope.referencia, {});
            $("#modalNuevaReferencia").modal("toggle");
            $window.location.href = "cna/gestionar";
        } else {
            $http.post("index/editReferencia", $scope.referencia, {});
            $("#modalNuevaReferencia").modal("toggle");
        }
    };
    // Eliminar Referencia
    $scope.eliminarReferencia = function () {
        $("#formModalEliminar").modal("toggle");
        $http.delete("index/delete/" + $scope.referencia.idReferencia).then(function (r) {
            console.log(r.data.mensaje);
            //Obtener Listado de Referencias
            $http.get("index/getReferencias").then(function (data) {
                $scope.allReferencias = data.data.data;
            });
        });
    };

//    PONER EN BLANCO TODOS LOS CAMPOS DEL MODAL AL ABRIR
    $scope.abrirNuevoModal = function () {
        $scope.referencia = {
            idReferencia: "",
            idFuente: "",
            url: "http://",
            nota: "",
            title: "",
            informeNum: "",
            informeTipo: "",
            informeSerie: "",
            informeInstitution: "",
            arcPublication: "",
            volumen: "",
            numVol: "",
            edition: "",
            lugar: "",
            editorial: "",
            secclTitle: "",
            tesisUniversidad: "",
            pages: "",
            fecha: "",
            fechaAd: "",
            fechaMod: "",
            autoresList: "",
            categoriaList: ""
        };
    };
    //Enviar Referencia al Modal
    $scope.abrirEditarModal = function (indice) {
        var a = $scope.allReferencias[indice];
        $scope.referencia = {
            idReferencia: a.idReferencia,
            idFuente: a.idFuente,
            url: a.url,
            nota: a.nota,
            title: a.title,
            informeNum: a.informeNum,
            informeTipo: a.informeTipo,
            informeSerie: a.informeSerie,
            informeInstitution: a.informeInstitution,
            arcPublication: a.arcPublication,
            volumen: a.volumen,
            numVol: a.numVol,
            edition: a.edition,
            lugar: a.lugar,
            editorial: a.editorial,
            secclTitle: a.secclTitle,
            tesisUniversidad: a.tesisUniversidad,
            pages: a.pages,
            fecha: a.fecha,
            fechaAd: a.fechaAd,
            fechaMod: new Date()
        };
    };
    //Enviar Referencia al Modal Eliminar
    $scope.abrirEliminarModal = function (indice) {
        var a = $scope.allReferencias[indice];
        $scope.referencia = {
            idReferencia: a.idReferencia,
            idFuente: a.idFuente,
            url: a.url,
            nota: a.nota,
            title: a.title,
            informeNum: a.informeNum,
            informeTipo: a.informeTipo,
            informeSerie: a.informeSerie,
            informeInstitution: a.informeInstitution,
            arcPublication: a.arcPublication,
            volumen: a.volumen,
            numVol: a.numVol,
            edition: a.edition,
            lugar: a.lugar,
            editorial: a.editorial,
            secclTitle: a.secclTitle,
            tesisUniversidad: a.tesisUniversidad,
            pages: a.pages,
            fecha: a.fecha
        };
    };
});