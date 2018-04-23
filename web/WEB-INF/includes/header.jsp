<%-- 
    Document   : header
    Created on : 10-mar-2018, 16:41:57
    Author     : albert
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="seg" uri="http://www.springframework.org/security/tags" %>

<div id="top">
    <nav class="navbar navbar-inverse navbar-fixed-top " style="padding-top: 10px;">
        <a data-original-title="Show/Hide Menu" data-placement="bottom" 
           data-tooltip="tooltip" class="accordion-toggle btn btn-primary btn-sm visible-xs" 
           data-toggle="collapse" href="#menu" id="menu-toggle">
            <i class="icon-align-justify"></i>
        </a>
        <!--LOGO SECTION--> 
        <header class="navbar-header">
            <a href="${pageContext.request.contextPath}/index" class="navbar-brand">AliCuba</a>
        </header>
        <!--END LOGO SECTION--> 
        <ul class="nav navbar-top-links navbar-right">
            <!--ADMIN SETTINGS SECTIONS--> 
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="icon-user "> <seg:authentication property="principal.username"></seg:authentication>${user}</i>&nbsp; <i class="icon-chevron-down "></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="${pageContext.request.contextPath}/editarPerfil/show"><i class="icon-user"></i> Editar mi perfil </a></li>
                    <li class="divider"></li>
                    <li><a href="${pageContext.request.contextPath}/logout"><i class="icon-signout"></i> Cerrar Sesi&oacute;n</a></li>
                </ul>
            </li>
            <!--END ADMIN SETTINGS--> 
        </ul>
    </nav>
</div>
