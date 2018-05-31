var appCna = angular.module("AppCna", ['ui.select']);
function headerController($http, $scope) {
    //Obtener Lista de notificaciones
    $http.get("../header/getMessages").then(function (data) {
        $scope.allNotificaciones = data.data.data;
    });

    $scope.notifNoLeidas = function (item) {
        if (item.leido === "false") {
            return item;
        }
    };
    $scope.newNotification = {};
    var socket = new SockJS("../websocket/configuration");
    var stompClient = Stomp.over(socket);
    var notify;
    stompClient.connect({}, function (frame) {
        stompClient.subscribe("/user/queue/enviar", function (res) {
            $scope.newNotification = JSON.parse(res.body);
            notify = new Notification($scope.newNotification.titulo, {
                body: $scope.newNotification.mensaje,
                icon: "/alicuba/static/IconWebSocket.png"});
        });

        stompClient.subscribe("/topic/notifications", function (res) {
            $scope.allNotificaciones.unshift(JSON.parse(res.body));
            $scope.newNotification = JSON.parse(res.body);
            notify = new Notification($scope.newNotification.titulo, {
                body: $scope.newNotification.mensaje,
                icon: "/alicuba/static/IconWebSocket.png"});
        });
    });
}
appCna.controller("headerController", headerController);
appCna.controller("CnaController", function ($scope, $http, $window) {
    $scope.npk = {
        n: "",
        p: "",
        k: ""
    };
    $scope.selectedNutriente = {};
    //GENERAR AÑOS
    $scope.currentyear = new Date().getFullYear();
    $scope.years = [];
    for (var i = 1940; i < 2019; i++) {
        $scope.years.push(i);
    }
    //END GENERAR AÑOS
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
        arcPublication: "a.arcPublication",
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
    $scope.selectedNutriente = {};
    $scope.allNutrientes = {};
    $scope.tablaCnaGeneral = {
        valor: "",
        idNutriente: "",
        idMetadatosAlimentosG: ""
    };
    $scope.tiposRiego = {
        tipo1: "Sí",
        tipo2: "No",
        tipo3: "Sin definir"
    };

    $http.get("getEstudioPorReferencia/" + $scope.referencia.idReferencia).then(function (data) {
        $scope.estudioPorReferencia = data.data.data;
    });
    //Obtener Listado de Nutrientes
    $http.get("../estudio/getNutrientes").then(function (data) {
        $scope.allNutrientes = data.data.data;
    });
    //Obtener Listado de Categorias
    $http.get("../categorias/getCategorias").then(function (data) {
        $scope.allCategorias = data.data.data;
    });
    //Obtener Lista de Fuentes de Informacion
    $http.get("../index/getFuentes").then(function (data) {
        $scope.allFuentes = data.data.data;
    });
    //Obtener Lista de Autores
    $http.get("../autores/getAutores").then(function (data) {
        $scope.allAutores = data.data.data;
    });
    //Guardar referencia editada
    $scope.saveReferencia = function () {
        $scope.referenciaEdit.idFuente = $scope.selectedFuente.selected;
        $scope.referenciaEdit.autoresList = $scope.selectedAutores.selected;
        $scope.referenciaEdit.categoriaList = $scope.selectedCategoria.selected;
        $scope.referenciaEdit.fecha = $scope.selectedYear.selected;
        console.log($scope.referenciaEdit);
        $http.post("../index/editReferencia", $scope.referenciaEdit).then(function (r) {
            window.localStorage.setItem("referencia", JSON.stringify($scope.referenciaEdit));
            $scope.referencia = JSON.parse(window.localStorage.getItem("referencia"));
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
            fechaMod: new Date(),
            idUsuario: a.idUsuario
        };
    };
    //Enviar Autor al modal
    $scope.abrirModalAddAutor = function () {
        $scope.autor = {
            nombre: "",
            segundoNombre: "",
            apellidos: ""
        };
    };
    //Crear un nuevo autor
    $scope.addAutor = function () {
        $http.post("../autor/addAutor", $scope.autor, {}).then(function (r) {
            $window.alert(r.data.mensaje);
            //Obtener Lista de Autores
            $http.get("../autor/getAutores").then(function (data) {
                $scope.allAutores = data.data.data;
            });
            $("#modalAddOrEditAutor").modal("toggle");
        });
    };
    //Limpiar modal abrir categoria
    $scope.abrirModalAddCategoria = function () {
        $scope.categoria = {
            categoria: ""
        };
    };
    // Crear una nueva categoria
    $scope.addCategoria = function () {
        $http.post("../categorias/addCategoria", $scope.categoria, {}).then(function (r) {
            $window.alert(r.data.mensaje);
            //Obtener Lista de Categorias
            $http.get("../categorias/getCategorias").then(function (data) {
                $scope.allCategorias = data.data.data;
            });
            $("#modalAddOrEditCategoria").modal("toggle");
        });
    };
    //Eliminar un estudio
    $scope.eliminarEstudio = function () {
        $("#formModalEliminar").modal("toggle");
        $http.post("../estudio/deleteEstudio", $scope.estudioToDelete.tablaCnaGeneralPK, {}).then(function (res) {
            $window.alert(res.data.mensaje);
            $http.get("getEstudioPorReferencia/" + $scope.referencia.idReferencia).then(function (data) {
                $scope.estudioPorReferencia = data.data.data;
            });
        });
    };
    //Eliminar un alimento
    $scope.eliminarAlimento = function () {
        $("#formModalEliminarAlimento").modal("toggle");
        $http.delete("../estudio/deleteAlimentoMetadatos/" + $scope.metadato.idMetadatosAlimentosG, {}).then(function (res) {
            $window.alert(res.data.mensaje);
            $http.get("getEstudioPorReferencia/" + $scope.referencia.idReferencia).then(function (data) {
                $scope.estudioPorReferencia = data.data.data;
            });
        });
    };
    //Enviar estudio al modal eliminar
    $scope.abrirEliminarModal = function (indice1, indice2) {
        var a = $scope.estudioPorReferencia[indice1].tablaCnaGeneralList[indice2];
        $scope.estudioToDelete = {
            nutrientes: a.nutrientes,
            tablaCnaGeneralPK: a.tablaCnaGeneralPK,
            valor: a.valor
        };
    };
    //enviar alimento con metadato al modal
    $scope.abrirEliminarAlimentoModal = function (indice) {
        $scope.metadato = $scope.estudioPorReferencia[indice];
    };
    //Añadir un nuevo estudio
    $scope.addTablaCnaGeneral = function () {
        console.log($scope.tablaCnaGeneral.valor);
        $scope.tablaCnaGeneral.idNutriente = $scope.selectedNutriente.selected.idNutriente;
        $scope.tablaCnaGeneral.idMetadatosAlimentosG = $scope.metadatoActual.idMetadatosAlimentosG;
        $scope.tablaCnaGeneralPK = {
            idNutriente: $scope.tablaCnaGeneral.idNutriente,
            idMetadatosAlimentosG: $scope.tablaCnaGeneral.idMetadatosAlimentosG
        };
        $http.post("../estudio/addTablaCnaGeneral/" + $scope.tablaCnaGeneral.valor, $scope.tablaCnaGeneralPK, {}).then(function (data) {
            $window.alert(data.data.mensaje);
            $scope.tablaCnaGeneral.valor = "";
            $scope.selectedNutriente.selected = "";
            $http.get("getEstudioPorReferencia/" + $scope.referencia.idReferencia).then(function (data) {
                $scope.estudioPorReferencia = data.data.data;
                $("#formModalCreateNutriente").modal("toggle");
            });
        });
    };
    //Enviar alimento con metadato al modal para crear un estudio nuevo
    $scope.abrirNuevoNutrienteModal = function (indice) {
        $scope.metadatoActual = $scope.estudioPorReferencia[indice];
    };
    //Filtro para el select de nutriente para agrupar por TiposDatosAlimentos
    $scope.groupByNombreTipoDato = function (item) {
        return item.idTiposDatosAlimentos.nombreTipoDato;
    };
    //Editar un Nutriente
    $scope.editTablaCnaGeneral = function () {
        $http.post("../estudio/editTablaCnaGeneral/" + $scope.estudioToEdit.valor,
                $scope.estudioToEdit.tablaCnaGeneralPK, {}).then(function (res) {
            $window.alert(res.data.mensaje);
            $http.get("getEstudioPorReferencia/" + $scope.referencia.idReferencia).then(function (data) {
                $scope.estudioPorReferencia = data.data.data;
                $("#formModalEditNutriente").modal("toggle");
            });
        });
    };
    $scope.abrirEditarNutrienteModal = function (indice1, indice2) {
        var a = $scope.estudioPorReferencia[indice1].tablaCnaGeneralList[indice2];
        $scope.estudioToEdit = {
            nutrientes: a.nutrientes,
            tablaCnaGeneralPK: a.tablaCnaGeneralPK,
            valor: a.valor
        };
    };

    $scope.abrirModalEditarMetadatos = function (indice) {
        $http.get("../estudio/getCalidades").then(function (data) {
            $scope.allCalidades = data.data.data;
        });
        //Obtener Lista de Epocas
        $http.get("../estudio/getEpocas").then(function (data) {
            $scope.allEpocas = data.data.data;
        });
        //Obtener Lista de Fertilizado
        $http.get("../estudio/getFertilizado").then(function (data) {
            $scope.allFertilizado = data.data.data;
        });
        //Obtener Lista de Meses
        $http.get("../estudio/getMeses").then(function (data) {
            $scope.allMeses = data.data.data;
        });
        //Obtener Lista de Niveles de Fertilizacion
        $http.get("../estudio/getNivelFert").then(function (data) {
            $scope.allNivelFert = data.data.data;
        });
        //Obtener Lista de Paises
        $http.get("../estudio/getPaises").then(function (data) {
            $scope.allPaises = data.data.data;
        });
        //Obtener Lista de Provincias
        $http.get("../estudio/getProvincias").then(function (data) {
            $scope.allProvincias = data.data.data;
        });
        //Obtener Lista de Rango de Edades
        $http.get("../estudio/getRangoEdades").then(function (data) {
            $scope.allRangoEdades = data.data.data;
        });
        $scope.metadatoActual = $scope.estudioPorReferencia[indice];
        var npkDividido = $scope.metadatoActual.npk.toString().split("-");
        $scope.npk.n = parseInt(npkDividido[0]);
        $scope.npk.p = parseInt(npkDividido[1]);
        $scope.npk.k = parseInt(npkDividido[2]);
    };

    $scope.editMetadatosAlimentosG = function () {
        $scope.metadatoActual.npk = $scope.npk.n + "-" + $scope.npk.p + "-" + $scope.npk.k;
        $http.post("../estudio/editMetadatosAlimentosG", $scope.metadatoActual, {}).then(function (res) {
            $window.alert(res.data.mensaje);
            $scope.estudiosPorReferencia($scope.referencia.idReferencia);
            $("#formModalEditAlimento").modal("toggle");
        });
    };
});
appCna.directive('allowDecimalNumbers', function () {
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