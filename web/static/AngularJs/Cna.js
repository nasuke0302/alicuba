var appCna = angular.module("AppCna", []);
appCna.controller("CnaController", function ($scope, $http, $window) {
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
    //Obtener Listado de Categorias
    $http.get("../index/getCategorias").then(function (data) {
        $scope.allCategorias = data.data.data;
    });
    //Obtener Lista de Fuentes de Informacion
    $http.get("../index/getFuentes").then(function (data) {
        $scope.allFuentes = data.data.data;
    });
    //Obtener Lista de Autores
    $http.get("../index/getAutores").then(function (data) {
        $scope.allAutores = data.data.data;
    });
    //Obtener la ultima referencia insertada
    $http.get("getLastReferencia").then(function (data) {
        $scope.lastReferencia = data.data.data;
        console.log($scope.lastReferencia);
    });

    $scope.saveReferencia = function () {
        $scope.referencia.idFuente = parseInt($scope.selectedFuente);
        $scope.referencia.fechaMod = new Date();
        $scope.referencia.autoresList = $scope.selectedAutores;
        $scope.referencia.categoriaList = $scope.selectedCategoria;
        $http.post("../index/editReferencia", $scope.referencia, {}).then(function (r) {
            console.log(r.data.mensaje);
            //Obtener la ultima referencia insertada
            $http.get("getLastReferencia").then(function (data) {
                $scope.lastReferencia = data.data.data;
                console.log($scope.lastReferencia);
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
        var a = $scope.lastReferencia;
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
});