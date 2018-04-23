var estudioApp = angular.module('AppEstudio', ['ui.select']);
estudioApp.controller('EstudioController', function ($scope, $http) {
    $scope.selectedCalidad = "";
    $scope.selectedEpoca = "";
    $scope.selectedFertilizado = "";
    $scope.selectedMesIni = "";
    $scope.selectedMesFin = "";
    $scope.selectedNivelFert = "";
    $scope.selectedPais = {};
    $scope.selectedProvincia = "";
    $scope.selectedRangoEdad = "";
    $scope.allMetadatos = {
        idMetadatosAlimentosG: "",
        proceso: "",
        mezcla: "",
        riego: "",
        n: "",
        npk: "",
        fertOrg: "",
        edad: "",
        corte: "",
        tecnolog: "",
        presentation: "",
        otrasCaract: "",
        idAlimento: $scope.selectedAlimento,
        calidad: "",
        idEpoca: "",
        mesIni: "",
        idNivelFert: "",
        import1: "",
        idProvincia: "",
        idRangoEdades: "",
        idReferencia: "",
        tablaCnaGeneral: ""
    };
    $scope.selectedAlimento = {};
    //Obtener Lista de Alimentos
    $http.get("../alimentos/get").then(function (data) {
        $scope.allAlimentos = data.data.data;
    });

    //Obtener Lista de Metadatos
    $http.get("getMetadatos").then(function (data) {
        $scope.allMetadatos = data.data.data;
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

    $scope.addEstudio = function () {
        alert("asdasd")
    };
});

