<%-- 
    Document   : estimacionValores
    Created on : 23-may-2018, 10:54:00
    Author     : Tesis
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-ng-app="appEstimacion">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--GLOBAL STYLES AND TITLE-->
        <jsp:include page="/WEB-INF/includes/globalcss.jsp"/>
        <!--END GLOBAL STYLES-->

        <!--PAGE LEVEL STYLES-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/AngularJs/uiSelect/select.min.css">
        <!--END PAGE LEVEL STYLES-->

        <!--PAGE LEVEL SCRIPTS-->
        <script src="${pageContext.request.contextPath}/static/AngularJs/angular.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/uiSelect/select.min.js"></script>
        <script src="${pageContext.request.contextPath}/static/AngularJs/EstimacionValores.js"></script>
        <!--END PAGE LEVEL SCRIPTS-->
    </head>
    <body class="padTop53" data-ng-controller="EstimacionController">
        <!-- MAIN WRAPPER -->
        <div id="wrap">
            <!-- HEADER SECTION -->
            <jsp:include page="/WEB-INF/includes/header.jsp"/>
            <!-- END HEADER SECTION -->
            <!-- MENU SECTION -->
            <jsp:include page="/WEB-INF/includes/menuContent.jsp"/>
            <!--END MENU SECTION -->
            <!--PAGE CONTENT -->
            <div id="content">
                <div class="inner" style="min-height:1200px;">
                    <div class="row">
                        <div class="col-lg-12">
                            <br />
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <p>Estimar</p>
                                </div>
                                <div class="panel-body">
                                    <form method="post" data-ng-submit="parseExp()" name="formAddExp">
                                        <div class="col-md-2">Nutriente:</div>
                                        <div class="input-group col-md-10">F&oacute;rmula:</div>
                                        <div class="col-md-2">
                                            <ui-select data-ng-model="NutrienteResultado.selected" 
                                                       theme="bootstrap">
                                                <ui-select-match placeholder="Elija un nutriente...">
                                                    {{$select.selected.abreviatura}}
                                                </ui-select-match>
                                                <ui-select-choices repeat="a in allNutrientes| filter: $select.search">
                                                    {{a.abreviatura}}
                                                    <small>{{a.nombre}}</small>
                                                </ui-select-choices>
                                            </ui-select> 
                                        </div>
                                        <div class="input-group col-md-10">
                                            <input class="form-control" type="text" placeholder="Introduzca una f&oacute;rmula aqui"
                                                   data-ng-model="formula" required=""/>
                                        </div>
                                        <div class="row"></div>
                                        <div class="col-md-2"></div>
                                        <div class="row">
                                            <div class="col-md-1 text-right">
                                                X:
                                            </div>
                                            <div class="col-md-3">
                                                <ui-select data-ng-model="variables.x" 
                                                           theme="bootstrap">
                                                    <ui-select-match placeholder="Elija un nutriente...">
                                                        {{$select.selected.abreviatura}}
                                                    </ui-select-match>
                                                    <ui-select-choices repeat="a in allNutrientes| filter: $select.search">
                                                        {{a.abreviatura}}
                                                        <small>{{a.nombre}}</small>
                                                    </ui-select-choices>
                                                </ui-select> 
                                            </div>
                                        </div>
                                        <div class="col-md-2"></div>
                                        <div class="row">
                                            <div class="col-md-1 text-right">
                                                Y:
                                            </div>
                                            <div class="col-md-3">
                                                <ui-select data-ng-model="variables.y" 
                                                           theme="bootstrap">
                                                    <ui-select-match placeholder="Elija un nutriente...">
                                                        {{$select.selected.abreviatura}}
                                                    </ui-select-match>
                                                    <ui-select-choices repeat="a in allNutrientes| filter: $select.search">
                                                        {{a.abreviatura}}
                                                        <small>{{a.nombre}}</small>
                                                    </ui-select-choices>
                                                </ui-select> 
                                            </div>
                                        </div>
                                        <div class="text-right row col-md-12">
                                            <input class="btn btn-success" type="submit" value="Evaluar"
                                                   data-ng-disabled="formAddExp.$invalid || formAddExp.$pristine"/>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--END PAGE CONTENT -->
            </div>
            <!--END MAIN WRAP-->
            <jsp:include page="/WEB-INF/includes/footer.jsp"/>
            <jsp:include page="/WEB-INF/includes/globalScripts.jsp"/>
        </div>
    </body>
</html>
