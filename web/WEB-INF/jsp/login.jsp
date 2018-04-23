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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/login.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/magic/magic.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/validationengine/css/validationEngine.jquery.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/social-buttons/social-buttons.css" />
        <!--END PAGE LEVEL STYLES-->

        <!--MY SCRIPTS-->
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/ui-validate_1.2.3.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/Login.js"></script>
        <!--END MIS SCRIPTS-->
    </head>

    <body data-ng-controller="LoginController">
        <div class="container">
            <div class="text-center">
                <h1 class="text-success">AliCuba</h1>
                <a class="btn btn-social-icon btn-facebook" href="http://www.facebook.com"><i class="icon-facebook"></i></a>
                <a class="btn btn-social-icon btn-google-plus" href="http://www.plus.google.com"><i class="icon-google-plus"></i></a>
                <a class="btn btn-social-icon btn-linkedin" href="http://www.linkedin.com"><i class="icon-linkedin"></i></a>
                <a class="btn btn-social-icon btn-twitter" href="http://www.twitter.com"><i class="icon-twitter"></i></a>
            </div>
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
                                <span class="help-block">Usuario y/o contraseña incorrectos</span>
                            </c:if>
                        </div>
                        <button class="btn text-muted text-center btn-success" type="submit" data-ng-disabled="loginForm.$invalid">Acceder</button>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </form>
                </div>
                <div id="forgot" class="tab-pane">
                    <form action="index.html" class="form-signin">                
                        <p class="text-muted text-center btn-block btn btn-primary btn-rect">Usuario o correo electr&oacute;nico</p>
                        <input type="email"  required="required" placeholder=""  class="form-control" />
                        <br />
                        <button class="btn text-muted text-center btn-success" type="submit">Obtener una contrase&ntilde;a nueva</button>
                    </form>
                </div>
                <div id="signup" class="tab-pane">
                    <form action="addUsuarios" class="form-signin" method="post" name="registerForm">
                        <p class="text-muted text-center btn-block btn btn-primary btn-rect">Por favor llene los datos para el registro</p>
                        <input type="email" name="email" id="email" 
                               data-ng-model="usuario.email" placeholder="Correo electr&oacute;nico" class="form-control" required=""/>
                        <div data-ng-show="registerForm.email.$touched && registerForm.email.$invalid">
                            <small style="color:red; display: block; text-align: center;"> Introduzca un email v&aacute;lido</small>
                        </div>

                        <input type="text" name="nombre" id="nombre" 
                               data-ng-model="usuario.nombre" placeholder="Nombre" class="form-control" required=""/>
                        <div data-ng-show="registerForm.nombre.$touched && registerForm.nombre.$invalid">
                            <small style="color:red; display: block; text-align: center;">El campo nombre es requerido</small>
                        </div>

                        <input type="text" name="apellidos" id="apellidos" 
                               data-ng-model="usuario.apellidos" placeholder="Apellidos" class="form-control" required=""/>
                        <div data-ng-show="registerForm.apellidos.$touched && registerForm.apellidos.$invalid">
                            <small style="color:red; display: block; text-align: center;">El campo apellidos es requerido</small>
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
                </div>
            </div>
            <div class="text-center">
                <ul class="list-inline">
                    <li><a class="text-muted" href="#login" data-toggle="tab">Acceder</a></li>
                    <li><a class="text-muted" href="#forgot" data-toggle="tab">¿Has olvidado tu contrase&ntilde;a?</a></li>
                    <li><a class="text-muted" href="#signup" data-toggle="tab">Crear cuenta</a></li>
                </ul>
            </div>

        </div>

        <!-- PAGE LEVEL SCRIPTS -->
        <script src="${pageContext.request.contextPath}/static/plugins/jquery-2.0.3.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/plugins/bootstrap/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/js/login.js"></script>
        <!--END PAGE LEVEL SCRIPTS-->
    </body>
</html>