
    $(document).ready(function(){ 
        var loc = window.location;
        var id = loc.pathname.substring(12, loc.pathname.lastIndexOf('.') + 0);

        console.log(id)
        $('.text-secondary').removeClass("text-secondary").addClass("text-white");
        var elem = document.getElementById(id);
        // agregar clase
        elem.classList.add('text-secondary'); 
    
        //eliminar clase
        elem.classList.remove('text-white');
    }) 