<%-- 
    Document   : menuContent
    Created on : 10-mar-2018, 16:52:47
    Author     : albert
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="seg" uri="http://www.springframework.org/security/tags" %>

<div id="left">
    <ul id="menu" class="collapse">
        <li class="panel">
            <a href="#" data-parent="#menu" data-toggle="collapse" class="accordion-toggle" data-target="#captacion-nav">
                <i class="icon-table"></i> Captaci&oacute;n de Datos
                <span class="pull-right">
                    <i class="icon-angle-left"></i>
                </span>
            </a>
            <ul class="in" id="captacion-nav">
                <li><a href="${pageContext.request.contextPath}/index"><i class="icon-angle-right"></i> Referencias Bibliogr&aacute;ficas</a></li>
                <li><a href="${pageContext.request.contextPath}/alimentos/gestionar"><i class="icon-angle-right"></i> Alimentos </a></li>
            </ul>
        </li>
        <li class="panel ">
            <a href="#" data-parent="#menu" data-toggle="collapse" class="accordion-toggle" data-target="#component-nav">
                <i class="icon-tasks"> </i> Estimaci&oacute;n de Valores 
                <span class="pull-right">
                    <i class="icon-angle-left"></i>
                </span>
            </a>                    
        </li>
        <li class="panel">
            <a href="#" data-parent="#menu" data-toggle="collapse" class="accordion-toggle" data-target="#chart-nav">
                <i class="icon-bar-chart"> </i>Estad&iacute;sticas
                <span class="pull-right">
                    <i class="icon-angle-left"></i>
                </span>
            </a>
        </li>
        <li class="panel">
            <a href="#" data-parent="#menu" data-toggle="collapse" class="accordion-toggle" data-target="#DDL-nav">
                <i class=" icon-sitemap"></i> Manejo de Tablas
                <span class="pull-right">
                    <i class="icon-angle-left"></i>
                </span>
            </a>                    
        </li>
        <li class="panel">
            <a href="#" data-parent="#menu" data-toggle="collapse" class="accordion-toggle" data-target="#admin-nav">
                <i class="icon-key"></i> Administraci&oacute;n
                <span class="pull-right">
                    <i class="icon-angle-left"></i>
                </span>
            </a>
            <ul class="in" id="admin-nav">
                <li><a href="${pageContext.request.contextPath}/usuarios/gestionar"><i class="icon-angle-right"></i> Usuarios </a></li>
                <li><a href="${pageContext.request.contextPath}/roles/gestionar"><i class="icon-angle-right"></i> Roles </a></li>
            </ul>
        </li>
    </ul>
</div>
