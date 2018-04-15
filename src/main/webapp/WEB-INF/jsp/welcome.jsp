<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %>
<%--@elvariable id="person" type="com.osa.loan.calc.model.Person"--%>
<%--@elvariable id="civil" type="java.util.List"--%>
<html lang="pl">
<head>
    <!-- Access the bootstrap Css like this,
        Spring boot will handle the resource mapping automcatically -->
    <link rel="stylesheet" type="text/css" href="webjars/bootstrap/3.3.7/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="webjars/jquery-ui/1.12.1/jquery-ui.min.css"/>

    <!--
	<spring:url value="/css/main.css" var="springCss" />
	<link href="${springCss}" rel="stylesheet" />
	 -->
    <c:url value="/css/main.css" var="jstlCss"/>
    <link href="${jstlCss}" rel="stylesheet"/>

    <script type="text/javascript" src="webjars/jquery/3.2.0/jquery.min.js"></script>
    <script type="text/javascript" src="webjars/jquery-ui/1.12.1/jquery-ui.min.js"></script>
    <script type="text/javascript" src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<nav class="navbar navbar-inverse">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">Creditworthiness calculator</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">Home</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container row">
    <div class="col-md-6">
        <c:url value="/question" var="questionUrl"/>
        <input type="hidden" id="questionUrl" value="${questionUrl}"/>
        <div class="starter-template">
            <h1>answer the questions:</h1>
            <c:url value="/count" var="formUrl"/>
            <%--@elvariable id="person" type="com.osa.loan.calc.model.Person"--%>
            <f:form modelAttribute="person" method="post" action="${formUrl}">

                <h2>Credit:</h2>
                <div class="form-group">
                    <f:label path="loan.price" data-question="amount-of-credit"/>
                    <f:input path="loan.price" cssClass="form-control" required="true"/>
                </div>
                <div class="form-group">
                    <f:label path="loan.currency" data-question="currency"/>
                        <%--@elvariable id="currencies" type="java.util.List"--%>
                    <f:select path="loan.currency" data-question="currency" items="${currencies}" cssClass="form-control"/>
                </div>
                <div class="form-group">
                    <f:label path="loan.period" data-question="term-loan"/>
                    <f:input path="loan.period" cssClass="form-control" required="true"/>
                </div>
                <div class="form-group">
                    <f:label path="loan.percentage" data-question="interest"/>
                    <f:input path="loan.percentage" cssClass="form-control" required="true"/>
                </div>

                <h2>Other monthly payments:</h2>
                <div class="form-group">
                    <f:label path="bills.estate" data-question="flat-fee"/>
                    <f:input path="bills.estate" cssClass="form-control"/>
                </div>
                <div class="form-group">
                    <f:label path="bills.living" data-question="cost-of-living
"/>
                    <f:input path="bills.living" cssClass="form-control"/>
                </div>
                <div class="form-group">
                    <f:label path="bills.insurance" data-question="and-insurance-premiums"/>
                    <f:input path="bills.insurance" cssClass="form-control"/>
                </div>
                <div class="form-group">
                    <f:label path="bills.otherLoans" data-question="other-loans"/>
                    <f:input path="bills.otherLoans" cssClass="form-control"/>
                </div>
                <div class="form-group">
                    <f:label path="bills.others" data-question="remaining-fees"/>
                    <f:input path="bills.others" cssClass="form-control"/>
                </div>

                <h2>Personal information</h2>
                <div class="form-group">
                    <f:label path="man" data-question="plec"/>
                    <div class="radio">
                        <label>
                            <f:radiobutton path="man" value="true"/>Man
                        </label>
                    </div>
                    <div class="radio">
                        <label>
                            <f:radiobutton path="man" value="false"/>Woman
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <f:label path="birthDay" data-question="date-of-birth"/>
                    <f:input path="birthDay" cssClass="form-control date-picker" required="true"/>
                </div>
                <div class="form-group">
                    <f:label path="monthlySalary" data-question="salary"/>
                    <f:input path="monthlySalary" cssClass="form-control"/>
                </div>
                <div class="form-group">
                    <f:label path="married" data-question="marital-status"/>
                    <f:select path="married" cssClass="form-control">
                        <%--@elvariable id="civilStates" type="java.util.List"--%>
                        <f:options items="${civilStates}" itemLabel="key" itemValue="value"/>
                    </f:select>
                </div>
                <div class="form-group ifMarried">
                    <f:label path="partnerBirthDay" data-question="date-birth-spouse"/>
                    <f:input path="partnerBirthDay" cssClass="form-control date-picker"/>
                </div>
                <div class="form-group ifMarried">
                    <f:label path="partnerMonthlySalary" data-question="salary-spouse"/>
                    <f:input path="partnerMonthlySalary" cssClass="form-control"/>
                </div>
                <div class="form-group">
                    <f:label path="children" data-question="children"/>
                    <f:input path="children" cssClass="form-control" type="number" min="0" required="true"/>
                </div>
                <div id="childrenBirthDays-section" class="form-group">
                    <f:label path="childrenBirthDays" data-question="date-birth-baby"/>
                    <input id="childrenBirthDays-prototype" class="form-control hidden"/>
                </div>
                <f:button id="submit" type="button" class="btn btn-success">Analyze</f:button>
            </f:form>
        </div>
    </div>

    <div class="col-md-6 hidden" id="verdict">
        <div class="row">
            <div class="col-md-11">
                <h1>The result of the analysis:</h1></div>
            <div class="col-md-1">
                <button id="cleanVerdict" type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
        </div>
        <ul id="points" class="list-group">
            <li class="list-group-item list-group-item-success">
                <span class="badge"></span>
                Positive
            </li>
            <li class="list-group-item list-group-item-warning">
                <span class="badge"></span>
                Warnings
            </li>
            <li class="list-group-item list-group-item-danger">
                <span class="badge"></span>
                negatives
            </li>
        </ul>

        <ul id="rules" class="list-group">
            <li class="list-group-item active">Running rules:</li>
        </ul>
    </div>
</div>

<c:url value="/js/main.js" var="jsUrl"/>
<script type="text/javascript" src="${jsUrl}"></script>
</body>

</html>