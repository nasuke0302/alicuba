<%-- 
    Document   : header
    Created on : 10-mar-2018, 16:41:57
    Author     : albert
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="seg" uri="http://www.springframework.org/security/tags" %>
<script>
    appIndex.controller("HeaderController", function ($scope, $http) {

        $scope.notificaciones = [];
        $scope.AllNotifications = {
            fecha: "",
            leido: "",
            mensaje: "",
            receiver: "",
            sender: "",
            titulo: ""
        };
        //Obtener notificaciones
        $http.get("header/getMessages").then(function (res) {
            $scope.AllNotifications = res.data.data;
        });
    });</script>
<div id="top" data-ng-controller="HeaderController">
    <nav class="navbar navbar-inverse navbar-fixed-top " style="padding-top: 10px;">
        <a data-original-title="Show/Hide Menu" data-placement="bottom" 
           data-tooltip="tooltip" class="accordion-toggle btn btn-primary btn-sm visible-xs" 
           data-toggle="collapse" href="#menu" id="menu-toggle">
            <i class="icon-align-justify"></i>
        </a>
        <!--LOGO SECTION--> 
        <header class="navbar-header">
            <a href="${pageContext.request.contextPath}/helpPage" class="navbar-brand">
                <img src="${pageContext.request.contextPath}/static/AlicubaLogo.png" style="width: 100px; height: 36px;"/>
            </a>
        </header>
        <!--END LOGO SECTION--> 
        <ul class="nav navbar-top-links navbar-right">
            <!--EGIN NOTIFICATIONS SECTION-->
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <span class="label label-success">2</span>
                    <i class="icon-envelope-alt"></i>&nbsp; <i class="icon-chevron-down"></i>
                </a>
                <ul class="dropdown-menu dropdown-messages">
                    <li data-ng-repeat="notif in AllNotifications">
                        <a href="#">
                            <div>
                                <strong>{{notif.titulo}}</strong>
                                <span class="pull-right text-muted">
                                    <em>{{notif.fecha}}</em>
                                </span>
                            </div>
                            <div>{{notif.mensaje}}</div>
                        </a>
                    </li>
                    <li>
                        <div class="divider"></div>
                    </li>
                    <li>
                        <a class="text-center" href="#">
                            <strong>Leer Todos</strong>
                            <i class="icon-angle-right"></i>
                        </a>
                    </li>
                </ul>
            </li>
            <!--END NOTIFICATIONS SECTION-->
            <!--ADMIN SETTINGS SECTIONS--> 
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="icon-user "> <seg:authentication property="principal.username"></seg:authentication>${user}</i>&nbsp; <i class="icon-chevron-down "></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="${pageContext.request.contextPath}/editarPerfil/show"><i class="icon-user"></i> Editar mi perfil </a></li>
                    <!--<li class="divider"></li>-->
                    <li><a href="${pageContext.request.contextPath}/logout"><i class="icon-signout"></i> Cerrar Sesi&oacute;n</a></li>
                    <li class="divider"></li>
                    <li><a href="${pageContext.request.contextPath}/helpPage"><i class="icon-question"></i> Acerca de...</a></li>
                </ul>
            </li>
            <!--END ADMIN SETTINGS SECTIONS--> 
        </ul>
    </nav>
</div>
