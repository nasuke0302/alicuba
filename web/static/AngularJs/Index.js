var appIndex = angular.module("AppIndex", ['datatables', 'datatables.bootstrap', 'ui.select']);
appIndex.controller("IndexController", function ($scope, $http, $window) {

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
    //Obtener Lista de Autores
    $http.get("autores/get").then(function (data) {
        $scope.allAutores = data.data.data;
    });
    //Obtener Listado de Categorias
    $http.get("categorias/get").then(function (data) {
        $scope.allCategorias = data.data.data;
    });
    //Obtener Lista de Fuentes de Informacion
    $http.get("index/getFuentes").then(function (data) {
        $scope.allFuentes = data.data.data;
    });
    //Crear o Editar Referencia
    $scope.createOrEditReferencia = function () {
        console.log($scope.selectedAutores.selected);
        $scope.referencia.idFuente = parseInt($scope.selectedFuente);
        $scope.referencia.autoresList = $scope.selectedAutores.selected;
        $scope.referencia.categoriaList = $scope.selectedCategoria.selected;
        $scope.referencia.idFuente = $scope.selectedFuente.selected;
        if ($scope.referencia.idReferencia === "") {
            $scope.referencia.fechaAd = new Date();
            $http.post("index/addReferencia", $scope.referencia, {}).then(function (res) {
                $scope.referencia = res.data.data;
                window.localStorage.setItem("referencia", JSON.stringify($scope.referencia));
            });
            $("#modalNuevaReferencia").modal("toggle");
            $window.location.href = "cna/gestionar";
        } else {
            $scope.referencia.fechaMod = new Date();
            $http.post("index/editReferencia", $scope.referencia, {});
            window.localStorage.setItem("referencia", JSON.stringify($scope.referencia));
            $("#modalNuevaReferencia").modal("toggle");
            $window.location.href = "cna/gestionar";
        }
    };
    // Eliminar Referencia
    $scope.eliminarReferencia = function () {
        $("#formModalEliminar").modal("toggle");
        $http.post("index/delete/" + $scope.referencia.idReferencia).then(function (r) {
            $window.alert(r.data.mensaje);
            //Obtener Listado de Referencias
            $http.get("index/getReferencias").then(function (data) {
                $scope.allReferencias = data.data.data;
            });
        });
    };
    //PONER EN BLANCO TODOS LOS CAMPOS DEL MODAL AL ABRIR
    $scope.abrirNuevoModal = function () {
        $scope.selectedAutores.selected = "";
        $scope.selectedCategoria.selected = "";
        $scope.selectedFuente.selected = $scope.allFuentes[0];
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
    $scope.abrirEditar = function (indice) {
        var a = $scope.allReferencias[indice];
        window.localStorage.setItem("referencia", JSON.stringify(a));
        $window.location.href = "cna/gestionar";
    };
    //Enviar Referencia al Modal Eliminar
    $scope.abrirEliminarModal = function (indice) {
        var a = $scope.allReferencias[indice];
        console.log(a);
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

    $scope.abrirModalAddAutor = function () {
        $scope.autor = {
            nombre: "",
            segundoNombre: "",
            apellidos: ""
        };
    };
    $scope.addAutor = function () {
        $http.post("autores/add", $scope.autor, {}).then(function (r) {
            $window.alert(r.data.mensaje);
            //Obtener Lista de Autores
            $http.get("autores/get").then(function (data) {
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
        $http.post("categorias/add", $scope.categoria, {}).then(function (r) {
            $window.alert(r.data.mensaje);
            //Obtener Lista de Categorias
            $http.get("categorias/get").then(function (data) {
                $scope.allCategorias = data.data.data;
            });
            $("#modalAddOrEditCategoria").modal("toggle");
        });
    };
});
appIndex.directive('allowOnlyNumbers', function () {
    return {
        restrict: 'A',
        link: function (scope, elm, attrs, ctrl) {
            elm.on('keydown', function (event) {
                var $input = $(this);
                var value = $input.val();
                value = value.replace(/[^0-9]/g, '');
                $input.val(value);
                if (event.which === 64 || event.which === 16) {
                    // to allow numbers  
                    return false;
                } else if (event.which >= 48 && event.which <= 57) {
                    // to allow numbers  
                    return true;
                } else if (event.which >= 96 && event.which <= 105) {
                    // to allow numpad number  
                    return true;
                } else if ([8, 13, 27, 37, 38, 39, 40].indexOf(event.which) > -1) {
                    // to allow backspace, enter, escape, arrows  
                    return true;
                } else {
                    event.preventDefault();
                    // to stop others  
                    //alert("Sorry Only Numbers Allowed");  
                    return false;
                }
            });
        }
    };
});  