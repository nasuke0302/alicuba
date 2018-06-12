var appEstudio = angular.module('AppEstudio', ['ui.select', 'angular-loading-bar']);
function headerController($http, $scope) {
    //Obtener Lista de notificaciones
    $scope.noLeido = 0;
    $scope.allNotificaciones = {};
    $http.get("../header/getMessages").then(function (data) {
        $scope.allNotificaciones = data.data.data;
        for (var i = 0; i < $scope.allNotificaciones.length; i++) {
            if (!$scope.allNotificaciones[i].leido) {
                $scope.noLeido++;
            }
        }
    });

    $scope.newNotification = {};
    var socket = new SockJS("../websocket/configuration");
    var stompClient = Stomp.over(socket);
    var notify;
    stompClient.connect({}, function (frame) {
        stompClient.subscribe("/user/queue/enviar", function (res) {
            $scope.newNotification = JSON.parse(res.body);
            $scope.noLeido++;
            notify = new Notification($scope.newNotification.titulo, {
                body: $scope.newNotification.mensaje,
                icon: "/alicuba/static/IconWebSocket.png"});
        });

        stompClient.subscribe("/topic/notifications", function (res) {
            $scope.allNotificaciones.unshift(JSON.parse(res.body));
            $scope.newNotification = JSON.parse(res.body);
            $scope.noLeido++;
            notify = new Notification($scope.newNotification.titulo, {
                body: $scope.newNotification.mensaje,
                icon: "/alicuba/static/IconWebSocket.png"});
        });
    });
}
appEstudio.controller("headerController", headerController);
appEstudio.controller('EstudioController', function ($scope, $http, $window) {
    $scope.tablaCnaGeneral = {
        valor: "",
        idNutriente: "",
        idMetadatosAlimentosG: ""
    };
    $scope.oneTDA = {};
    $scope.npk = {
        n: "",
        p: "",
        k: ""
    };
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
    $scope.selectedTipoCuba = 22;
    $scope.selectedTipoFao = 10;
    $scope.selectedTipoNrc = 9;
    $scope.selectedCalidad = 6;
    $scope.selectedEpoca = 4;
    $scope.selectedFertilizado = 1;
    $scope.selectedMesIni = 13;
    $scope.selectedMesFin = 13;
    $scope.selectedNivelFert = 1;
    $scope.selectedPais = {
        selected: {idPaises: 895, pais: "Sin Definir", alpha2: "SDPais", alpha3: "SDPais"}
    };

    $scope.selectedProvincia = 17;
    $scope.selectedRangoEdad = 5;
    $scope.allNutrientes = {};
    $scope.selectedNutriente = {};
    $scope.selectedTDA = {};
    $scope.tablaCnaGeneralInsertada = [];
    $scope.estudioInsertado = false;
    $scope.tiposRiego = {
        tipo1: {
            valor: "Sí",
            etiqueta: "Rie"
        },
        tipo2: {
            valor: "No",
            etiqueta: "NoRie"
        },
        tipo3: {
            valor: "Sin definir riego",
            etiqueta: "SDRie"
        }
    };

    $scope.referencia = JSON.parse(window.localStorage.getItem("referencia"));
    //Obtener Lista de Nutrientes
    $http.get("getNutrientes").then(function (data) {
        $scope.allNutrientes = data.data.data;
    });
    //Obtener Lista de Alimentos
    $http.get("../alimentos/getAlimentos").then(function (data) {
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
        $http.post("../alimentos/addAlimento", $scope.alimento, {}).then(function (response) {
            $window.alert(response.data.mensaje);
            //Obtener Lista de Alimentos
            $http.get("../alimentos/getAlimentos").then(function (data) {
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
        $scope.estudio.npk = $scope.npk.n + "-" + $scope.npk.p + "-" + $scope.npk.k;
        $http.post("addEstudio", $scope.estudio, {}).then(function (response) {
            window.localStorage.setItem("metadato", JSON.stringify(response.data.data));
            $window.alert(response.data.mensaje);
            $scope.estudioInsertado = true;
        });
    };
    $scope.addTablaCnaGeneral = function () {
        $scope.tablaCnaGeneral.idNutriente = $scope.selectedNutriente.selected.idNutriente;
        $scope.tablaCnaGeneral.idMetadatosAlimentosG = JSON.parse(window.localStorage.getItem("metadato")).idMetadatosAlimentosG;
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
    };
    $scope.groupByNombreTipoDato = function (item) {
        return item.idTiposDatosAlimentos.nombreTipoDato;
    };
    $scope.refreshNutrientesList = function () {
        for (var i = 0; i < $scope.tablaCnaGeneralInsertada.length; i++) {
            $scope.allNutrientes.pop($scope.tablaCnaGeneralInsertada[i].nutriente);
        }
    };
});
appEstudio.directive('allowDecimalNumbers', function () {
    return {
        restrict: 'A',
        link: function (scope, elm, attrs, ctrl) {
            elm.on('keydown', function (event) {
                var $input = $(this);
                var value = $input.val();
                value = value.replace(/[^0-9\.]/g, '');
                $input.val(value);
                if (event.which === 64 || event.which === 16) {
                    // numbers  
                    return false;
                }
                if ([8, 13, 27, 37, 38, 39, 40, 110].indexOf(event.which) > -1) {
                    // backspace, enter, escape, arrows  
                    return true;
                } else if (event.which >= 48 && event.which <= 57) {
                    // numbers  
                    return true;
                } else if (event.which >= 96 && event.which <= 105) {
                    // numpad number  
                    return true;
                } else if ([46, 110, 190].indexOf(event.which) > -1) {
                    // dot and numpad dot  
                    return true;
                } else {
                    event.preventDefault();
                    return false;
                }
            });
        }
    };
});