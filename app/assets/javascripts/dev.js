$( document ).ready(function() {

    /* Autocompletar de mensajes - Redirecciona a la sección contactos si no encuentra resultados */
    $('#message_user_name').bind('autocompleteresponse', function(event, data){
        if(data.content[0].id == ""){
            message = "Sin resultados. Busca en contactos para poder enviar tu mensaje.";
            data.content[0].label = message;
            data.content[0].value = message;
//            $("ul.ui-autocomplete.ui-front.ui-menu.ui-widget.ui-widget-content li.ui-menu-item").text("SIN RESULTADOS");  // $("ul#ui-id-7") li#ui-id-27 ??
        }
    });
    /* Autocompletar de mensajes - Redirecciona a la sección contactos si no encuentra resultados */
    $('#message_user_name').bind('railsAutocomplete.select', function(event, data){
        if(data.item.id == ""){
            window.location=$("#js_url_for_empty_results").text();
        }
    });

    /* Autocompletar de contactos - Borra el texto si no ha sido modificado y/o no seleccionado de las opciones */
    $('.js-company-search').on('autocompletechange autocompleteclose', 'input.autocomplete', function(event, data){
        var hidden_field = $($(this).attr('data-id-element'));
        if (hidden_field.val() == '' ||
            hidden_field.attr('data-search') != $(this).val() ||
            hidden_field.attr('data-search') == ''
        ){
            hidden_field.val('');
            hidden_field.attr('data-search', '');
            $(this).val('');
        }
    });
    $('.js-company-search').on('autocompleteselect', 'input.autocomplete', function(event, data){
        $($(this).attr('data-id-element')).attr('data-search', data.item.value);
    });

    /* Funciones de la subida múltiple con Drag&Drop */
    if ($('.dropzone').length > 0) {
        // disable auto discover
        Dropzone.autoDiscover = false;


        var dropzone = new Dropzone (".dropzone", {
            maxFilesize: 3, // Set the maximum file size to 3 MB
            paramName: "archive[upload]", // Rails expects the file upload to be something like model[field_name]
            dictDefaultMessage: "Arrastra aquí las imágenes para subirlas",
//        dictFallbackMessage: "dictFallbackMessage",
            dictCancelUpload: "Cancelar",
            dictRemoveFile: "Eliminar",
            dictCancelUploadConfirmation: "¿Deseas cancelar la subida de la imagen?",
            dictFileTooBig: "El archivo es demasiado grande ({{filesize}}MB), el máximo permitido es {{maxFilesize}}MB.",
            addRemoveLinks: true
        });

        dropzone.on("success", function(file, response) {
//        this.removeFile(file)
//        $.getScript("/file_uploaders")
            // find the remove button link of the uploaded file and give it an id
            // based of the fileID response from the server
            $(file.previewTemplate).find('.dz-remove').attr('id', response.fileID);
            // add the dz-success class (the green tick sign)
            $(file.previewElement).addClass("dz-success");
        })

        dropzone.on("removedfile", function(file) {
            // grap the id of the uploaded file we set earlier
            var id = $(file.previewTemplate).find('.dz-remove').attr('id');

            // make a DELETE ajax request to delete the file
            $.ajax({
                type: 'DELETE',
                url: '/file_uploaders/' + id,
                success: function(data){
//                console.log(data.message);
                }
            })
        })
    }
    /* END Funciones de la subida múltiple con Drag&Drop */

    /* Cambio de cuenta */
    $("#switch_user_id").on('change', function(){
        document.location = $(this).val();
    })

    $masonry_grid = $('.masonry-grid').masonry({
        itemSelector: '.masonry-grid-item',
        percentPosition: true,
        columnWidth: '.masonry-grid-sizer'
    });
    setTimeout("$masonry_grid.masonry()", 1000);

});
