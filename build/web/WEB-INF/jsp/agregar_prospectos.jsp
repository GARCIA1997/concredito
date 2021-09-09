<%-- 
    Document   : agregar_prospectos
    Created on : 28/08/2021, 02:02:15 AM
    Author     : ISC_G
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/templates/header.jsp" %>
<div class="container">
    <br><br>
    <h1 class="text-center">Agregar Prospecto</h1>
    <br><br>
    <div  class="alert alert-danger hidden fade out" role="alert" id="alerta">
        
    </div>
    <form name="prospecto" id="prospecto">
        <div class="row">
            <div class="col-md-4">
                <label for="nombre" class="form-label">Nombre del prospecto</label>
                <input type="text" class="form-control" id="nombre" aria-describedby="name">
            </div>
            <div class="col-md-4">
                <label for="apellido_paterno" class="form-label">Apellido Paterno</label>
                <input type="text" class="form-control" id="apellido_paterno" aria-describedby="last_name">
            </div>
            <div class="col-md-4">
                <label for="apellido_materno" class="form-label">Apellido Materno</label>
                <input type="text" class="form-control" id="apellido_materno" aria-describedby="last_name">
            </div>
        </div>
        <div class="row">
           
            <div class="col-md-10">
                <label for="calle" class="form-label">Calle</label>
                <input type="text" class="form-control" id="calle" aria-describedby="address">
            </div>
            <div class="col-md-2">
                <label for="numero" class="form-label">N&uacute;mero</label>
                <input type="text" class="form-control" id="numero" aria-describedby="last_name">
            </div>
        </div>  
        <div class="row">
            
            <div class="col-md-3">
                <label for="colonia" class="form-label">Colonia</label>
                <input type="text" class="form-control" id="colonia" aria-describedby="address">
            </div>
            <div class="col-md-3">
                <label for="cp" class="form-label">C&oacute;digo Postal</label>
                <input  maxlength="5" type="text" class="form-control" id="cp" aria-describedby="address">
            </div>
       
            <div class="col-md-3">
                <label for="tel" class="form-label">Telefono</label>
                <input pattern="[1-9]{1}[0-9]{9}"  maxlength="10" type="text" class="form-control" id="tel" aria-describedby="tel">
            </div>
            <div class="col-md-3">
                <label for="rfc" class="form-label">RFC</label>
                <input type="text" maxlength="13" class="form-control" id="rfc" aria-describedby="last_name">
            </div>
        </div> 
        
        <div class="row justify-content-center" style="padding-top: 1.5rem;">
            <div class="col-lg-6 col-md-6 col-sm-6">
                <table class="table table-striped" id="tableDocumentos">
                    <thead>
                        <tr>
                            <th>Nombre del Documento</th>
                            <th style="cursor: pointer;" onclick="agregarFila();"> Agregar Documento<i class="bi bi-plus-circle-fill"></i> </th>
                        </tr>
                        <tbody id="tbodyDocuments">
                            <tr>
                                <td>
                                    <input type="text" class="form-control" name="nombreDocumento-1" id="nombreDocumento-1">
                                </td>
                                <td>
                                    <input type="file" onchange="addFile(1);" id="documento-1" name="documento-1">
                                </td>
                            </tr>
                        </tbody>
                    </thead>
                </table>
            </div>
        </div> 
        <div class="row justify-content-end">
            <div class="col-md-2 offset-md-10">
                <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#CerrarModal">
                  Salir
                </button>                
                <a onclick="setProspecto();"  class="btn btn-primary">Enviar</a>
            </div>
        </div>
        
        
    </form>
    
</div>
<!-- Modal Paara salir  -->
<div class="modal fade" id="CerrarModal" tabindex="-1" aria-labelledby="CerrarModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="CerrarModalLabel">Salir de Agregar Prospecto</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <p>S&iacute; usted desea salir los cambios realizados aqu&iacute; no seran guardados</p>
      </div>
      <div class="modal-footer">
        <a href="prospectos.htm" onclick="salirProspecto();" class="btn btn-danger">Salir</a>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
      </div>
    </div>
  </div>
</div>
<%@include file="/WEB-INF/jsp/templates/footer.jsp" %>
