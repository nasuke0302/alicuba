var appLogin = angular.module("appLogin", ['ui.validate', 'datatables', 'angular-loading-bar']);
appLogin.controller("LoginController", function ($scope, $http) {
    $scope.usuario = {
        password: ""
    };
    $scope.showLogin = false;
    $scope.showRegister = false;
    $scope.showTabla = true;
    $scope.showFormulas = false;
    $scope.lastTablaGenerada = {
        idListadoTablaGeneradas: ""
    };

    $scope.validarPasswords = function (value) {
        return value === $scope.usuario.password;
    };

    $scope.showLogin1 = function () {
        $scope.showLogin = true;
        $scope.showRegister = false;
        $scope.showTabla = false;
        $scope.showFormulas = false;
    };

    $scope.showFormulas1 = function () {
        $scope.showFormulas = true;
        $scope.showLogin = false;
        $scope.showRegister = false;
        $scope.showTabla = false;
    };

    $scope.showTabla1 = function () {
        $scope.showTabla = true;
        $scope.showLogin = false;
        $scope.showRegister = false;
        $scope.showFormulas = false;
    };

    $scope.showRegister1 = function () {
        $scope.showRegister = true;
        $scope.showLogin = false;
        $scope.showTabla = false;
        $scope.showFormulas = false;
    };

    $scope.volver = function(){
          $scope.showTabla1();
    };

    $scope.metadatoGenerado = {
        presentation: "",
        tratamiento: "",
        tecnolog: "",
        corte: "",
        npk: "",
        n: ""
    };

    //Obtener Lista de Tablas Generadas
    $http.get("tablasgeneradas/getLastTablaGenerada").then(function (data) {
        $scope.lastTablaGenerada = data.data.data;
        $http.get("./metadatosGenerados/getMetadatosGeneradosPorTablaGenerada/" + $scope.lastTablaGenerada.idListadoTablaGeneradas).then(function (res) {
            $scope.allMetadatosGenerados = res.data.data;
        });
    });

    $scope.verDatos = function (indice) {
        $scope.metadatoGenerado = $scope.allMetadatosGenerados[indice];
        if ($scope.metadatoGenerado.corte === '') {
            $scope.metadatoGenerado.corte = "SDCorte";
        }
        if ($scope.metadatoGenerado.npk === 'null-null-null') {
            $scope.metadatoGenerado.npk = "0-0-0";
        }
        if ($scope.metadatoGenerado.presentation === '') {
            $scope.metadatoGenerado.presentation = "SDPre";
        }
        if ($scope.metadatoGenerado.tratamiento === '') {
            $scope.metadatoGenerado.tratamiento = "SDTra";
        }
        if ($scope.metadatoGenerado.tecnolog === '') {
            $scope.metadatoGenerado.tecnolog = "SDTec";
        }
        if (!$scope.metadatoGenerado.n) {
            $scope.metadatoGenerado.n = "0";
        }
    };

    $http.get("estimacion/getFormulas").then(function (res) {
        $scope.allFormulas = res.data.data;
    });

    function fnExcelReport() {
        var tab_text = '<html xmlns:x="urn:schemas-microsoft-com:office:excel">';
        tab_text = tab_text + '<head><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet>';

        tab_text = tab_text + '<x:Name>Metadatos</x:Name>';

        tab_text = tab_text + '<x:WorksheetOptions><x:Panes></x:Panes><x:WorksheetOptions></x:ExcelWorkSheet>';
        tab_text = tab_text + '</x:ExcelWorksheets></x:ExcelWorkbook></xml></head><body>';

        tab_text = tab_text + "<table border='1px'>";
        tab_text = tab_text + $('#tabla1').html();
        tab_text = tab_text + '</table></body></html>';

        var data_type = 'data:application/vnd.ms-excel';

        $('#botonGenerar').attr('href', data_type + ', ' + encodeURIComponent(tab_text));
        $('#botonGenerar').attr('download', 'Reporte_metadatos.xls');
    }

    $scope.generarXLS = function () {
        fnExcelReport();
    };
});
