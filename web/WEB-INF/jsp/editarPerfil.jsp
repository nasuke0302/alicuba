<%-- 
    Document   : editarPerfil
    Created on : 08-mar-2018, 23:26:17
    Author     : albert
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="seg" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
    <head>
        <!--GLOBAL STYLES-->
        <jsp:include page="/WEB-INF/includes/globalcss.jsp"/>

        <!-- PAGE LEVEL STYLES -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap-fileupload.min.css" />
        <!--END PAGE LEVEL STYLES-->
    </head>

    <body class="padTop53">
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
                    <form action="updatePerfil" method="post">
                        <div class="row">
                            <div class="col-md-6">
                                <label>Nombre</label>

                                <input class="form-control"/>
                                <label>Apellidos</label>
                                <input class="form-control"/>
                                <h2>Modificar Contraseña</h2>
                                <label>Contraseña Actual</label>
                                <input class="form-control">
                                <label>Contraseña Nueva</label>
                                <input class="form-control">
                                <label>Repetir Contraseña Nueva</label>
                                <input class="form-control">
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label col-lg-4">Foto de Perfil(Opcional)</label>
                                    <div class="col-lg-8">
                                        <div class="fileupload fileupload-new" data-provides="fileupload">
                                            <div class="fileupload-new thumbnail" style="width: 200px; height: 150px;"><img src="${pageContext.request.contextPath}/static/img/demoUpload.jpg" alt=""></div>
                                            <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 200px; max-height: 150px; line-height: 20px;"></div>
                                            <div>
                                                <span class="btn btn-file btn-primary"><span class="fileupload-new">Seleccionar imagen</span><span class="fileupload-exists">Cambiar</span><input type="file"></span>
                                                <a href="#" class="btn btn-danger fileupload-exists" data-dismiss="fileupload">Eliminar</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br/><br/><br/>
                        <div class="text-right">
                            <input class="btn btn-success" type="submit" value="Guardar Cambios"/>
                        </div>
                    </form>
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
    <script src="${pageContext.request.contextPath}/static/plugins/jasny/js/bootstrap-fileupload.js"></script>
    <!--END PAGE LEVEL SCRIPTS-->
</body>
</html>
