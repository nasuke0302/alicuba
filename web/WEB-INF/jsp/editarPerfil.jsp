<%-- 
    Document   : editarPerfil
    Created on : 08-mar-2018, 23:26:17
    Author     : albert
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-ng-app="appEditarPerfil">
    <head>
        <!--GLOBAL STYLES-->
        <jsp:include page="/WEB-INF/includes/globalcss.jsp"/>
        <!-- PAGE LEVEL STYLES -->
        <!--END PAGE LEVEL STYLES-->
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular.min.js"></script>        
        <script src="${pageContext.request.contextPath}/static/AngularJs/ui-validate_1.2.3.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/EditarPerfil.js"></script>
    </head>

    <body class="padTop53" data-ng-controller="EditarPerfilController">
        <!--MAIN WRAP-->
        <div id="wrap">
            <!-- HEADER SECTION -->
            <jsp:include page="/WEB-INF/includes/header.jsp"/>
            <!-- END HEADER SECTION -->
            <!-- MENU SECTION -->
            <jsp:include page="/WEB-INF/includes/menuContent.jsp"/>
            <!--END MENU SECTION -->
            <!--PAGE CONTENT -->
            <div id="content">
                <div class="inner" style="min-height:800px;">
                    <div>
                        <h1>Editar Perfil</h1>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <form data-ng-submit="updatePerfil()" method="post" name="formEditarPerfil">
                                <label>Email</label>
                                <input name="email" class="form-control" type="email" required=""
                                       id="email" data-ng-model="usuario.email"/>
                                <div data-ng-show="formEditarPerfil.email.$invalid">
                                    <small style="color:red; display: block; text-align: center;">
                                        ¡Este campo es requerido!
                                    </small>
                                </div>

                                <label>Nombre</label>
                                <input name="nombre" class="form-control" type="text" required=""
                                       data-ng-model="usuario.nombre"/>
                                <div data-ng-show="formEditarPerfil.nombre.$invalid">
                                    <small style="color:red; display: block; text-align: center;">
                                        ¡Este campo es requerido!
                                    </small>
                                </div>

                                <label>Apellidos</label>
                                <input name="apellidos" class="form-control" type="text" required=""
                                       data-ng-model="usuario.apellidos"/>
                                <div data-ng-show="formEditarPerfil.apellidos.$invalid">
                                    <small style="color:red; display: block; text-align: center;">
                                        ¡Este campo es requerido!
                                    </small>
                                </div>
                                <br />
                                <div class="text-right">
                                    <input class="btn btn-success" type="submit" value="Guardar Cambios"
                                           data-ng-disabled="formEditarPerfil.$invalid"/>
                                </div>
                            </form>
                            <br />
                            <div class="checkbox">
                                <label style="font-size: larger">
                                    <input class="checkbox" type="checkbox" id="changePass"
                                           data-ng-click="changePass()"/>Cambiar contrase&ntilde;a
                                </label>
                            </div>
                            <div id="divPasswordGroup" class="ng-hide">
                                <form name="FormCambiarPassword" data-ng-submit="cambiarPassword()">
                                    <label>Contrase&ntilde;a nueva</label>
                                    <input type="password" name="newPass" id="newPass" 
                                           data-ng-model="usuarioPassword.newPass"
                                           placeholder="Contrase&ntilde;a nueva" class="form-control" required=""/>
                                    <div data-ng-show="FormCambiarPassword.newPass.$touched && FormCambiarPassword.newPass.$invalid">
                                        <small style="color:red; display: block; text-align: center;">El campo contraseña es requerido</small>
                                    </div>

                                    <label>Confirmar contrase&ntilde;a nueva</label>
                                    <input type="password" name="confirmNewPass" id="confirmNewPass" 
                                           data-ng-model="usuarioPassword.confirmNewPass"
                                           placeholder="Confirmar Contrase&ntilde;a nueva" class="form-control" required=""
                                           ui-validate='"validarPasswords($value)"'
                                           ui-validate-watch="'usuario.newPass'"/>
                                    <div data-ng-show="FormCambiarPassword.confirmNewPass.$invalid
                                                            && !FormCambiarPassword.confirmNewPass.$validValidator">
                                        <small style="color:red; display: block; text-align: center;">Las contraseñas no coinciden</small>
                                    </div>
                                    <br />
                                    <div class="text-right">
                                        <input class="btn btn-success" type="submit" value="Actualizar contrase&ntilde;a"
                                               data-ng-disabled="FormCambiarPassword.$invalid"/>
                                    </div>
                                </form>
                            </div>
                            <br />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--END PAGE CONTENT -->
    </div>
    <!--END MAIN WRAP-->
    <!-- FOOTER -->
    <jsp:include page="/WEB-INF/includes/footer.jsp"/>
    <!--END FOOTER -->

    <!--GLOBAL SCRIPTS-->
    <jsp:include page="/WEB-INF/includes/globalScripts.jsp"/>
    <!--END PAGE LEVEL SCRIPTS-->
    <!--END PAGE LEVEL SCRIPTS-->
</body>
</html>
