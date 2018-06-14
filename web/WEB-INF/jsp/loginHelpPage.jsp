<%-- 
    Document   : LoginHelpPage
    Created on : 18-may-2018, 13:50:53
    Author     : Tesis
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html data-ng-app="appLoginHelpPage">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alicuba</title>
        <!--GLOBAL STYLES-->
        <link rel="stylesheet" href="<c:url value="/static/plugins/bootstrap/css/bootstrap.css"/>">
        <link rel="stylesheet" href="<c:url value="/static/css/main.css"/>">
        <link rel="stylesheet" href="<c:url value="/static/css/theme.css"/>">
        <link rel="stylesheet" href="<c:url value="/static/css/MoneAdmin.css"/>">
        <link rel="stylesheet" href="<c:url value="/static/plugins/Font-Awesome/css/font-awesome.css"/>">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/AngularJs/loadingBar/loading-bar.min.css">
        <!--END GLOBAL STYLES --> 
        <link rel="icon" href="${pageContext.request.contextPath}/static/favicon.png" type="image/png">
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/loadingBar/loading-bar.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/LoginHelpPage.js"></script>
    </head>
    <body data-ng-controller="LoginHelpPageController">
        <!--PAGE CONTENT -->
        <div class="text-center">
            <div class="inner" style="min-height:800px;">
                <div class="col-md-12">
                    <div class="row">
                        <section>
                            <div class="">
                                <img src="${pageContext.request.contextPath}/static/AlicubaLogo.png" style="width: 300px; height: 110px;"/>
                            </div>
                        </section>
                        <section style="background: #aef5ab">
                            <div class="col-lg-offset-5">
                                <ul class="pricing-table">
                                    <li class="col-lg-4 active success">
                                        <h3>Manual de Usuario Final</h3>
                                        <div class="price-body">
                                            <div class="price"><span class="glyphicon glyphicon-arrow-down"></span></div>
                                        </div>
                                        <div class="features">
                                            <ul>
                                                <li>Descubra Alicuba</li>
                                            </ul>
                                        </div>
                                        <div class="footer">
                                            <a href="${pageContext.request.contextPath}/static/Manual.pdf" class="btn btn-success btn-rect">DESCARGAR</a>
                                        </div>
                                    </li>
                                </ul>
                                <div class="clearfix"></div>
                            </div>
                        </section>
                        <br />
                        <br />
                        <div class="panel panel-default">
                            <div class="panel-heading">ADMINISTRADORES</div>
                            <div class="panel-body">
                                <ul class="pricing-table dark" data-ng-repeat="u in usuariosAdmins">
                                    <li class="col-lg-3">
                                        <h3>{{u.nombre}} {{u.apellidos}}</h3>
                                        <div class="features">
                                            <ul>
                                                <li>{{u.email}}</li>
                                            </ul>
                                        </div>
                                    </li>
                                </ul>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <br />
                        <br />
                        <div class="panel panel-default">
                            <div class="panel-heading">EDITORES</div>
                            <div class="panel-body">
                                <ul class="pricing-table" data-ng-repeat="u in usuariosEditores">
                                    <li class="col-lg-3">
                                        <h3>{{u.nombre}} {{u.apellidos}}</h3>
                                        <div class="features">
                                            <ul>
                                                <li>{{u.email}}</li>
                                            </ul>
                                        </div>
                                    </li>
                                </ul>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <br />
                        <br />
                        <div class="text-center">
                        <a class="btn btn-success col-md-2" href="${pageContext.request.contextPath}/login">
                            <span class="glyphicon glyphicon-arrow-left"></span> Regresar</a>
                        </div>
                        <br />
                        <br />
                    </div>
                </div>
            </div>
        </div>
        <!--END PAGE CONTENT-->
    </body>
</html>
