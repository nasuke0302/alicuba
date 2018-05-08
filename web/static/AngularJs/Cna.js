var appCna = angular.module("AppCna", ['ui.select']);
appCna.controller("CnaController", function ($scope, $http, $window) {
//    GENERAR AÑOS
    $scope.currentyear = new Date().getFullYear();
    $scope.years = [];
    for (var i = 1940; i < 2019; i++) {
        $scope.years.push(i);
    }
//    END GENERAR AÑOS
    $scope.estudioToDelete = {
        nutrientes: "",
        tablaCnaGeneralPK: "",
        valor: ""
    };
    $scope.metadato = {};
    $scope.referencia = JSON.parse(window.localStorage.getItem("referencia"));
    $scope.referenciaEdit = {
        idReferencia: "",
        idFuente: "",
        url: "",
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
        idUsuario: ""
    };
    $scope.selectedYear = {};
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
        $scope.referenciaEdit.idFuente = $scope.selectedFuente.selected;
        $scope.referenciaEdit.autoresList = $scope.selectedAutores.selected;
        $scope.referenciaEdit.categoriaList = $scope.selectedCategoria.selected;
        $scope.referenciaEdit.fecha = $scope.selectedYear.selected;
        console.log($scope.referenciaEdit);
        $http.post("../index/editReferencia", $scope.referenciaEdit).then(function (r) {
            window.localStorage.setItem("referencia", JSON.stringify($scope.referenciaEdit));
            $window.alert(r.data.mensaje);
        });
        $("#modalNuevaReferencia").modal("toggle");
    };
    //nuevo estudio
    $scope.nuevoEstudio = function () {
        $window.location.href = "../estudio/gestionar";
    };
    //Enviar Referencia al Modal
    $scope.abrirEditarModal = function () {
        $scope.selectedFuente.selected = $scope.referencia.idFuente;
        $scope.selectedAutores.selected = $scope.referencia.autoresList;
        $scope.selectedCategoria.selected = $scope.referencia.categoriaList;
        $scope.selectedYear.selected = $scope.referencia.fecha;
        var a = $scope.referencia;
        $scope.referenciaEdit = {
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

    $scope.eliminarEstudio = function () {
        $("#formModalEliminar").modal("toggle");
        $http.post("../estudio/deleteEstudio", $scope.estudioToDelete.tablaCnaGeneralPK, {}).then(function (res) {
            $window.alert(res.data.mensaje);
            $http.get("getEstudioPorReferencia/" + $scope.referencia.idReferencia).then(function (data) {
                $scope.estudioPorReferencia = data.data.data;
            });
        });
    };

    $scope.eliminarAlimento = function () {
        $("#formModalEliminarAlimento").modal("toggle");
        $http.delete("../estudio/deleteAlimentoMetadatos/" + $scope.metadato.idMetadatosAlimentosG, {}).then(function (res) {
            $window.alert(res.data.mensaje);
            $http.get("getEstudioPorReferencia/" + $scope.referencia.idReferencia).then(function (data) {
                $scope.estudioPorReferencia = data.data.data;
            });
        });
    };

    $scope.abrirEliminarModal = function (indice1, indice2) {
        console.log($scope.estudioPorReferencia);
        var a = $scope.estudioPorReferencia[indice1].tablaCnaGeneralList[indice2];
        $scope.estudioToDelete = {
            nutrientes: a.nutrientes,
            tablaCnaGeneralPK: a.tablaCnaGeneralPK,
            valor: a.valor
        };
        console.log($scope.estudioToDelete);
    };

    $scope.abrirEliminarAlimentoModal = function (indice) {
        $scope.metadato = $scope.estudioPorReferencia[indice];
    };

    $scope.editarMetadatos = function (indice) {
        $scope.metadato = $scope.estudioPorReferencia[indice];
        window.localStorage.setItem("metadato", JSON.stringify($scope.metadato));
        $window.location.href = "../estudio/gestionar";
    };
});