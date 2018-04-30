var appCna = angular.module("AppCna", ['ui.select', 'AppIndex']);
appCna.controller("CnaController", function ($scope, $http, $window) {
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
    $scope.lastReferencia = {
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
    $scope.estudioPorReferencia = {};
    
    $scope.estudiosPorReferencia = function (idReferencia) {
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
    //Obtener la ultima referencia insertada
    $http.get("getLastReferencia").then(function (data) {
        $scope.lastReferencia = data.data.data;
        $scope.selectedAutores.selected = $scope.lastReferencia.autoresList;
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
                $scope.lastReferencia = data.data.data;
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
        $scope.selectedAutores.selected = $scope.lastReferencia.autoresList;
        $scope.selectedCategoria.selected = $scope.lastReferencia.categoriaList;
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