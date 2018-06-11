var appLogin = angular.module("appLogin", ['ui.validate', 'datatables', 'angular-loading-bar']);
appLogin.controller("LoginController", function ($scope, $http) {
    $scope.usuario = {
        password: ""
    };
    $scope.showLogin = false;
    $scope.lastTablaGenerada = {
        idListadoTablaGeneradas: ""
    };

    $scope.validarPasswords = function (value) {
        return value === $scope.usuario.password;
    };

    $scope.showLogin1 = function () {
        if ($scope.showLogin) {
            $scope.showLogin = false;
        } else {
            $scope.showLogin = true;
        }
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
    };
});
