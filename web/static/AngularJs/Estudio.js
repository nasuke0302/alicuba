var estudioApp = angular.module('AppEstudio', ['ui.select']);
estudioApp.controller('EstudioController', function ($scope, $http, $window) {
    $scope.tablaCnaGeneralInsertada = [];
    $scope.nutrienteInsertado = [];
    $scope.estudioInsertado = false;
    $scope.tablaCnaGeneral = {
        valor: "",
        idNutriente: "",
        idMetadatosAlimentosG: ""
    };
    $scope.oneTDA = {};
    $scope.alimento = {
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
    $scope.selectedAlimento = {};
    $scope.estudio = {
        idMetadatosAlimentosG: "",
        idReferencia: "",
        idAlimento: "",
        idProvincia: "",
        idEpoca: "",
        mesIni: "",
        mesFin: "",
        idNivelFert: "",
        idRangoEdades: "",
        riego: "",
        n: "",
        npk: "",
        edad: "",
        corte: "",
        tecnolog: "",
        tratamiento: "",
        presentation: "",
        otrasCaract: "",
        calidad: "",
        import1: "",
        fertilizado: "",
        tablaCnaGeneral: ""
    };
    $scope.selectedTipoCuba = 22;
    $scope.selectedTipoFao = 10;
    $scope.selectedTipoNrc = 9;
    $scope.selectedCalidad = 6;
    $scope.selectedEpoca = 4;
    $scope.selectedFertilizado = 1;
    $scope.selectedMesIni = 1;
    $scope.selectedMesFin = 2;
    $scope.selectedNivelFert = 1;
    $scope.selectedPais = {};
    $scope.selectedProvincia = 17;
    $scope.selectedRangoEdad = 5;
    $scope.allNutrientes = {};
    $scope.selectedNutriente = {};
    $scope.selectedTDA = {};

    $scope.referencia = JSON.parse(window.localStorage.getItem("referencia"));
    //Obtener Lista de Nutrientes
    $http.get("getNutrientes").then(function (data) {
        $scope.allNutrientes = data.data.data;
    });
    //Obtener Lista de Alimentos
    $http.get("../alimentos/get").then(function (data) {
        $scope.allAlimentos = data.data.data;
    });
    //Obtener Lista de Calidades
    $http.get("getCalidades").then(function (data) {
        $scope.allCalidades = data.data.data;
    });
    //Obtener Lista de Epocas
    $http.get("getEpocas").then(function (data) {
        $scope.allEpocas = data.data.data;
    });
    //Obtener Lista de Fertilizado
    $http.get("getFertilizado").then(function (data) {
        $scope.allFertilizado = data.data.data;
    });
    //Obtener Lista de Meses
    $http.get("getMeses").then(function (data) {
        $scope.allMeses = data.data.data;
    });
    //Obtener Lista de Niveles de Fertilizacion
    $http.get("getNivelFert").then(function (data) {
        $scope.allNivelFert = data.data.data;
    });
    //Obtener Lista de Paises
    $http.get("getPaises").then(function (data) {
        $scope.allPaises = data.data.data;
    });
    //Obtener Lista de Provincias
    $http.get("getProvincias").then(function (data) {
        $scope.allProvincias = data.data.data;
    });
    //Obtener Lista de Rango de Edades
    $http.get("getRangoEdades").then(function (data) {
        $scope.allRangoEdades = data.data.data;
    });
    //Obtener Lista de Tipos de Datos de Alimentos
    $http.get("getTipoDatosAlimentos").then(function (data) {
        $scope.allTipoDatosAlimentos = data.data.data;
    });
    //Obtener Lista de Unidades de Medida
    $http.get("getUnidadesMedida").then(function (data) {
        $scope.allUnidadesMedida = data.data.data;
    });
    //Obtener Lista de TipoCuba
    $http.get("../alimentos/getAllTipoCuba").then(function (data) {
        $scope.allTipoCuba = data.data.data;
    });
    //Obtener Lista de TipoFAO
    $http.get("../alimentos/getAllTipoFao").then(function (data) {
        $scope.allTipoFao = data.data.data;
    });
    //Obtener Lista de TipoNrc
    $http.get("../alimentos/getAllTipoNrc").then(function (data) {
        $scope.allTipoNrc = data.data.data;
    });
    //TODOS LOS METADATOS PARA VER
    $scope.allMetadatos = {};
    $http.get("getMetadatos").then(function (data) {
        $scope.allMetadatos = data.data.data;
    });
    //Crear Alimento
    $scope.createNuevoAlimento = function () {
        $("#modalNuevoAlimento").modal("toggle");
        $scope.alimento.idTipoCuba = $scope.selectedTipoCuba;
        $scope.alimento.idTipoFao = $scope.selectedTipoFao;
        $scope.alimento.idTipoNrc = $scope.selectedTipoNrc;
        $http.post("addAlimento", $scope.alimento, {}).then(function (response) {
            $window.alert(response.data.mensaje);
            //Obtener Lista de Alimentos
            $http.get("../alimentos/get").then(function (data) {
                $scope.allAlimentos = data.data.data;
            });
        });
    };
    //Crear Estudio
    $scope.addEstudio = function () {
        $scope.estudio.idAlimento = $scope.selectedAlimento.selected.idAlimento;
        $scope.estudio.calidad = $scope.selectedCalidad;
        $scope.estudio.idEpoca = $scope.selectedEpoca;
        $scope.estudio.fertilizado = $scope.selectedFertilizado;
        $scope.estudio.mesIni = $scope.selectedMesIni;
        $scope.estudio.mesFin = $scope.selectedMesFin;
        $scope.estudio.idNivelFert = $scope.selectedNivelFert;
        $scope.estudio.import1 = $scope.selectedPais.selected;
        $scope.estudio.idProvincia = $scope.selectedProvincia;
        $scope.estudio.idRangoEdades = $scope.selectedRangoEdad;
        $scope.estudio.idReferencia = $scope.referencia.idReferencia;
        $http.post("addEstudio", $scope.estudio, {}).then(function (response) {
            $window.alert(response.data.mensaje);
            $scope.estudioInsertado = true;
        });
    };
    $scope.addTablaCnaGeneral = function () {
        $scope.lastEstudioId = {};

        $http.get("getLastEstudio").then(function (data) {
            $scope.lastEstudioId = data.data.data;
            $scope.tablaCnaGeneral.idNutriente = $scope.selectedNutriente.selected.idNutriente;
            $scope.tablaCnaGeneral.idMetadatosAlimentosG = $scope.lastEstudioId.idMetadatosAlimentosG;

            $scope.tablaCnaGeneralPK = {
                idNutriente: $scope.tablaCnaGeneral.idNutriente,
                idMetadatosAlimentosG: $scope.tablaCnaGeneral.idMetadatosAlimentosG
            };

            $http.post("addTablaCnaGeneral/" + $scope.tablaCnaGeneral.valor, $scope.tablaCnaGeneralPK, {}).then(function (data) {
                $window.alert(data.data.mensaje);

                $scope.tablaCnaGeneral.valor = "";
                $scope.selectedNutriente.selected = "";
                $scope.tablaCnaGeneralInsertada.push(data.data);
            });
        });
    };

    $scope.groupByNombreTipoDato = function (item) {
        return item.idTiposDatosAlimentos.nombreTipoDato;
    };
});