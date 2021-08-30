<%-- 
    Document   : prospectos
    Created on : 28/08/2021, 12:12:23 AM
    Author     : ISC_G
--%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
            <%@taglib  prefix="form" uri="http://www.springframework.org/tags/form" %>
                <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@include file="/WEB-INF/jsp/templates/header.jsp" %>
<div class="container">
    <br><br>
    <h1 class="text-center">Prospectos</h1>
    <h2>${holamundo}</h2>
    <br><br>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Nombre</th>
                <th>Primer Apellido</th>
                <th>Segundo Apellido</th>
                <th>Estatus</th>
                <th class="text-center">...</th>
            </tr>
            <tbody>
                <c:forEach items="${listProspectos}" var="p">
                    <tr>
                        <td>${p.nombre}</td>
                        <td>${p.apellido_paterno}</td>
                        <td>${p.apellido_materno}</td>
                        <td>${p.status}</td>                
                        <td class="text-center"> <button type="button" class="btn btn-primary" onclick="getDetalleProspecto(${p.id});"  data-bs-toggle="modal" data-bs-target="#ModalGetDetalleProspecto"><i class="bi bi-eye-fill"></i>Ver</button></td>                
                    </tr>
                </c:forEach>
            </tbody>
        </thead>
    </table>
</div>


<!--Modal para mostra el detalle del prospecto-->
<!-- Full screen modal -->


<div class="modal" id="ModalGetDetalleProspecto" tabindex="-1" aria-labelledby="ModalGetDetalleProspectoLabel" aria-hidden="true">
    <div class="modal-dialog  modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title text-center" id="ModalGetDetalleProspectoLabel">Prospecto</h5>
          <button type="button" data-bs-dismiss="modal" class="btn-close"  aria-label="Close"></button>
        </div>
        <div class="modal-body" >
            <div class="row">
                <div class="col-md-4">
                        <label for="name">Nombre</label>
                        <h5><span class="modalText" id="name"></span></h5>                   
                </div>
                <div class="col-md-3">
                    <label for="apellido_paterno">Apellido Paterno</label>
                    <h5><span class="modalText" id="apellido_paterno"></span></h5>                   
                </div>
                <div class="col-md-3">
                    <label for="apellido_materno">Apellido Materno</label>
                     <h5><span class="modalText" id="apellido_materno"></span></h5>                           
                </div>
                <div class="col-md-2">
                    <label for="status">Estatus</label>
                    <h5><span class="modalText" id="status"></span></h5>                   
                </div>
            </div>
            <div class="row">
                <div class="col-md-10">
                        <label for="calle">Calle</label>
                        <h5><span class="modalText" id="calle"></span></h5>                   
                </div>
                <div class="col-md-2">
                    <label for="numero">N&uacute;mero</label>
                    <h5><span class="modalText" id="numero"></span></h5>                   
                </div>
            </div>
            <div class="row">
                <div class="col-md-3">
                        <label for="colonia">Colonia</label>
                        <h5><span class="modalText" id="colonia"></span></h5>                   
                </div>
                <div class="col-md-3">
                    <label for="cp">CP</label>
                    <h5><span class="modalText" id="cp"></span></h5>                   
                </div>
                <div class="col-md-3">
                    <label for="tel">Telefono</label>
                    <h5><span class="modalText" id="tel"></span></h5>                   
                </div>
                <div class="col-md-3">
                    <label for="rfc">Rfc</label>
                    <h5><span class="modalText" id="rfc"></span></h5>                   
                </div>
            </div>
            <div class="row">
                <div class="col-md-12" id="divRechazado">
                    <label for="comentario">Motivo de Rechazo</label>
                    <h5><span class="modalText" id="comentario"></span></h5>                   
                </div>
            </div>
            <div class="row">
                Aqu&iacute; van los documentos
            </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
 
<%@include file="/WEB-INF/jsp/templates/footer.jsp" %>
