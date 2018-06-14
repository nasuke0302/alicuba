<%-- 
    Document   : login
    Created on : 28-feb-2018, 0:45:37
    Author     : albert
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-ng-app="appLogin">
    <head>
        <!--GLOBAL STYLES AND TITLE-->
        <jsp:include page="/WEB-INF/includes/globalcss.jsp"/>
        <!--END GLOBAL STYLES-->
        <!--PAGE LEVEL STYLES-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/AngularJs/angular-datatables.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/AngularJs/loadingBar/loading-bar.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/login.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/magic/magic.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/validationengine/css/validationEngine.jquery.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/social-buttons/social-buttons.css" />
        <!--END PAGE LEVEL STYLES-->

        <!--MY SCRIPTS-->
        <script src="${pageContext.request.contextPath}/static/AngularJs/jQuery-3.3.1.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/jquery.dataTables.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular-datatables.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/loadingBar/loading-bar.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/ui-validate_1.2.3.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/Login.js"></script>
        <!--END MIS SCRIPTS-->
    </head>

    <body class="padTop53" data-ng-controller="LoginController">
        <div id="wrap">

            <!--BEGIN NAV BAR-->
            <div id="top">
                <nav class="navbar navbar-inverse navbar-fixed-top " style="padding-top: 10px;">
                    <a data-original-title="Show/Hide Menu" data-placement="bottom" 
                       data-tooltip="tooltip" class="accordion-toggle btn btn-primary btn-sm visible-xs" 
                       data-toggle="collapse" href="#menu" id="menu-toggle">
                        <i class="icon-align-justify"></i>
                    </a>
                    <!--LOGO SECTION--> 
                    <header class="navbar-header">
                        <a class="navbar-brand">
                            <img src="${pageContext.request.contextPath}/static/AlicubaLogoNav.png" style="width: 240px; height: 40px;"/>
                        </a>
                    </header>
                    <!--END LOGO SECTION--> 
                    <ul class="nav navbar-top-links navbar-right">
                        <!--ADMIN SETTINGS SECTIONS--> 
                        <li><a href="#login" data-toggle="tab" data-ng-click="showLogin1()">Acceder</a></li>
                        <li><a href="#signup" data-toggle="tab" data-ng-click="showRegister1()">Crear cuenta</a></li>
                        <li><a href="${pageContext.request.contextPath}/login/loginHelpPage">Ayuda y Contacto</a></li>
                        <!--END ADMIN SETTINGS SECTIONS--> 
                    </ul>
                </nav>
            </div>
            <!--END NAV BAR-->

            <!--BEGIN LEFT MENU-->
            <div id="left" data-ng-show="showTabla || showFormulas">
                <ul id="menu" class="collapse">
                    <li class="panel">
                        <a href="#" data-parent="#menu" data-toggle="collapse" class="accordion-toggle" data-target="#tablas-nav">
                            <i class="icon-table"></i> &Uacute;ltima Tabla Generada
                        </a>
                        <ul class="in" id="tablas-nav">
                            <a data-ng-click="showTabla1()">  <span>{{lastTablaGenerada.nombre}} - {{lastTablaGenerada.fechaHora}}</span></a>
                        </ul>
                        <a href="#" data-parent="#menu" data-toggle="collapse" class="accordion-toggle" data-target="#tablas-nav">
                            <i class="icon-table"></i> F&oacute;rmulas de Estimación
                        </a>
                        <ul class="in" id="tablas-nav">
                            <a data-ng-click="showFormulas1()"> Listar f&oacute;rmulas</a>
                        </ul>
                    </li>
                </ul>
            </div>
            <!--END LEFT MENU-->
            <!--BEGIN PAGE CONTENT-->
            <div id="content" data-ng-show="showTabla || showFormulas">
                <div class="inner" style="min-height:800px;">
                    <div class="row">
                        <div class="col-lg-12">
                            <br />
                            <div class="table-responsive" data-ng-show="showTabla">
                                <table datatable="ng" id="tablaCategorias" class="table table-bordered table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>Ver Datos</th>
                                            <th>Nombre Cient&iacute;fico</th>
                                            <th>Nombre Com&uacute;n</th>
                                            <th>Variedad</th>
                                            <th>Parte</th>
                                            <th>Proceso</th>
                                            <th>Mezcla</th>
                                            <th>Otros</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr data-ng-repeat="mg in allMetadatosGenerados track by $index">
                                            <td>
                                                <a class="btn btn-success" href="#tabla1"
                                                   data-ng-click="verDatos($index)">
                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                </a>
                                            </td>
                                            <td>{{mg.idAlimento.nombreCient}}</td>
                                            <td>{{mg.idAlimento.nombre}}</td>
                                            <td>{{mg.idAlimento.variedad}}</td>
                                            <td>{{mg.idAlimento.parte}}</td>
                                            <td>{{mg.idAlimento.proceso}}</td>
                                            <td>{{mg.idAlimento.mezcla}}</td>
                                            <td>
                                                {{mg.idEpoca.etiqueta}} - {{mg.fertilizado.etiqueta}} - 
                                                {{mg.calidad.etiqueta}} - {{mg.idNivelFert.etiqueta}} - 
                                                {{mg.idRangoEdades.etiqueta}} - {{mg.idRegion.etiqueta}} - 
                                                {{mg.import1.pais}}
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!--BEGIN ESTADISTICA ALIMENTOS-->
                            <div class="panel panel-default" data-ng-show="showTabla">
                                <div class="panel-heading"> 
                                    Alimento Seleccionado: 
                                </div>
                                <div class="panel-body">
                                    <strong>Nombre Cient&iacute;fico: </strong>
                                    {{metadatoGenerado.idAlimento.nombreCient}}
                                    <br />
                                    <strong>Nombre Com&uacute;n: </strong>
                                    {{metadatoGenerado.idAlimento.nombre}}
                                    <br />
                                    <strong>Variedad: </strong>
                                    {{metadatoGenerado.idAlimento.variedad}}
                                    <br />
                                    <strong>Parte: </strong>
                                    {{metadatoGenerado.idAlimento.parte}}
                                    <br />
                                    <strong>Proceso: </strong>
                                    {{metadatoGenerado.idAlimento.proceso}}
                                    <br />
                                    <strong>Mezcla: </strong>
                                    {{metadatoGenerado.idAlimento.mezcla}}
                                    <br />
                                    <strong>Otros: </strong>
                                    <em data-toggle="tooltip" data-placement="top" title="Presentaci&oacute;n">{{metadatoGenerado.presentation}}</em>-
                                    <em data-toggle="tooltip" data-placement="top" title="{{metadatoGenerado.idEpoca.nombre}}">{{metadatoGenerado.idEpoca.etiqueta}}</em> - 
                                    <em data-toggle="tooltip" data-placement="top" title="{{metadatoGenerado.fertilizado.fertilizado}}">{{metadatoGenerado.fertilizado.etiqueta}}</em> - 
                                    <em data-toggle="tooltip" data-placement="top" title="{{metadatoGenerado.calidad.calidad}}">{{metadatoGenerado.calidad.etiqueta}}</em> - 
                                    <em data-toggle="tooltip" data-placement="top" title="{{metadatoGenerado.idNivelFert.nivel}}">{{metadatoGenerado.idNivelFert.etiqueta}}</em> - 
                                    <em data-toggle="tooltip" data-placement="top" title="{{metadatoGenerado.idRangoEdades.rango}}">{{metadatoGenerado.idRangoEdades.etiqueta}}</em> - 
                                    <em data-toggle="tooltip" data-placement="top" title="{{metadatoGenerado.idRegion.region}}">{{metadatoGenerado.idRegion.etiqueta}}</em> - 
                                    <em data-toggle="tooltip" data-placement="top" title="Corte">{{metadatoGenerado.corte}}</em> - 
                                    <em data-toggle="tooltip" data-placement="top" title="Nitrógeno">{{metadatoGenerado.n}}</em> - 
                                    <em data-toggle="tooltip" data-placement="top" title="N-P-K">{{metadatoGenerado.npk}}</em> - 
                                    <em data-toggle="tooltip" data-placement="top" title="{{metadatoGenerado.import1.pais}}">{{metadatoGenerado.import1.alpha3}}</em> - 
                                    <em data-toggle="tooltip" data-placement="top" title="Tratamiento">{{metadatoGenerado.tratamiento}}</em> - 
                                    <em data-toggle="tooltip" data-placement="top" title="Tecnología">{{metadatoGenerado.tecnolog}}</em>
                                    <br />
                                    <table id="tabla1" class="table table-hover table-striped">
                                        <thead>
                                            <tr>
                                                <th>Nutriente</th>
                                                <th>Total</th>
                                                <th>M&iacute;nimo</th>
                                                <th>M&aacute;ximo</th>
                                                <th>Promedio</th>
                                                <th>Desviaci&oacute;n Est&aacute;ndar</th>
                                                <th>Varianza</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr data-ng-repeat="tc in metadatoGenerado.tablaCnaFinalList track by $index">
                                                <td title="{{tc.nutrientes.nombre}}">
                                                    {{tc.nutrientes.abreviatura}}
                                                    {{tc.nutrientes.idUnidadMedida.unidadMedida}}
                                                </td>
                                                <td>{{tc.total}}</td>
                                                <td>{{tc.minimo}}</td>
                                                <td>{{tc.maximo}}</td>
                                                <td>{{tc.promedio| limitTo: 4}}</td>
                                                <td>{{tc.desvEst| limitTo: 4 }}</td>
                                                <td>{{tc.varianza| limitTo: 4}}</td>
                                            </tr>
                                        </tbody>
                                    </table>                                    
                                </div>
                                <!--                                <div class="panel-footer"> 
                                                                    <a id="botonGenerar" data-ng-click="generarXLS()" class="btn btn-success">
                                                                        <i class="glyphicon glyphicon-export"></i>
                                                                        Exportar a Excel
                                                                    </a>
                                                                </div>-->
                            </div>
                            <!--END ESTADISTICA ALIMENTOS-->
                            <!--BEGIN TABLE FORMULAS-->
                            <div class="table-responsive" data-ng-show="showFormulas">
                                <table datatable="ng" class="table table-condensed table-hover">
                                    <thead>
                                        <tr>
                                            <th>Nombre</th>
                                            <th>Nutriente resultado</th>
                                            <th>F&oacute;rmula</th>
                                            <th>Variables</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr data-ng-repeat="f in allFormulas track by $index">
                                            <td>{{f.nombreFormula}}</td>
                                            <td>
                                                {{f.idNutriente.abreviatura}}, 
                                                <small>
                                                    {{f.idNutriente.nombre}}
                                                </small>
                                            </td>
                                            <td>{{f.formula}}</td>
                                            <td>
                                                <span data-ng-repeat="v in f.variablesList">
                                                    <strong> {{v.nombreVariable}}: </strong>
                                                    {{v.idNutriente.abreviatura}} - <small>{{v.idNutriente.nombre}}</small>
                                                </span>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!--END TABLE FORMULAS-->
                        </div>
                    </div>
                </div>
            </div>
            <!--END PAGE CONTENT-->
            <!--BEGIN LOGIN CONTENT-->
            <div class="container" data-ng-show="showLogin || showRegister">
                <div class="tab-content">
                    <div id="login" class="tab-pane active <c:if test="${param.error != null}"> has-error </c:if>">
                        <form action="${loginUrl}" class="form-signin" method="post" name="loginForm">
                            <a class="text-muted text-center btn-block btn btn-primary btn-rect" href="#signup" data-toggle="tab">
                                Por favor reg&iacute;strese</a>
                            <input type="email" id="username" name="username"
                                   data-ng-model="usuario.email" placeholder="email" 
                                   class="form-control" autofocus="" required=""/>
                            <div data-ng-show="loginForm.username.$touched && loginForm.username.$invalid">
                                <small style="color:red; display: block; text-align: center;"> Introduzca un email v&aacute;lido</small>
                            </div>

                            <input type="password" id="password" name="password" 
                                   data-ng-model="usuario.password" placeholder="password" 
                                   class="form-control" required=""/>
                            <div data-ng-show="loginForm.password.$touched && loginForm.password.$invalid">
                                <small style="color:red; display: block; text-align: center;"> Introduzca su contraseña</small>
                            </div>

                            <div class="text-center">
                                <c:if test="${param.error != null}">
                                    <span class="help-block">${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}</span>
                                </c:if>
                            </div>
                            <button class="btn text-muted text-center btn-success" type="submit" data-ng-disabled="loginForm.$invalid">Acceder</button>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </form>
                        <button class="btn text-muted text-center btn-success" data-ng-click="volver()">
                            <span class="glyphicon glyphicon-arrow-left"></span>
                            Volver</button>
                    </div>
                    <div id="signup" class="tab-pane">
                        <form action="addUsuarios" class="form-signin" method="post" name="registerForm">
                            <p class="text-muted text-center btn-block btn btn-primary btn-rect">Por favor llene los datos para el registro</p>
                            <input type="email" name="email" id="email" 
                                   data-ng-model="usuario.email" placeholder="Correo electr&oacute;nico" class="form-control" required=""/>
                            <div data-ng-show="registerForm.email.$touched && registerForm.email.$invalid">
                                <small style="color:red; display: block; text-align: center;"> Introduzca un email v&aacute;lido</small>
                            </div>

                            <input type="text" name="nombre" id="nombre" data-ng-pattern="/^[a-zA-ZÀ-ÿ\u00f1\u00d1]+(\s*[a-zA-ZÀ-ÿ\u00f1\u00d1]*)*[a-zA-ZÀ-ÿ\u00f1\u00d1]+$/"
                                   data-ng-model="usuario.nombre" placeholder="Nombre" class="form-control" required=""/>
                            <div data-ng-show="registerForm.nombre.$touched && registerForm.nombre.$invalid">
                                <small style="color:red; display: block; text-align: center;">El campo nombre es requerido</small>
                                <small style="color:red; display: block; text-align: center;">El campo nombre no admite carateres num&eacute;ricos o especiales</small>
                            </div>

                            <input type="text" name="apellidos" id="apellidos" data-ng-pattern="/^[a-zA-ZÀ-ÿ\u00f1\u00d1]+(\s*[a-zA-ZÀ-ÿ\u00f1\u00d1]*)*[a-zA-ZÀ-ÿ\u00f1\u00d1]+$/"
                                   data-ng-model="usuario.apellidos" placeholder="Apellidos" class="form-control" required=""/>
                            <div data-ng-show="registerForm.apellidos.$touched && registerForm.apellidos.$invalid">
                                <small style="color:red; display: block; text-align: center;">El campo apellidos es requerido</small>
                                <small style="color:red; display: block; text-align: center;">El campo apellidos no admite carateres num&eacute;ricos o especiales</small>
                            </div>

                            <input type="password" name="password" id="password"  
                                   data-ng-model="usuario.password"
                                   placeholder="Contrase&ntilde;a" class="form-control" required=""/>
                            <div data-ng-show="registerForm.password.$touched && registerForm.password.$invalid">
                                <small style="color:red; display: block; text-align: center;">El campo contraseña es requerido</small>
                            </div>

                            <input type="password" name="password2" id="password2" placeholder="Repetir Contrase&ntilde;a" 
                                   data-ng-model="usuario.password2" class="form-control" required=""
                                   ui-validate='"validarPasswords($value)"'
                                   ui-validate-watch="'usuario.password'"/>
                            <div data-ng-show="registerForm.password2.$empty">
                                <small style="color:red; display: block; text-align: center;">Este campo es requerido</small>
                            </div>
                            <div data-ng-show="registerForm.password2.$invalid
                                                    && !registerForm.password2.$validValidator">
                                <small style="color:red; display: block; text-align: center;">Las contraseñas no coinciden</small>
                            </div>

                            <button class="btn text-muted text-center btn-success form-control" type="submit"
                                    data-ng-disabled="registerForm.$invalid">Crear cuenta</button>
                        </form>
                        <button class="btn text-muted text-center btn-success" data-ng-click="volver()">
                            <span class="glyphicon glyphicon-arrow-left"></span>
                            Volver</button>
                    </div>
                </div>
            </div>
            <!--END LOGIN CONTENT-->
        </div>
        <div id="footer">
            <p>&copy;  AliCuba &nbsp;2018 &nbsp;</p>
        </div>
        <!-- PAGE LEVEL SCRIPTS -->
        <script src="${pageContext.request.contextPath}/static/plugins/jquery-2.0.3.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/plugins/bootstrap/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/js/login.js"></script>
        <script>
                                    if (Notification.permission === "default") {
                                        Notification.requestPermission(function (p) {
                                            if (p === "granted") {
                                                alert("Usted recibirá notificaciones de esta página");
                                            }
                                        });
                                    }

        </script>
        <!--END PAGE LEVEL SCRIPTS-->
    </body>
</html>
