var appTrazas = angular.module("appTrazas", ['datatables', 'datatables.bootstrap', 'angular-loading-bar']);
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
appTrazas.controller("headerController", headerController);
appTrazas.controller("trazasController", function ($scope, $http) {
    $scope.allTrazas = {};
    //Obtener Lista de Trazas
    $http.get("getTrazas").then(function (data) {
        $scope.allTrazas = data.data.data;
    });

    function fnExcelReport() {
        var tab_text = '<html xmlns:x="urn:schemas-microsoft-com:office:excel">';
        tab_text = tab_text + '<head><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet>';

        tab_text = tab_text + '<x:Name>Trazas</x:Name>';

        tab_text = tab_text + '<x:WorksheetOptions><x:Panes></x:Panes><x:WorksheetOptions></x:ExcelWorkSheet>';
        tab_text = tab_text + '</x:ExcelWorksheets></x:ExcelWorkbook></xml></head><body>';

        tab_text = tab_text + "<table border='1px'>";
        tab_text = tab_text + $('#tablaTrazas').html();
        tab_text = tab_text + '</table></body></html>';

        var data_type = 'data:application/vnd.ms-excel';

        $('#botonGenerar').attr('href', data_type + ', ' + encodeURIComponent(tab_text));
        $('#botonGenerar').attr('download', 'Reporte_trazas.xls');
    }

    $scope.generarXLS = function () {
        fnExcelReport();
    };
});
