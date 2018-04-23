var appLogin = angular.module("appLogin", ['ui.validate']);
appLogin.controller("LoginController", function ($scope, $http) {
    $scope.usuario = {
        password: ""
    };
    $scope.validarPasswords = function (value) {
        return value === $scope.usuario.password;
    };
});
